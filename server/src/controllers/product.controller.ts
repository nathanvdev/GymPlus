import { Request, Response } from "express";
import { Product } from "../models/product";
import { logRequest, logError } from "../utilities/logs";

export const getProducts = async (req: Request, res: Response) => {
    logRequest(req); // Log the request

    try {
        const products = await Product.findAll();
        res.status(200).json({
            products
        });
        return;
    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}

export const addProduct = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
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
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}

export const editProduct = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
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
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}

export const deleteProduct = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
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
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}