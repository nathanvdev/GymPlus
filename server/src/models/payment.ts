import { DataTypes } from "sequelize";
import db from "../../db/connection";

export const Payment = db.define('membership_payment', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    member_id: {
        type: DataTypes.INTEGER
    },
    membership_plan: {
        type: DataTypes.INTEGER
    },
    billing_quantity: {
        type: DataTypes.INTEGER
    },
    // 1 = Diario, 2 = Semanal, 3 = Mensual, 4 = Anual
    billing_cycle: {
        type: DataTypes.INTEGER
    },
    initialpaymentdate: {
        type: DataTypes.DATE
    },
    nextpaymentdate: {
        type: DataTypes.DATE
    },
    subtotal: {
        type: DataTypes.FLOAT
    },
    discounts: {
        type: DataTypes.FLOAT
    },
    discounts_description: {
        type: DataTypes.STRING
    },
    total: {
        type: DataTypes.FLOAT
    },
    payment_method: {
        type: DataTypes.INTEGER
    },
    cash: {
        type: DataTypes.FLOAT
    },
    change: {
        type: DataTypes.FLOAT
    },
    
    payment_status: {
        type: DataTypes.INTEGER
    },
    payment_reference: {
        type: DataTypes.STRING
    },
    admin_member_id: {
        type: DataTypes.INTEGER
    },
},
    {
        freezeTableName: true
    })





