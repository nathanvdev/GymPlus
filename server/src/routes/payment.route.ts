import { Router } from "express";
import { getPayments, postpayment, getBill } from "../controllers/payment.controller";

const router = Router();

router.post('/add', postpayment)
router.get('/get', getPayments)
router.get('/getBill', getBill)

export default router;