import { DataTypes } from "sequelize";
import db from "../../db/connection";
import Member from "./member";

const MedidaCorporal = db.define('medida_corporal', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    member_id: {
        type: DataTypes.INTEGER
    },
    altura: {
        type: DataTypes.FLOAT
    },
    peso: {
        type: DataTypes.FLOAT
    },
    imc: {
        type: DataTypes.FLOAT
    },
    brazo: {
        type: DataTypes.FLOAT
    },
    pecho: {
        type: DataTypes.FLOAT
    },
    abdomen: {
        type: DataTypes.FLOAT
    },
    gluteo: {
        type: DataTypes.FLOAT
    },
    pantorrila: {
        type: DataTypes.FLOAT
    }
},
    {
        freezeTableName: true,
        timestamps: true
    })

MedidaCorporal.belongsTo(Member, { foreignKey: 'member_id' });

export default MedidaCorporal;