import { Request, Response } from 'express';
import member from '../models/member';
import { Payment } from '../models/payment';
// import Payment from '../models/payment';


export const getmembers = async (_req: Request, res: Response) => {

    try {
        const response = await member.findAll({
            include: [{
                model: Payment,
                as: 'membership_payment', // Usa el alias que definiste en la asociación
                attributes: ['initialpaymentdate', 'nextpaymentdate']
            }]
        });

        const members = response.map(member => {
            const payment = member.dataValues.membership_payment; // Accede a los datos relacionados de payment
            return {
                id: member.dataValues.id,
                name: member.dataValues.name,
                lastName: member.dataValues.last_name,
                membershipStatus: member.dataValues.membership_status,
                lastPaymentDate: payment ? payment.initialpaymentdate : null,
                nextPaymentDate: payment ? payment.nextpaymentdate : null,
                lastVisit: member.dataValues.last_visit,
                activeDays: member.dataValues.active_days,
                profileImage: member.dataValues.porfileImage
            }
        });

        res.status(200).json(members);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error fetching members' });
    }
}


export const getmember = async (req: Request, res: Response) => {

    const { id } = req.params;

    try {
        const response = await member.findOne({
            where: {
                id
            }
        });

        if (!response) {
            return res.status(400).json({
                msg: 'No existe un miembro con el id ingresado'
            });
        }

        res.status(200).json(response);
    } catch (error) {

    }

}


export const postmember = async (req: Request, res: Response) => {

    const { body } = req;

    try {

        const NameExist = await member.findOne({
            where: {
                name: body.name,
                last_name: body.last_name
            }
        });

        if (NameExist) {
            return res.status(400).json({
                msg: 'Ya existe un miembro con el nombre y apellido ingresado'
            });
        }


        const newMember = await member.create(body);
        res.status(201).json(newMember);




    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor'
        });

    }


}

export const putmember = (req: Request, res: Response) => {

    const { id } = req.params;
    const { body } = req;

    try {
        const memberExist = member.findByPk(id);
        if (!memberExist) {
            return res.status(400).json({
                msg: 'No existe un miembro con el id ingresado'
            });
        }

        member.update(body, {
            where: {
                id
            }
        });

        res.status(200).json({
            msg: 'Miembro actualizado'
        });
    } catch (error) {
        res.status(500).json({
            msg: 'Error en el servidor'
        });
    }

}

export const deletemember = (req: Request, res: Response) => {

    const { id } = req.params;

    res.json({
        msg: 'deletemember',
        id
    });

}