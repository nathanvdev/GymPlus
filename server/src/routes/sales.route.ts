import { Router } from "express";
import { addSale } from "../controllers/sales.controller";


const router = Router();

router.post('/add', addSale)


export default router;