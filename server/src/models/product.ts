import { DataTypes } from "sequelize";
import db from "../../db/connection";

export const Product = db.define('product', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: DataTypes.STRING
    },
    stock: {
        type: DataTypes.INTEGER
    },
    price: {
        type: DataTypes.FLOAT
    },
    imageurl: {
        type: DataTypes.STRING
    }
},
    {
        freezeTableName: true
    })