import { Router } from "express";
import { getPayments, postpayment, getBill, getPaymentById, updatePayment } from "../controllers/payment.controller";

const router = Router();

router.post('/add', postpayment)
router.get('/getall', getPayments)
router.get('/getBill', getBill)
router.get('/getbyid/:id', getPaymentById)
router.put('/update/:id', updatePayment)

export default router;