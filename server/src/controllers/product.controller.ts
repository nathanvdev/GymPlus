import { Request, Response } from "express";
import { Product } from "../models/product";

export const getProducts = async (_: Request, res: Response) => {

    try {
        const products = await Product.findAll();

        res.status(200).json({
            products
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }

}