import { Router } from "express";
import { getmembers, getmember, postmember, putmember, deletemember, getFullMember } from "../controllers/member.controller";


const router = Router();


router.get('/get', getmembers)
router.get('/get/:id', getmember)
router.post('/add', postmember)
router.put('/update/:id', putmember)
router.delete('/delete/:id', deletemember)
router.get('/full/:id', getFullMember)




export default router;