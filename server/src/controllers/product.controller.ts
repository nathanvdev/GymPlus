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

export const addProduct = async (req: Request, res: Response) => {

    const { name, price, stock, imageurl } = req.body;

    try {
        const product = await Product.create({
            name,
            price,
            stock,
            imageurl
        });
        res.status(200).json({
            product
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }

}

export const editProduct = async (req: Request, res: Response) => {

    const { id } = req.params;
    const { name, price, stock, imageurl } = req.body;

    try {
        const product = await Product.findByPk(id);

        if (!product) {
            return res.status(404).json({
                msg: 'Producto no encontrado'
            });
        }

        await product.update({
            name,
            price,
            stock,
            imageurl
        });

        res.status(200).json({
            product
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }

}

export const deleteProduct = async (req: Request, res: Response) => {

    const { id } = req.params;

    try {
        const product = await Product.findByPk(id);

        if (!product) {
            return res.status(404).json({
                msg: 'Producto no encontrado'
            });
        }
        await product.destroy();

        res.status(200).json({
            msg: 'Producto eliminado'
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }

}