/*Display Count of products as per below price range:*/
SELECT COUNT(o.order_id)
FROM orders as o
INNER JOIN cart as c
ON o.cart_id = c.cart_id
WHERE c.total_price BETWEEN 0 and 50
AND c.item_status != "Order Not Placed";

SELECT COUNT(o.order_id)
FROM orders as o
INNER JOIN cart as c
ON o.cart_id = c.cart_id
WHERE c.total_price BETWEEN 50 and 500
AND c.item_status != "Order Not Placed";

SELECT COUNT(o.order_id)
FROM orders as o
INNER JOIN cart as c
ON o.cart_id = c.cart_id
WHERE c.total_price > 500
AND c.item_status != "Order Not Placed";


/*Display the list of products (Id, Title, Count of Categories)
which fall in more than one Categories.*/
SELECT prod_id,prod_name
FROM products
GROUP BY prod_id
HAVING COUNT(prod_id)>1;

/*Display the Categories along with number of products under each category.*/
SELECT s.sub_cat_id,s.sub_cat_name, COUNT(p.prod_id)
FROM sub_category as s
INNER JOIN products as p
ON s.sub_cat_id = p.sub_cat_id
GROUP BY sub_cat_id;

/*Display Shopper’s information along with number of orders he/she placed during last 30 days.*/
SELECT u.user_id, u.username, u.first_name, u.last_name, COUNT(order_id) AS "Total Orders"
FROM user as u
INNER JOIN orders as o
ON u.user_id = o.user_id
WHERE o.order_timestamp > (SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  30 DAY))
GROUP BY(u.user_id);


/*Display the top 10 Shoppers who generated maximum number of revenue in last 30 days.*/
SELECT u.user_id, u.username, u.first_name, u.last_name, MAX(c.total_price), c.item_status
FROM user as u
INNER JOIN cart as c
ON u.user_id = c.user_id
WHERE c.item_status = "Delivered"
AND c.cart_timestamp > (SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  30 DAY))
GROUP BY u.user_id
ORDER BY c.total_price DESC
LIMIT 10;

/*Display top 20 Products which are ordered most in last 60 days along with numbers.*/
SELECT p.prod_id, p.prod_name, COUNT(c.prod_id)
FROM products as p
INNER JOIN cart as c
ON p.prod_id = c.prod_id
WHERE c.item_status != "Order Not Placed"
AND c.cart_timestamp > (SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  60 DAY))
GROUP BY p.prod_id
LIMIT 20;

/*Display Monthly sales revenue of the StoreFront for last 6 months.
It should display each month’s sale.*/
SELECT MONTH(o.order_timestamp) AS Month, SUM(c.total_price) AS Revenue
FROM Orders AS o
INNER JOIN Cart as c
ON o.cart_id = c.cart_id
GROUP BY MONTH(o.order_timestamp);

/*Mark the products as Inactive which are not ordered in last 90 days.*/
/*Setting that item to active first*/
SET SQL_SAFE_UPDATES=0;
UPDATE products
SET stock_status = 1
WHERE prod_id NOT IN(
SELECT prod_id
FROM Cart
WHERE item_status != "Order Not Placed"
AND cart_timestamp > (SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  90 DAY))
);

/*now making it inactive*/
SET SQL_SAFE_UPDATES=0;
UPDATE products
SET stock_status = 0
WHERE prod_id NOT IN(
SELECT prod_id
FROM Cart
WHERE item_status != "Order Not Placed"
AND cart_timestamp > (SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  90 DAY))
);

/*Given a category search keyword, display all the Products present in
this category/categories. */
SELECT sc.sub_cat_name, p.prod_id, p.prod_name
FROM products as p
INNER JOIN sub_category as sc
ON p.sub_cat_id = sc.sub_cat_id
WHERE sc.sub_cat_name LIKE '%cery%';

/*Display top 10 Items which were cancelled most. (--Taken Delivered HERE)*/
SELECT p.prod_id, p.prod_name, COUNT(c.prod_id)
FROM products as p
INNER JOIN cart as c
ON p.prod_id = c.prod_id
WHERE c.item_status = "Delivered"
GROUP BY p.prod_id
ORDER BY COUNT(c.prod_id) DESC
LIMIT 10;

/*CREATING Places TABLE*/
CREATE TABLE Places(
    zipcode INT NOT NULL UNIQUE,
    city_name varchar(255) NOT NULL,
    state_name varchar(255) NOT NULL,
    PRIMARY KEY(zipcode)
);

/*Inserting some data to Places Table*/
INSERT INTO Places
  (zipcode, city_name, state_name)
VALUES
  (313001,"Udaipur","Rajasthan"), 
  (302016,"Jaipur","Rajasthan"), 
  (281001,"Mathura","Uttar Pradesh"),
  (380004,"Ahmedabad","Gujrat"),
  (781001,"Guwahati","Assam"),
  (400050,"Mumbai-Bandra","Maharashtra"),
  (111045,"Pune","Maharashtra"),
  (530068,"Bangalore","Karnataka");

/*returns a Resultset containing Zip Code, City Names and 
States ordered by State Name and City Name.*/
SELECT zipcode,city_name,state_name
FROM places
ORDER BY state_name,city_name;

/*Create a view displaying the order information (Id, Title,
Price, Shopper’s name, Email, Orderdate, Status) with latest 
ordered items should be displayed first for last 60 days.*/

CREATE OR REPLACE VIEW Display_Order_Information AS
SELECT o.order_id,p.prod_id, p.prod_name, c.total_price, u.first_name,
u.last_name, u.email_id, o.order_timestamp, c.item_status
FROM
Orders as o
INNER JOIN Cart as c
ON o.cart_id = c.cart_id
INNER JOIN Products as p
ON c.prod_id = p.prod_id
INNER JOIN User as u
ON u.user_id = o.user_id
WHERE o.order_timestamp > (SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  60 DAY))
ORDER BY o.order_timestamp DESC;

SELECT * FROM Display_Order_Information;

/*Use the above view to display the Products(Items) which are in ‘shipped’ state.*/
SELECT * FROM Display_Order_Information
WHERE item_status="Shipped";

/*Use the above view to display the top 5 most selling products.*/
SELECT *,COUNT(prod_id) FROM Display_Order_Information
GROUP BY prod_name
ORDER BY COUNT(prod_id) DESC
LIMIT 5;

