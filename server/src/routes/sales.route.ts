import { Router } from "express";
import { addSale, getSales, deleteSale } from "../controllers/sales.controller";


const router = Router();

router.post('/add', addSale)
router.get('/getall', getSales)
router.delete('/delete/:id', deleteSale)



export default router;