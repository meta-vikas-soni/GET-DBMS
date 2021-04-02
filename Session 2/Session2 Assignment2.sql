/*Adding Category*/
INSERT INTO Category(category_name) VALUES("Electronics");
INSERT INTO Category(category_name) VALUES("Home Essentials");

/*Adding Sub-Category*/
INSERT INTO Sub_CATEGORY(category_id,sub_cat_name) VALUES(
(SELECT category_id
FROM Category
WHERE Category.category_name="Electronics"
LIMIT 1)
,"Laptop");

INSERT INTO Sub_CATEGORY(category_id,sub_cat_name) VALUES(
(SELECT category_id
FROM Category
WHERE Category.category_name="Home Essentials"
LIMIT 1)
,"Grocery");

INSERT INTO Sub_CATEGORY(category_id,sub_cat_name) VALUES(
(SELECT category_id
FROM Category
WHERE Category.category_name="Electronics"
LIMIT 1)
,"HP");
UPDATE Sub_Category
SET Parent_Sub_Category=1
WHERE sub_cat_name="HP";

INSERT INTO Sub_CATEGORY(category_id,sub_cat_name) VALUES(
(SELECT category_id
FROM Category
WHERE Category.category_name="Electronics"
LIMIT 1)
,"Lenovo");
UPDATE Sub_Category
SET Parent_Sub_Category=1
WHERE sub_cat_name="Lenovo";

INSERT INTO Sub_CATEGORY(category_id,sub_cat_name) VALUES(
(SELECT category_id
FROM Category
WHERE Category.category_name="Electronics"
LIMIT 1)
,"Apple");
UPDATE Sub_Category
SET Parent_Sub_Category=1
WHERE sub_cat_name="Apple";

select * from sub_category;
/*Adding Products*/
INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("Bread",40,100,1,"Amul","Weight: 100gm",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Grocery"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (1,"some image");

INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("Patanjali Soap",45,100,1,"Patanjali","Weight: 100gm",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Grocery"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (7,"some image");

INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("Butter",50,100,1,"Amul","Weight: 200gm",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Grocery"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (2,"some image");

INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("Jam",60,100,1,"Kissan","Weight: 150gm",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Grocery"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (3,"");

INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("Ketchup",60,100,0,"Kissan","Weight: 1kg",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Grocery"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (4,"");

INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("Lenovo Ideapad 520",58000,100,1,"Lenovo","Model: 520",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Laptop"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (5,"");

SET SQL_SAFE_UPDATES=0;
UPDATE Products
SET sub_cat_id=(
SELECT sub_cat_id
FROM Sub_Category
WHERE sub_cat_name="Lenovo"
LIMIT 1
)
WHERE prod_brand="Lenovo";


INSERT INTO Products(prod_name,prod_price,stock_quantity,stock_status,prod_brand,prod_description,sub_cat_id)
VALUES("HP Pavilion Z2K",40000,100,1,"HP","Model: Z2K",
(SELECT sub_cat_id
FROM Sub_Category
WHERE Sub_Category.sub_cat_name="Laptop"
));
INSERT INTO prod_image(prod_id,prod_image_path)
VALUES (6,"some image");

SET SQL_SAFE_UPDATES=0;
UPDATE Products
SET sub_cat_id=(
SELECT sub_cat_id
FROM Sub_Category
WHERE sub_cat_name="HP"
LIMIT 1
)
WHERE prod_brand="HP";

/*Adding User*/
INSERT INTO User(username,email_id,first_name,last_name,password)
VALUES("vikassoni","vikassonix@gmail.com","Vikas","Soni","vikas1234");

INSERT INTO User(username,email_id,first_name,last_name,password)
VALUES("luckysoni","luckysoni@gmail.com","Lucky","Soni","lucky1234");

INSERT INTO User(username,email_id,first_name,last_name,password)
VALUES("sourabhsoni","sourabhsoni525@gmail.com","Sourabh","Soni","sourabh1234");

INSERT INTO User(username,email_id,first_name,last_name,password)
VALUES("ajinkyapande","xyz@gmail.com","Ajinkya","Pande","xyz1234");
/*Adding User Address*/
INSERT INTO User_Address(user_id,address)
VALUES(1,"11-B Shantiniketan Colony");

INSERT INTO User_Address(user_id,address)
VALUES(1,"4C Fatehpura Circle");

INSERT INTO User_Address(user_id,address)
VALUES(2,"11-B Shantiniketan Colony");

INSERT INTO User_Address(user_id,address)
VALUES(2,"4C Fatehpura Circle");

INSERT INTO User_Address(user_id,address)
VALUES(3,"11-B Shantiniketan Colony");

INSERT INTO User_Address(user_id,address)
VALUES(3,"4C Fatehpura Circle");

/*Queries*/
/*Display Id, Title, Category Title, Price of the products
which are Active and recently added products should be at top.*/
SELECT 
p.prod_id, p.prod_name,c.category_name,p.prod_price
FROM 
Products as p
INNER JOIN Sub_Category as sc
ON p.sub_cat_id = sc.sub_cat_id
INNER JOIN Category c
ON sc.category_id = c.category_id
WHERE p.stock_status = 1
ORDER BY p.prod_timestamp DESC;

/*Display the list of products which don't have any images.*/
SELECT 
p.prod_id, p.prod_name
FROM 
Products as p
INNER JOIN Prod_Image as pi
ON p.prod_id = pi.prod_id
WHERE pi.prod_image_path="";

/*Display all Id, Title and  Category Title for all the Sub-Categories listed,
sorted by Category Title and then Sub-Category Title.*/
SELECT 
c.category_id, c.category_name, sc.sub_cat_name
FROM 
category as c
INNER JOIN sub_category as sc
ON c.category_id = sc.category_id
ORDER BY c.category_name;

/*Display Id, Title, Category Title of all the Sub-Categories*/
SELECT 
sc.sub_cat_id, sc.sub_cat_name
FROM 
sub_category as sc;

/*Display Product Title, Price & Description which falls into 
particular category Title (i.e. “Mobile”)*/
SELECT 
p.prod_id, p.prod_name,p.prod_price,p.prod_description
FROM 
Products as p
INNER JOIN Sub_Category as sc
ON p.sub_cat_id = sc.sub_cat_id
WHERE sc.sub_cat_name="Laptop";

/*Display the list of Products whose Quantity on hand (Inventory) is under 50.*/
SELECT *
FROM 
Products as p
WHERE p.stock_quantity<101



/*SET SQL_SAFE_UPDATES=0;*/