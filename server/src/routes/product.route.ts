import { Router } from "express";
import { getProducts, addProduct, editProduct, deleteProduct } from "../controllers/product.controller";

const router = Router();

router.get('/getall', getProducts)
router.post('/add', addProduct)
router.put('/edit/:id', editProduct)
router.delete('/delete/:id', deleteProduct)

export default router;