CREATE TABLE member (
    id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone_number BIGINT NOT NULL,
    email VARCHAR(60),
    contact_preference VARCHAR(10) NOT NULL,
    emergency_contact BIGINT,
    emergency_contact_name VARCHAR(55),
    allergies VARCHAR(300),
    blood_type VARCHAR(8),
    next_payment DATE NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(2) NOT NULL,
    membership_type VARCHAR(10) NOT NULL,
    membership_status BOOLEAN NOT NULL,
    biometric VARCHAR(500),
    mac_address VARCHAR(20),
    inscription_date DATE NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE admin (
    member_id INTEGER NOT NULL,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(50) NOT NULL,
    rol VARCHAR(15) NOT NULL,
    employment_status VARCHAR(10) NOT NULL,
    date_of_employment DATE,
    PRIMARY KEY (member_id)
);


CREATE TABLE sale (
    id INTEGER NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    method VARCHAR(25) NOT NULL,
    reference_payment VARCHAR(20),
    status VARCHAR(20) NOT NULL,
    amount DECIMAL(10 , 2 ) NOT NULL,
    discount DECIMAL(10 , 2 ),
    discount_description VARCHAR(300),
    total DECIMAL(10 , 2 ) NOT NULL,
    costumer_id INTEGER NOT NULL,
    seller_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (costumer_id)
        REFERENCES member (id),
    FOREIGN KEY (seller_id)
        REFERENCES admin (member_id)
);


CREATE TABLE product (
    id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(70) NOT NULL,
    description VARCHAR(300),
    price DECIMAL(10 , 2 ) NOT NULL,
    stock INTEGER,
    PRIMARY KEY (id)
);


CREATE TABLE cart_item (
    id INTEGER NOT NULL AUTO_INCREMENT,
    quantity INTEGER,
    sale_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (product_id)
        REFERENCES product (id),
    FOREIGN KEY (sale_id)
        REFERENCES sale (id)
);


CREATE TABLE attendance (
    id INTEGER NOT NULL AUTO_INCREMENT,
    datetime DATETIME NOT NULL,
    time_in DATETIME,
    time_on DATETIME,
    duration TIME,
    member_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id)
        REFERENCES member (id)
);


CREATE TABLE memberanthropometry (
    id INTEGER NOT NULL AUTO_INCREMENT,
    measurementdate DATE NOT NULL,
    height FLOAT(3),
    weight FLOAT(3) NOT NULL,
    bicepmeasurement FLOAT(3) NOT NULL,
    waistmeasurement FLOAT(3) NOT NULL,
    hipmeasurement FLOAT(3) NOT NULL,
    chestmeasurement FLOAT(3) NOT NULL,
    thighmeasurement FLOAT(3) NOT NULL,
    notes VARCHAR(300),
    member_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id)
        REFERENCES member (id)
);


CREATE TABLE payment (
    id INTEGER NOT NULL AUTO_INCREMENT,
    payment_date DATE NOT NULL,
    membership_plan VARCHAR(15) NOT NULL,
    billing_cycle VARCHAR(20) NOT NULL,
    nextpaymentdate DATE NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    amount FLOAT(4) NOT NULL,
    payment_reference VARCHAR(20),
    discounts FLOAT(3),
    discounts_description VARCHAR(50),
    member_id INTEGER NOT NULL,
    admin_member_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id)
        REFERENCES member (id),
    FOREIGN KEY (admin_member_id)
        REFERENCES admin (member_id)
);