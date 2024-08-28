import { DataTypes } from "sequelize";
import db from "../../db/connection";

export const Sale = db.define('sale', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    total: {
        type: DataTypes.FLOAT
    },
    admin_id: {
        type: DataTypes.INTEGER
    }
},
    {
        freezeTableName: true
    })


export const SaleItem = db.define('sale_item', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    sale_id: {
        type: DataTypes.INTEGER
    },
    product_name: {
        type: DataTypes.STRING
    },
    price: {
        type: DataTypes.FLOAT
    },
    quantity: {
        type: DataTypes.INTEGER
    }
},
    {
        freezeTableName: true
    })