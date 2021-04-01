/*Creating all tables*/

CREATE TABLE User(
    user_id INT NOT NULL AUTO_INCREMENT,
    username varchar(255) NOT NULL,
    email_id varchar(255) NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255),
    password varchar(255) NOT NULL,
    PRIMARY KEY(user_id)
);

CREATE TABLE User_Address(
    user_id INT NOT NULL,
    address varchar(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Products(
    prod_id INT NOT NULL AUTO_INCREMENT,
    prod_name varchar(255) NOT NULL,
    prod_price INT NOT NULL,
    stock_quantity INT NOT NULL,
    stock_status INT NOT NULL,
    prod_brand varchar(255) NOT NULL,
    prod_description LONGTEXT,
    sub_cat_id INT NOT NULL,
    prod_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(prod_id)
);

CREATE TABLE Prod_Image(
    prod_id INT NOT NULL,
    prod_image_path varchar(255) NOT NULL,
    CONSTRAINT FK_prod_id FOREIGN KEY (prod_id) REFERENCES Products(prod_id)
);

CREATE TABLE Sub_Category(
    sub_cat_id INT NOT NULL AUTO_INCREMENT,
    category_id INT NOT NULL,
    sub_cat_name varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY(sub_cat_id)
);
/*Adding new column for parent sub category*/
ALTER TABLE Sub_Category
ADD Parent_Sub_Category INT DEFAULT null;
/*Adding foreign key constraint*/
ALTER TABLE Sub_Category
ADD CONSTRAINT fk_Parent_Sub_Category FOREIGN KEY (Parent_Sub_Category)
REFERENCES Sub_Category(sub_cat_id);


CREATE TABLE Category(
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY(category_id)
);

CREATE TABLE Cart(
    cart_id INT NOT NULL AUTO_INCREMENT,
    prod_id INT NOT NULL,
    item_quantity INT DEFAULT 1,
    item_status varchar(255) NOT NULL DEFAULT "Order Not Placed",
    user_id INT NOT NULL,
    total_price INT NOT NULL,
    cart_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(cart_id)
);

CREATE TABLE Orders(
    order_id INT NOT NULL AUTO_INCREMENT,
    cart_id INT NOT NULL,
    payment_mode varchar(255) NOT NULL DEFAULT "COD",
    order_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(order_id)
);
ALTER TABLE Orders
ADD user_id INT NOT NULL;

ALTER TABLE Prod_Image
DROP FOREIGN KEY FK_prod_id;

DROP TABLE Products;

CREATE TABLE Products(
    prod_id INT NOT NULL AUTO_INCREMENT,
    prod_name varchar(255) NOT NULL,
    prod_price INT NOT NULL,
    stock_quantity INT NOT NULL,
    stock_status INT NOT NULL,
    prod_brand varchar(255) NOT NULL,
    prod_description LONGTEXT,
    sub_cat_id INT NOT NULL,
    PRIMARY KEY(prod_id)
);

show tables;