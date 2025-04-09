import { DataTypes } from "sequelize";
import db from "../../db/connection";

export const Transaction = db.define('transaction', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    reference_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    description: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Debito: {
        type: DataTypes.DECIMAL(10, 2),
        defaultValue: null
    },
    Credito: {
        type: DataTypes.DECIMAL(10, 2),
        defaultValue: null
    },
    Disponible: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    Reserva: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    Total: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    createdAt: {
        type: DataTypes.DATE,
    },
    updatedAt: {
        type: DataTypes.DATE,
    }
},
    {
        freezeTableName: true,
    }
);

