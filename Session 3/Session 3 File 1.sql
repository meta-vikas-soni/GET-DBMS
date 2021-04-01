/*Display Count of products as per below price range:*/
SELECT COUNT(o.order_id)
FROM orders as o
INNER JOIN cart as c
ON o.cart_id = c.cart_id
WHERE c.total_price BETWEEN 0 and 50
AND c.item_status != 'Order Not Placed';

SELECT COUNT(o.order_id)
FROM orders as o
INNER JOIN cart as c
ON o.cart_id = c.cart_id
WHERE c.total_price BETWEEN 50 and 500
AND c.item_status != 'Order Not Placed';

SELECT COUNT(o.order_id)
FROM orders as o
INNER JOIN cart as c
ON o.cart_id = c.cart_id
WHERE c.total_price > 500
AND c.item_status != 'Order Not Placed';


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
SELECT u.user_id, u.username, u.first_name, u.last_name, COUNT(order_id) AS 'Total Orders'
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




select * from cart