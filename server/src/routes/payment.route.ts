import { Router } from "express";
import { getPayments, postpayment, getBill, getPaymentById, updatePayment, deletePayment } from "../controllers/payment.controller";

const router = Router();

router.post('/add', postpayment)
router.get('/getall', getPayments)
router.get('/getBill', getBill)
router.get('/getbyid/:id', getPaymentById)
router.put('/update/:id', updatePayment)
router.delete('/delete/:id', deletePayment)

export default router;