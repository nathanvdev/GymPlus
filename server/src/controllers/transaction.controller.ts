import { Request, Response } from "express";
import { Transaction } from "../models/transaction";

export const getTransactions = async (_: Request, res: Response) => {
    try {
        const transactions = await Transaction.findAll({
            order: [["id", "DESC"]],
        });
        res.status(200).json({
            transactions,
        });
        return;
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error en el servidor",
        });
        return;
    }
}