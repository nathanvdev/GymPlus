import { Request, Response } from 'express';
import user from '../models/logged';
import { logRequest, logError } from '../utilities/logs';

export const login = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
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
            userExist,
            msg: 'Usuario logueado correctamente'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }
}