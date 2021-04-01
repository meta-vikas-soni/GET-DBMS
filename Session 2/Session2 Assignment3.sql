/*Creating orders*/

/*Creating cart*/
INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (1,2,"Delivered",
(SELECT prod_price
FROM products
WHERE products.prod_id=1
)*2,1);

INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (2,1,"Delivered",
(SELECT prod_price
FROM products
WHERE products.prod_id=2
)*1,1);

INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (3,1,"Delivered",
(SELECT prod_price
FROM products
WHERE products.prod_id=3
)*1,1);

INSERT INTO cart(prod_id,item_quantity,total_price,user_id)
VALUES (4,1,
(SELECT prod_price
FROM products
WHERE products.prod_id=4
)*1,1);

INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (5,1,"Shipped",
(SELECT prod_price
FROM products
WHERE products.prod_id=5
)*1,1);

INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (6,1,"Shipped",
(SELECT prod_price
FROM products
WHERE products.prod_id=6
)*1,1);


INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (6,1,"Delivered",
(SELECT prod_price
FROM products
WHERE products.prod_id=6
)*1,1);

INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (5,1,"Shipped",
(SELECT prod_price
FROM products
WHERE products.prod_id=5
)*1,1);

INSERT INTO cart(prod_id,item_quantity,item_status,total_price,user_id)
VALUES (6,1,"Delivered",
(SELECT prod_price
FROM products
WHERE products.prod_id=6
)*1,2);


select * from orders;
/*Adding to orders*/
INSERT INTO Orders(cart_id,user_id)
SELECT cart_id, user_id FROM Cart
WHERE Cart.item_status!="Order Not Placed";

/*Changing payment method*/
SET SQL_SAFE_UPDATES=0;
UPDATE Orders
SET payment_mode="Debit Card"
WHERE cart_id=(
    SELECT cart_id FROM Cart
    WHERE ( user_id = 1 and prod_id = 5)
    LIMIT 1
);

/*Queries*/
/*Display Recent 50 Orders placed*/
SELECT o.order_id,o.order_timestamp,c.total_price
FROM 
Orders as o
INNER JOIN Cart as c
ON o.cart_id=c.cart_id
LIMIT 50;

/*Display 10 most expensive Orders.*/
SELECT o.order_id,c.total_price
FROM 
Orders as o
INNER JOIN Cart as c
ON o.cart_id=c.cart_id
ORDER BY c.total_price DESC
LIMIT 10;

/*Display all the Orders which are placed more than 10 daysold and
one or more items from those orders are still not shipped.*/
SELECT order_id,order_timestamp
FROM 
Orders
WHERE order_timestamp<(
    SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 HOUR)
);

/*Display list of shoppers which haven't ordered anything since last month.*/
SELECT u.user_id
FROM User as u
WHERE u.user_id NOT IN
(
    SELECT o.user_id
    FROM Orders as o
    WHERE o.order_timestamp>(SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  1 DAY))
    GROUP BY o.user_id
);

/*Display list of shopper along with orders placed by them in last 15 days. */
SELECT user_id,order_id
FROM Orders
WHERE order_timestamp>(SELECT DATE_SUB(CURRENT_TIMESTAMP, INTERVAL  1 DAY))
ORDER BY user_id ASC;

/*Display list of order items which are in “shipped” state for particular Order Id (i.e.: 1020))*/
SELECT c.cart_id as Items,c.item_status,COUNT(o.user_id)
FROM Orders AS o
INNER JOIN Cart as c
ON o.user_id=c.user_id
WHERE c.user_id=1 and item_status="Order Not Placed";



select Count(order_id) from Orders

