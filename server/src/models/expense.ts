import { DataTypes } from "sequelize";
import db from "../../db/connection";

export const Expense = db.define('expense', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    product_name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    description: {
        type: DataTypes.STRING,
        defaultValue: null
    },
    amount: {
        type: DataTypes.FLOAT,
        allowNull: false
    },
    supplier: {
        type: DataTypes.STRING,
        defaultValue: null
    },
    //1 = pendiente, 2 = aprobado, 3 = anulado
    status: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    date: {
        type: DataTypes.DATE,
        allowNull: false
    },
    admin_member_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    }
},
    {
        freezeTableName: true,
        
    })