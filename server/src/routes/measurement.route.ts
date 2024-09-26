import { Router } from "express";
import { postmeasurement } from "../controllers/measurement.controller";

const router = Router();

router.post('/add', postmeasurement)

export default router;