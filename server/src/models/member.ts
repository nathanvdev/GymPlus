import { DataTypes } from "sequelize";
import db from "../../db/connection";
import { Payment } from "./payment";

const member = db.define('member', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: DataTypes.STRING
    },
    last_name: {
        type: DataTypes.STRING
    },
    phone_number: {
        type: DataTypes.BIGINT
    },
    email: {
        type: DataTypes.STRING
    },
    date_of_birth: {
        type: DataTypes.DATE
    },
    gender: {
        type: DataTypes.STRING
    },
    emergency_contact_number: {
        type: DataTypes.BIGINT
    },
    emergency_contact_name: {
        type: DataTypes.STRING
    },
    allergies: {
        type: DataTypes.STRING
    },
    blood_type: {
        type: DataTypes.STRING
    },
    last_payment: {
        type: DataTypes.INTEGER
    },
    membership_type: {
        type: DataTypes.STRING
    },
    membership_status: {
        type: DataTypes.BOOLEAN
    },
    last_visit: {
        type: DataTypes.DATE
    },
    active_days: {
        type: DataTypes.INTEGER
    },
    
},
    {
        freezeTableName: true
    })

    member.hasOne(Payment, { foreignKey: 'id', sourceKey: 'last_payment' });
    Payment.belongsTo(member, { foreignKey: 'id', targetKey: 'last_payment' });

export default member


