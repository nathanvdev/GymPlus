import { Request, Response } from 'express';
import measurement from '../models/measurement';
import { logRequest, logError } from '../utilities/logs';

export const postmeasurement = async (req: Request, res: Response) => {
    logRequest(req); // Log the request
    const { body } = req;

    try {
        const newMedida = await measurement.create(body);
        res.status(200).json({
            newMedida,
            msg: 'Medida creada correctamente'
        });

    } catch (error) {
        logError(error, req); // Log the error
        res.status(500).json({
            msg: 'Error en el servidor\n' + error
        });
    }

}
