import { Request, Response } from 'express';
import { Expense } from '../models/expense';
import { logRequest, logError } from '../utilities/logs';

export const getExpenses = async (req: Request, res: Response) => {
    logRequest(req); // Log the request

    try {
        const expenses = await Expense.findAll();
        res.status(200).json({
            expenses,
            msg: 'Gastos obtenidos correctamente'
        });
        return;
    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
        return;
    }
}

export const addExpense = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { product_name, description, amount, supplier, status, date, admin_member_id } = req.body;

    try {
        const expense = await Expense.create({
            product_name,
            description,
            amount,
            supplier,
            status,
            date,
            admin_member_id
        });
        res.status(200).json({
            expense,
            msg: 'Gasto creado correctamente'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}

export const editExpense = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { id } = req.params;
    const { product_name, description, supplier, status, date } = req.body;

    try {
        const expense = await Expense.findByPk(id);

        if (!expense) {
            return res.status(404).json({
                msg: 'Gasto no encontrado'
            });
        }

        const amount = expense.dataValues.amount;
        const admin_member_id = expense.dataValues.admin_member_id;

        await expense.update({
            product_name,
            description,
            amount,
            supplier,
            status,
            date,
            admin_member_id
        });

        res.status(200).json({
            expense,
            msg: 'Gasto actualizado correctamente'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}

export const deleteExpense = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { id } = req.params;

    try {
        const expense = await Expense.findByPk(id);

        if (!expense) {
            return res.status(404).json({
                msg: 'Gasto no encontrado'
            });
        }

        await expense.update({
            status: 3
        });

        res.status(200).json({
            msg: 'Gasto Reembolsado'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}

export const getExpense = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { id } = req.params;

    try {
        const expense = await Expense.findByPk(id);

        if (!expense) {
            return res.status(404).json({
                msg: 'Gasto no encontrado'
            });
        }

        res.status(200).json({
            expense,
            msg: 'Gasto obtenido correctamente'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}