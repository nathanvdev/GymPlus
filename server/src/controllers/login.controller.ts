import { Request, Response } from 'express';
import user from '../models/logged';

export const login = async (req: Request, res: Response) => {

    const { body } = req;

    try {

        const userExist = await user.findOne({
            where: {
                username: body.username,
                password: body.password
            }
        });

        if (!userExist) {
            return res.status(400).json({
                msg: 'Usuario o contraseña incorrectos'
            });
        }

        res.json(userExist);

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor, consulte con el desarrollador'
        });
    }
}