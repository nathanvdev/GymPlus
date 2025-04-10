import { Request, Response } from "express";
import { Sale, SaleItem } from "../models/sales";
import { member } from "../models/member";
import { Product } from "../models/product";
import { logRequest, logError } from "../utilities/logs";

export const addSale = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { total, admin_id, items, status } = req.body;

    if (!total || !admin_id || !items || !Array.isArray(items)) {
        return res.status(400).json({
            msg: 'Datos de entrada inválidos'
        });
    }

    try {
        for (const item in items) {
            const product = await Product.findByPk(items[item].id);
            if (!product) {
                return res.status(400).json({
                    msg: 'Producto no encontrado'
                });
            }

            if (product.getDataValue('stock') < items[item].quantity) {
                return res.status(400).json({
                    msg: 'No hay suficiente stock del producto ' + product.getDataValue('name')
                });
            }
        }

        const sale = await Sale.create({
            total,
            admin_id,
            status
        });
        const sale_id = sale.getDataValue('id');

        const saleItemsPromises = items.map((item: any) => {
            return SaleItem.create({
                sale_id: sale_id,
                product_id: item.id,
                price: item.price,
                quantity: item.quantity
            });
        });

        await Promise.all(saleItemsPromises);

        for (const item of items) {
            const product = await Product.findByPk(item.id);
            if (product) {
                await product.update({
                    stock: product.getDataValue('stock') - item.quantity
                });
            }
        }

        res.status(200).json({
            sale
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
};

export const getSales = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    try {
        const sales = await Sale.findAll();

        for (let i = 0; i < sales.length; i++) {
            const autorizedBy = await member.findByPk(sales[i].getDataValue('admin_id'));
            sales[i].setDataValue('autorizedBy', autorizedBy ? autorizedBy.getDataValue('name') : 'N/A');
        }

        res.status(200).json({
            sales
        });
    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}

export const deleteSale = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { id } = req.params

    try {
        const sale = await Sale.findByPk(id);


        if (!sale) {
            return res.status(404).json({
                msg: 'Venta no encontrada'
            });
        }

        var Items = await SaleItem.findAll({
            where: {
                sale_id: id
            }
        });


        for (const item of Items) {
            const product = await Product.findByPk(item.dataValues.product_id);
            if (product) {
                await product.update({
                    stock: product.getDataValue('stock') + item.dataValues.quantity
                });
            }
        }

        await sale.update({
            status: 3
        });

        res.status(200).json({
            msg: 'Venta eliminada'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}