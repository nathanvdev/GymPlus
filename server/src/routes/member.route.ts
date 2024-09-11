import { Router } from "express";
import { getmembers, getmember, postmember, putmember, deletemember } from "../controllers/member.controller";


const router = Router();


router.get('/get', getmembers)
router.get('/get/:id', getmember)
router.post('/add', postmember)
router.put('/update/:id', putmember)
router.delete('/delete/:id', deletemember)



export default router;