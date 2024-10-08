import { Request, Response } from 'express';
import member from '../models/member';
import { Payment } from '../models/payment';
// import Payment from '../models/payment';


export const getmembers = async (_req: Request, res: Response) => {

    // const response = await member.findAll();

    // var lastPaymentDate = '';
    // var nextPaymentDate = '';
    
    // const members = response.map(  member => {

    //     return {
    //         id: member.dataValues.id,
    //         name: member.dataValues.name,
    //         lastname: member.dataValues.last_name,
    //         membershipStatus: member.dataValues.membership_status,
    //         lastPaymentDate: lastPaymentDate,
    //         nextPaymentDate: nextPaymentDate,
    //         lastVisit: member.dataValues.last_visit,
    //         activeDays: member.dataValues.active_days
    //     }
    // }
    // )
    // res.json({ members });




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
                activeDays: member.dataValues.active_days
            }
        });

        res.json({ members });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error fetching members' });
    }
}


export const getmember = (req: Request, res: Response) => {

    const { id } = req.params;

    res.json({
        msg: 'member',
        id
    });

}


export const postmember = async (req: Request, res: Response) => {

    const { body } = req;

    try {

        const phoneExist = await member.findOne({
            where: {
                phone_number: body.phone_number
            }
        });

        if (phoneExist) {
            return res.status(400).json({
                msg: 'Ya existe un miembro con el número de teléfono ingresado'
            });
        }


        const newMember = await member.create(body);
        res.json(newMember);


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

    res.json({
        msg: 'putmember',
        id,
        body
    });

}

export const deletemember = (req: Request, res: Response) => {

    const { id } = req.params;

    res.json({
        msg: 'deletemember',
        id
    });

}