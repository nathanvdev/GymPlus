import { Request, Response } from 'express';
import user from '../models/logged';

export const login = async (req: Request, res: Response) => {

    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({
            msg: 'Nombre de usuario y contraseña son requeridos'
        });
    }

    try {
        const userExist = await user.findOne({
            where: {
                username: username,
                password: password
            }
        });

        if (!userExist) {
            return res.status(404).json({
                msg: 'Usuario o contraseña incorrectos'
            });
        }

        if (userExist.dataValues.employment_status != 'active') {
            return res.status(401).json({
                msg: 'Usuario inactivo'
            });
        }

        return res.status(200).json({
            userExist
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}