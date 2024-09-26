import { Router } from "express";
import { postmedida } from "../controllers/medidas.controller";

const router = Router();

router.post('/add', postmedida)

export default router;