import { Request, Response } from "express";
import { Transaction } from "../models/transaction";
import { logRequest, logError } from "../utilities/logs";

export const getTransactions = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    
    try {
        const transactions = await Transaction.findAll({
            order: [["id", "DESC"]],
        });
        res.status(200).json({
            transactions,
            msg: "Transacciones obtenidas correctamente",
        });
        return;
    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: "Error en el servidor",
        });
        return;
    }
}