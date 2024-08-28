import { Request, Response } from "express";
import { Sale, SaleItem } from "../models/sales";

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
    }};