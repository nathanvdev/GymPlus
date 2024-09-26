import {Request, Response} from 'express';
import measurement from '../models/measurement';

export const postmeasurement = async (req: Request, res: Response) => {
    
        const {body} = req;
    
        try {
            const newMedida = await measurement.create(body);
            res.status(200).json(newMedida);
    
        } catch (error) {
            console.error(error);
            res.status(500).json({error: 'Error creating medida'});
        }
    
    }
