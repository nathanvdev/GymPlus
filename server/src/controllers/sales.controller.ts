import { Request, Response } from "express";
import { Sale, SaleItem } from "../models/sales";
import member from "../models/member";

export const addSale = async (req: Request, res: Response) => {
    const { total, admin_id, items } = req.body;

    if (!total || !admin_id || !items || !Array.isArray(items)) {
        return res.status(400).json({
            msg: 'Datos de entrada inválidos'
        });
    }

    try {
        const sale = await Sale.create({
            total,
            admin_id
        });
        const sale_id = sale.getDataValue('id');

        const saleItemsPromises = items.map((item: any) => {
            return SaleItem.create({
                sale_id: sale_id,
                product_name: item.product_name,
                price: item.price,
                quantity: item.quantity
            });
        });

        await Promise.all(saleItemsPromises);

        res.status(200).json({
            sale
        });

    } catch (error) {
        res.status(500).json({
            msg: 'Error en el servidor',
        });
        console.error(error);
    }
};

export const getSales = async (_: Request, res: Response) => {
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
        res.status(500).json({
            msg: 'Error en el servidor',
        });
        console.error(error);
    }
}

export const deleteSale = async (req: Request, res: Response) => {
    const { id } = req.params

    try {
        const sale = await Sale.findByPk(id);


        if (!sale) {
            return res.status(404).json({
                msg: 'Venta no encontrada'
            });
        }

        var Items = SaleItem.findAll({
            where: {
                sale_id: id
            }
        });

        await Promise.all((await Items).map(async (item) => {
            await item.destroy();
        }));
//TODO  await Items.destroy();

        await sale.destroy();

        res.status(200).json({
            msg: 'Venta eliminada'
        });

    } catch (error) {
        res.status(500).json({
            msg: 'Error en el servidor',
        });
        console.error(error);
    }
}