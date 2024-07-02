import { DataTypes } from "sequelize";
import db from "../../db/connection";

// CREATE TABLE `payment` (
//     `id` int NOT NULL AUTO_INCREMENT,
//     `member_id` int NOT NULL,
//     `membership_plan` varchar(15) NOT NULL,
//     `billing_cycle` varchar(20) NOT NULL,
//     `nextpaymentdate` date NOT NULL,
//     `payment_method` varchar(15) NOT NULL,
//     `payment_status` varchar(20) NOT NULL,
//     `amount` float NOT NULL,
//     `payment_reference` varchar(20) DEFAULT NULL,
//     `discounts` float DEFAULT NULL,
//     `discounts_description` varchar(50) DEFAULT NULL,
//     `admin_member_id` int NOT NULL,
//     `createdAt` date NOT NULL,
//     `updateAt` date NOT NULL,
//     PRIMARY KEY (`id`),
//     KEY `member_id` (`member_id`),
//     KEY `admin_member_id` (`admin_member_id`),
//     CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
//     CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`admin_member_id`) REFERENCES `user` (`member_id`)
//   ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



const payment = db.define('payment', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    member_id: {
        type: DataTypes.INTEGER
    },
    membership_plan: {
        type: DataTypes.STRING
    },
    billing_cycle: {
        type: DataTypes.STRING
    },
    nextpaymentdate: {
        type: DataTypes.DATE
    },
    payment_method: {
        type: DataTypes.STRING
    },
    payment_status: {
        type: DataTypes.STRING
    },
    amount: {
        type: DataTypes.FLOAT
    },
    payment_reference: {
        type: DataTypes.STRING
    },
    discounts: {
        type: DataTypes.FLOAT
    },
    discounts_description: {
        type: DataTypes.STRING
    },
    admin_member_id: {
        type: DataTypes.INTEGER
    },
    createdAt: {
        type: DataTypes.DATE
    },
    updateAt: {
        type: DataTypes.DATE
    }
},
    {
        freezeTableName: true
    })

export default payment