import { Router } from "express";
import { getProducts } from "../controllers/product.controller";

const router = Router();

router.get('/getall', getProducts)

export default router;