// REATE TABLE error_logs (
//     id INT AUTO_INCREMENT PRIMARY KEY,
//     createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
//     message TEXT NOT NULL,
//     source VARCHAR(100) NULL, -- Origen del error (ej. "AuthController")
//     endpoint VARCHAR(255) NULL, -- Ruta o endpoint afectado (ej. "/api/members")
//     updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
// );

// CREATE INDEX idx_createdAt ON error_logs (createdAt);
// CREATE INDEX idx_source ON error_logs (source);


import { DataTypes } from "sequelize";
import db from "../../db/connection";

export const ErrorLog = db.define('error_logs', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    message: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    source: {
        type: DataTypes.STRING(100),
        defaultValue: null
    },
    endpoint: {
        type: DataTypes.STRING(255),
        defaultValue: null
    },
},
{
    freezeTableName: true,
});