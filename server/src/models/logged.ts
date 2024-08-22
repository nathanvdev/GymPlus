import { DataTypes } from "sequelize";
import db from "../../db/connection";
import member from "./member";


const user = db.define('user', {
    member_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    username: {
        type: DataTypes.STRING
    },
    password: {
        type: DataTypes.STRING
    },
    rol: {
        type: DataTypes.STRING
    },
    employment_status: {
        type: DataTypes.STRING
    },
    date_of_employment: {
        type: DataTypes.DATE
    }
},
    {
        freezeTableName: true
    })

    user.belongsTo(member, {foreignKey: 'member_id', targetKey: 'id'})

export default user