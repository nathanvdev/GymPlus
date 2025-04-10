import { Request, Response } from "express";
import { Payment } from "../models/payment";
import { generateMembershipBill } from "../utilities/membership_bill";
import { member } from "../models/member";
import { Op } from "sequelize";
import { logRequest, logError } from "../utilities/logs";

export const postpayment = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { body } = req;

    try {
        if (body.cash == '') {
            body.cash = body.total;
            body.change = 0;
        }

        const newPayment = await Payment.create(body);
        body.id = newPayment.dataValues.id;
        await generateMembershipBill(body);

        res.status(200).json({
            msg: 'Pago creado',
            newPayment
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}


export const getPayments = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    try {
        const payments = await Payment.findAll();

        const paymentsWithMemberInfo = await Promise.all(payments.map(async (payment) => {
            const tmp = await member.findByPk(payment.dataValues.member_id);
            return {
                ...payment.toJSON(),
                member_name: tmp ? tmp.dataValues.name : 'N/A',
                member_lastname: tmp ? tmp.dataValues.last_name : 'N/A'
            };
        }));


        res.status(200).json({
            msg: 'Pagos',
            payments: paymentsWithMemberInfo
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
};

export const getPaymentById = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { id } = req.params;

    try {
        const payment = await Payment.findByPk(id);

        if (!payment) {
            return res.status(404).json({
                msg: 'Pago no encontrado'
            });
        }

        const memberInfo = await member.findByPk(payment.dataValues.member_id);
        payment.dataValues.member_name = memberInfo ? memberInfo.dataValues.name : 'N/A';
        payment.dataValues.member_lastname = memberInfo ? memberInfo.dataValues.last_name : 'N/A';
        res.status(200).json({
            payment
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
};


export const updatePayment = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { body } = req;

    try {

        const payment = await Payment.findByPk(req.params.id);

        if (!payment) {
            return res.status(404).json({
                msg: 'Pago no encontrado'
            });
        }
        const updatedPayment ={
            membership_plan: body.membership_plan,
            billing_quantity: body.billing_quantity,
            billing_cycle: body.billing_cycle,
            initialpaymentdate: body.initialpaymentdate,
            nextpaymentdate: body.nextpaymentdate,
            subtotal: body.subtotal,
            discounts: body.discounts,
            discounts_description: body.discounts_description,
            total: body.total,
            payment_method: body.payment_method,
            cash: body.cash,
            change: body.change,
            payment_status: body.payment_status,
            payment_reference: body.payment_reference,
        }
        await payment.update(updatedPayment);

        res.status(200).send({ "msg": "Pago actualizado" });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}

export const deletePayment = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { id } = req.params;

    try {
        const payment = await Payment.findByPk(id);
        if (!payment) {
            return res.status(404).json({
                msg: 'Pago no encontrado'
            });
        }

        const tmpMember = await member.findOne({
            where: {
                id: payment.dataValues.member_id
            }
        });
        if (tmpMember) {
            await tmpMember.update({
                last_payment: null
            });
        }

        await payment.update({
            payment_status : 3
        });

        const last_payment = await Payment.findOne({
            order: [['createdAt', 'DESC']],
            where: {
                member_id: payment.dataValues.member_id,
                payment_status: { [Op.ne]: 3 }
            }
        });
        if (last_payment && tmpMember) {
            await tmpMember.update({
                last_payment: last_payment.dataValues.id
            });
        }

        res.status(200).json({
            msg: 'Pago eliminado'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}