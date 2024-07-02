import { Request, Response } from 'express';
import member from '../models/member';

export const getmembers = async (_req: Request, res: Response) => {

    const response = await member.findAll();

    const members = response.map(member => {
        return {
            id: member.dataValues.id,
            name: member.dataValues.name,
            lastname: member.dataValues.last_name,
            membershipStatus: member.dataValues.membership_status,
            lastPaymentDate: member.dataValues.last_visit,
            nextPaymentDate: member.dataValues.next_payment,
            birthdate: member.dataValues.date_of_birth
            
        }
    }
    )
    res.json({ members });
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
