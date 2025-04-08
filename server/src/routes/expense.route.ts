import { Router } from "express";
import { addExpense, deleteExpense, getExpenses, getExpense, editExpense } from "../controllers/expense.controller";

const router = Router();

router.post('/add', addExpense);
router.delete('/delete/:id', deleteExpense);
router.get('/getall', getExpenses);
router.get('/get/:id', getExpense);
router.put('/edit/:id', editExpense);



export default router;