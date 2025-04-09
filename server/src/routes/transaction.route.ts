import { Router } from "express";
import { getTransactions } from "../controllers/transaction.controller";

const router = Router();

router.get('/getall', getTransactions);

export default router;