
DELIMITER $$
CREATE FUNCTION containsLettersAndSpace(input VARCHAR(300)) RETURNS BOOLEAN
deterministic
BEGIN
    DECLARE notValid BOOLEAN;

    IF input IS NOT NULL AND input REGEXP '^[a-zA-Z0-9 ]+$' THEN
        SET notValid = FALSE;
    ELSE
        SET notValid = TRUE;
    END IF;

    RETURN notValid;
END $$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION isEmpty(input VARCHAR(300)) RETURNS BOOLEAN
deterministic
BEGIN
    DECLARE isEmpty BOOLEAN;

    IF input IS NULL OR input = '' THEN
        SET isEmpty = TRUE;
    ELSE
        SET isEmpty = FALSE;
    END IF;

    RETURN isEmpty;
END $$
DELIMITER ;













DELIMITER $$
CREATE procedure mostrarMensaje(
    mensaje VARCHAR(255),
    tipo integer -- Puede ser 'error' o 'exito'
)
BEGIN
    DECLARE resultado VARCHAR(255);
    
    IF tipo = 400 THEN
		select mensaje as "ERROR";
    ELSEIF tipo = 200 THEN
        select mensaje as "EXITO";
    END IF;
END $$
DELIMITER ;


##------------------------------------------------------------Nuvo Miembro------------------------------------------------------------##
DELIMITER $$
CREATE PROCEDURE NewMember(
    name                   VARCHAR(50),
    last_name              VARCHAR(30),
    phone_number_in           VARCHAR(20),
    email                  VARCHAR(60),
    contact_preference     VARCHAR(10),
    emergency_contact      varchar(20),
    emergency_contact_name VARCHAR(55),
    allergies              VARCHAR(300),
    blood_type             VARCHAR(8),
    date_of_birth          VARCHAR(10),
    gender                 VARCHAR(2),
    mac_address            VARCHAR(20)
)
proc_NewMember: BEGIN 
    DECLARE next_payment DATE DEFAULT CURDATE();
    DECLARE membership_type VARCHAR(10) DEFAULT '';
    DECLARE membership_status CHAR(1) DEFAULT '0';
    DECLARE biometric VARCHAR(500) DEFAULT '';
    DECLARE inscription_date DATE DEFAULT CURDATE();
    DECLARE phone_count integer default 0;
    
	IF isEmpty(name) THEN
        CALL mostrarMensaje('El nombre no puede estar vacío', 400);
        LEAVE proc_NewMember;
    END IF;
    
    IF containsLettersAndSpace(name) THEN
        CALL mostrarMensaje('El nombre no puede contener números ni caracteres especiales', 400);
        LEAVE proc_NewMember;
    END IF;

    IF isEmpty(last_name) THEN
        CALL mostrarMensaje('El apellido no puede estar vacío', 400);
        LEAVE proc_NewMember;
    END IF;

    IF containsLettersAndSpace(last_name) THEN
        CALL mostrarMensaje('El apellido no puede contener números ni caracteres especiales', 400);
        LEAVE proc_NewMember;
    END IF;

    IF isEmpty(phone_number_in) THEN
        CALL mostrarMensaje('El número de teléfono no puede estar vacío', 400);
        LEAVE proc_NewMember;
    END IF;
    
    IF NOT phone_number_in REGEXP '^\+[0-9]{1,3}[0-9]{8,15}$' THEN
        CALL mostrarMensaje('Formato de número de teléfono incorrecto', 400);
        LEAVE proc_NewMember;
    END IF;
    
    SELECT COUNT(*) INTO phone_count FROM member WHERE phone_number = phone_number_in;
	-- Verificar si el número de teléfono ya está en uso
	IF phone_count > 0 THEN
		CALL mostrarMensaje('Este número de teléfono ya está en uso', 400);
		LEAVE proc_NewMember;
	END IF;
    

    IF NOT isempty(email) AND NOT email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        CALL mostrarMensaje('Formato de email incorrecto', 400);
        LEAVE proc_NewMember;
    END IF;

	IF isEmpty(contact_preference) THEN
        CALL mostrarMensaje('La preferencia de contacto no puede estar vacía', 400);
        LEAVE proc_NewMember;
    END IF;

    IF containsLettersAndSpace(contact_preference) THEN
        CALL mostrarMensaje('El contacto de preferencia no puede contener números ni caracteres especiales', 400);
        LEAVE proc_NewMember;
    END IF;

    IF NOT isempty(emergency_contact) AND NOT emergency_contact REGEXP '^\+[0-9]{1,3}[0-9]{8,15}$' THEN
        CALL mostrarMensaje('Formato de número de teléfono en contacto de emergencia incorrecto', 400);
        LEAVE proc_NewMember;
    END IF;

    IF NOT isempty(emergency_contact_name) AND containsLettersAndSpace(emergency_contact_name) THEN
        CALL mostrarMensaje('El nombre de contacto de emergencia no puede contener números ni caracteres especiales', 400);
        LEAVE proc_NewMember;
    END IF;

    IF NOT isempty(allergies) AND containsLettersAndSpace(allergies) THEN
        CALL mostrarMensaje('El campo de alergias no puede contener números ni caracteres especiales', 400);
        LEAVE proc_NewMember;
    END IF;

    IF NOT isempty(blood_type) AND NOT blood_type REGEXP '^[A-Z]{1,2}[-+]$' THEN
        CALL mostrarMensaje('El tipo de sangre debe contener solo letras y un signo', 400);
        LEAVE proc_NewMember;
    END IF;

    
	IF NOT isempty(date_of_birth) AND NOT STR_TO_DATE(date_of_birth, '%Y-%m-%d') THEN
		CALL mostrarMensaje('Formato de fecha de nacimiento incorrecto', 400);
		LEAVE proc_NewMember;
	END IF;


    IF isEmpty(gender) THEN
        CALL mostrarMensaje('El género no puede estar vacío', 400);
        LEAVE proc_NewMember;
    END IF;

    IF NOT isempty(mac_address) AND NOT mac_address REGEXP '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$' THEN
        CALL mostrarMensaje('Formato de dirección MAC incorrecto', 400);
        LEAVE proc_NewMember;
    END IF;

        -- Convertir el número de teléfono a entero
    SET phone_number_in = CAST(phone_number_in AS UNSIGNED);
    
    IF NOT isempty(emergency_contact) then
		SET emergency_contact = CAST(emergency_contact AS UNSIGNED);
    end if;
    
    -- Convertir el género a mayúsculas
    SET gender = UPPER(gender);
    
    -- Insertar los datos en la tabla member
    INSERT INTO member (
        name, last_name, phone_number, email, contact_preference, emergency_contact, 
        emergency_contact_name, allergies, blood_type, next_payment, date_of_birth, 
        gender, membership_type, membership_status, biometric, mac_address, inscription_date
    )
    VALUES (
        name, last_name, phone_number_in, email, contact_preference, 
        emergency_contact, emergency_contact_name, allergies, blood_type, 
        next_payment, date_of_birth, gender, membership_type, 
        membership_status, biometric, mac_address, inscription_date
    );
    CALL mostrarMensaje('Cliente agregado exitosamente', 200);
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE AddAdmin(
    admin_member_id        INTEGER,
    admin_username         VARCHAR(20),
    admin_password         VARCHAR(50),
    admin_role             VARCHAR(15),
    admin_employment_status VARCHAR(10),
    admin_date_of_employment VARCHAR(10)
)
proc_AddAdmin: BEGIN 

    DECLARE users INTEGER DEFAULT 0;

    -- Verificar que ningún campo esté vacío
    IF isEmpty(admin_member_id) OR isEmpty(admin_username) OR isEmpty(admin_password) OR isEmpty(admin_role) OR isEmpty(admin_employment_status) OR isEmpty(admin_date_of_employment) THEN
        CALL mostrarMensaje('Todos los campos son obligatorios', 400);
        LEAVE proc_AddAdmin;
    END IF;

    -- Verificar que el nombre de usuario, rol y estado laboral solo contengan letras y espacios
    IF containsLettersAndSpace(admin_username) THEN
        CALL mostrarMensaje('El nombre de usuario debe contener solo letras y espacios', 400);
        LEAVE proc_AddAdmin;
    END IF;
    
    SELECT COUNT(*) INTO users FROM member WHERE id = admin_member_id;

	-- Verificar si el número de teléfono ya está en uso
	IF users < 1 THEN
		CALL mostrarMensaje('Este miembro no existe', 400);
		LEAVE proc_NewMember;
	END IF;

    IF containsLettersAndSpace(admin_role)  THEN
        CALL mostrarMensaje('El rol debe contener solo letras y espacios', 400);
        LEAVE proc_AddAdmin;
    END IF;

    IF containsLettersAndSpace(admin_employment_status) THEN
        CALL mostrarMensaje('El estado laboral debe contener solo letras y espacios', 400);
        LEAVE proc_AddAdmin;
    END IF;

    -- Verificar si ya existe un administrador con el mismo nombre de usuario
    IF EXISTS (SELECT * FROM admin WHERE username = admin_username) THEN
        CALL mostrarMensaje('Ya existe un administrador con este nombre de usuario', 400);
        LEAVE proc_AddAdmin;
    END IF;

    -- Insertar los datos del administrador en la tabla admin
    INSERT INTO admin (
        member_id, username, password, rol, employment_status, date_of_employment
    )
    VALUES (
        admin_member_id, admin_username, admin_password, admin_role, admin_employment_status, STR_TO_DATE(admin_date_of_employment, '%d-%m-%Y')
    );

    -- Mostrar mensaje de éxito
    CALL mostrarMensaje('Administrador agregado exitosamente', 200);
END $$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE AddProduct(
    IN product_name VARCHAR(70),
    IN product_description VARCHAR(300),
    IN product_price DECIMAL(10, 2),
    IN product_stock INTEGER
)
proc_AddProduct: BEGIN
	DECLARE productCount integer default 0;
    
    -- Verificar que el nombre y el precio no estén vacíos
    IF isEmpty(product_name) THEN
        CALL mostrarMensaje('El nombre del producto no puede estar vacío', 400);
        LEAVE proc_AddProduct;
    END IF;
    
       -- Verificar que el nombre del producto no esté en uso
    SELECT COUNT(*) INTO productCount FROM product WHERE name = product_name;
    IF productCount > 0 THEN
        CALL mostrarMensaje('El nombre del producto ya está en uso', 400);
        LEAVE proc_AddProduct;
    END IF;
    
    IF product_price <= 0 THEN
        CALL mostrarMensaje('El precio del producto debe ser mayor que cero', 400);
        LEAVE proc_AddProduct;
    END IF;
    
    -- Verificar que el nombre y la descripción contengan solo letras y espacios
    IF containsLettersAndSpace(product_name) THEN
        CALL mostrarMensaje('El nombre del producto no puede contener números ni caracteres especiales', 400);
        LEAVE proc_AddProduct;
    END IF;
    
    IF NOT isEmpty(product_description) AND containsLettersAndSpace(product_description) THEN
        CALL mostrarMensaje('La descripción del producto no puede contener números ni caracteres especiales', 400);
        LEAVE proc_AddProduct;
    END IF;
    
    -- Insertar el producto en la tabla
    INSERT INTO product (name, description, price, stock)
    VALUES (product_name, product_description, product_price, product_stock);
    
    CALL mostrarMensaje('Producto agregado exitosamente', 200);
END proc_AddProduct $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE AddPayment(
    IN payment_date VARCHAR(10),
    IN membership_plan VARCHAR(15),
    IN billing_cycle VARCHAR(20),
    IN nextpaymentdate VARCHAR(10),
    IN payment_method VARCHAR(15),
    IN payment_status VARCHAR(20),
    IN amount FLOAT(4),
    IN payment_reference VARCHAR(20),
    IN discounts FLOAT(3),
    IN discounts_description VARCHAR(50),
    IN member_id_in INT,
    IN admin_member_id_in INT
)
proc_AddPayment: BEGIN
    DECLARE formatted_payment_date DATE;
    DECLARE formatted_nextpaymentdate DATE;
    DECLARE member_exists INT;
    DECLARE admin_exists INT;

    -- Validar campos obligatorios no vacíos o nulos
    IF isEmpty(payment_date) OR payment_date IS NULL THEN
        CALL mostrarMensaje('El campo "Fecha de pago" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;
    
    IF isEmpty(membership_plan) OR membership_plan IS NULL THEN
        CALL mostrarMensaje('El campo "Plan de membresía" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF isEmpty(billing_cycle) OR billing_cycle IS NULL THEN
        CALL mostrarMensaje('El campo "Ciclo de facturación" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF isEmpty(nextpaymentdate) OR nextpaymentdate IS NULL THEN
        CALL mostrarMensaje('El campo "Próxima fecha de pago" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF isEmpty(payment_method) OR payment_method IS NULL THEN
        CALL mostrarMensaje('El campo "Método de pago" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF isEmpty(payment_status) OR payment_status IS NULL THEN
        CALL mostrarMensaje('El campo "Estado de pago" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF amount IS NULL THEN
        CALL mostrarMensaje('El campo "Monto" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF member_id_in IS NULL THEN
        CALL mostrarMensaje('El campo "ID de miembro" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF admin_member_id_in IS NULL THEN
        CALL mostrarMensaje('El campo "ID de administrador" no puede estar vacío', 400);
        LEAVE proc_AddPayment;
    END IF;

    -- Validar campos de texto solo con letras y espacios
    IF containsLettersAndSpace(membership_plan) THEN
        CALL mostrarMensaje('El campo "Plan de membresía" solo puede contener letras y espacios', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF containsLettersAndSpace(billing_cycle) THEN
        CALL mostrarMensaje('El campo "Ciclo de facturación" solo puede contener letras y espacios', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF containsLettersAndSpace(payment_method) THEN
        CALL mostrarMensaje('El campo "Método de pago" solo puede contener letras y espacios', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF containsLettersAndSpace(payment_status) THEN
        CALL mostrarMensaje('El campo "Estado de pago" solo puede contener letras y espacios', 400);
        LEAVE proc_AddPayment;
    END IF;

    IF containsLettersAndSpace(discounts_description) THEN
        CALL mostrarMensaje('El campo "Descripción de descuentos" solo puede contener letras y espacios', 400);
        LEAVE proc_AddPayment;
    END IF;

    -- Convertir las fechas a formato DATE
    SET formatted_payment_date = STR_TO_DATE(payment_date, '%d-%m-%Y');
    SET formatted_nextpaymentdate = STR_TO_DATE(nextpaymentdate, '%d-%m-%Y');

    -- Verificar si el ID de miembro existe en la tabla member
    SELECT COUNT(*) INTO member_exists FROM member WHERE id = member_id_in;
    IF member_exists = 0 THEN
        CALL mostrarMensaje('El ID de miembro proporcionado no existe en la tabla member', 400);
        LEAVE proc_AddPayment;
    END IF;
    
    
	SELECT member_id FROM admin;
    select admin_member_id_in;
    

    -- Verificar si el ID de administrador existe en la tabla admin
    SELECT COUNT(*) INTO admin_exists FROM admin WHERE member_id = admin_member_id_in;
    IF admin_exists = 0 THEN
        CALL mostrarMensaje('El ID de administrador proporcionado no existe en la tabla admin', 400);
        LEAVE proc_AddPayment;
    END IF;

    -- Insertar el pago en la tabla payment
    INSERT INTO payment (
        payment_date, membership_plan, billing_cycle, nextpaymentdate, payment_method,
        payment_status, amount, payment_reference, discounts,
        discounts_description, member_id, admin_member_id
    )
    VALUES (
        formatted_payment_date, membership_plan, billing_cycle, formatted_nextpaymentdate,
        payment_method, payment_status, amount, payment_reference, 
        discounts, discounts_description, member_id_in, admin_member_id_in
    );

    -- Mensaje de éxito
    CALL mostrarMensaje('Pago agregado exitosamente', 200);
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER update_membership_status AFTER INSERT ON payment
FOR EACH ROW
BEGIN
    UPDATE member
    SET membership_status = 1
    WHERE id = NEW.member_id;
END;
$$

DELIMITER ;







