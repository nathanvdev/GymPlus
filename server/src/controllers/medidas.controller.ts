import {Request, Response} from 'express';
import medida from '../models/medida_corporal';

export const postmedida = async (req: Request, res: Response) => {
    
        const {body} = req;
    
        try {
            const newMedida = await medida.create(body);
            res.status(201).json(newMedida);
    
        } catch (error) {
            console.error(error);
            res.status(500).json({error: 'Error creating medida'});
        }
    
    }
