import { DataTypes } from "sequelize";
import db from "../../db/connection";
import Member from "./member";

const Measurement = db.define('measurement', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    member_id: {
        type: DataTypes.INTEGER
    },
    height: {
        type: DataTypes.FLOAT
    },
    weight: {
        type: DataTypes.FLOAT
    },
    imc: {
        type: DataTypes.FLOAT
    },
    arm: {
        type: DataTypes.FLOAT
    },
    chest: {
        type: DataTypes.FLOAT
    },
    abdomen: {
        type: DataTypes.FLOAT
    },
    gluteus: {
        type: DataTypes.FLOAT
    },
    thigh: {
        type: DataTypes.FLOAT
    }
},
    {
        freezeTableName: true,
    })

    Measurement.belongsTo(Member, { foreignKey: 'member_id' });

export default Measurement;