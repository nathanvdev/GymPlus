import express from 'express'
import memberRoutes from '../routes/member.route'
import loginRoutes from '../routes/login.route'
import paymentRoutes from '../routes/payment.route'
import productRoutes from '../routes/product.route'
import saleRoutes from '../routes/sales.route'
import cors from 'cors'
import db from '../../db/connection';

class Server {

    private app: express.Application;
    private port: string | undefined;
    private apiPaths = {
        member: '/member',
        login: '/login',
        payment : '/payment',
        product : '/product',
        sale : '/sale'
    }
    constructor() {
        this.app = express()
        this.port = process.env.PORT
        this.dbConnection()
        this.midelwares()
        this.routes()
    }

    async dbConnection() {
        try {
            await db.authenticate()
            console.log('Database online')

        } catch (error) {
            console.log(error)
            throw new Error('Error a la hora de iniciar la base de datos')
        }
    }

    midelwares() {
        this.app.use(cors())
        this.app.use(express.json())
        this.app.use(express.static('public'))
    }

    routes() {
        this.app.use(this.apiPaths.member, memberRoutes)
        this.app.use(this.apiPaths.login, loginRoutes)
        this.app.use(this.apiPaths.payment, paymentRoutes)
        this.app.use(this.apiPaths.product, productRoutes)
        this.app.use(this.apiPaths.sale, saleRoutes)
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log(`Server running on http://localhost:${this.port}`)
        })
    }
}

export default Server