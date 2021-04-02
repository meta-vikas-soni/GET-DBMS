# SQL Query to create a function to calculate number of orders in a month.
# Month and year will be input parameter to function.
DELIMITER $$
CREATE FUNCTION getNumberOfOrdersInMonth(
    month INT,
    year INT
) 
RETURNS INT

DETERMINISTIC
BEGIN
    DECLARE numbeOfOrders INT;
    SET numbeOfOrders = (
    SELECT COUNT(Order_Id) 
    FROM Orders 
    WHERE Month(order_timestamp)=month AND Year(order_timestamp)=year
    );
    RETURN numbeOfOrders;
END $$

DELIMITER ;

SELECT getNumberOfOrdersInMonth(4,2021);

# Create a function to return month in a year having maximum orders.
# Year will be input parameter.

DELIMITER $$
CREATE FUNCTION getMonthOfMaximumOrders(year INT)
RETURNS VARCHAR(10)
DETERMINISTIC

BEGIN
    DECLARE monthOfMaximumOrders VARCHAR(10);
    SET monthOfMaximumOrders =  (
        SELECT MONTHNAME(order_timestamp)
        FROM Orders
        WHERE YEAR(order_timestamp)= year
        GROUP BY MONTHNAME(order_timestamp)
        Order BY COUNT(order_id) DESC
        LIMIT 1
    );
                
    RETURN monthOfMaximumOrders;
END $$
DELIMITER ;
drop function getMonthOfMaximumOrders;

SELECT getMonthOfMaximumOrders(2021);

###################

#SQL Query to create a Stored procedure to retrieve average 
#sales of each product in a month.
DELIMITER $$
CREATE PROCEDURE getAverageSale (IN month INT,IN year INT)

BEGIN
    SELECT c.prod_id,p.prod_name,AVG(c.item_quantity) AS Average_No_of_Sales
    FROM Cart as c
    LEFT JOIN Products as p
    ON c.prod_id = p.prod_id
    INNER JOIN Orders as o
    ON o.cart_id = c.cart_id
    WHERE Year(o.order_timestamp) = year AND Month(o.order_timestamp)=month
    GROUP BY p.prod_id
    ORDER BY p.prod_id;
END $$
DELIMITER ;

CALL getAverageSale(4,2021);

#SQL query to create a stored procedure to retrieve table
#having order detail with status for a given period.
DELIMITER $$
CREATE PROCEDURE getOrderDetails(IN start_date DATE,IN end_date DATE)

BEGIN
    SELECT o.order_id, o.user_id, DATE(o.order_timestamp), c.item_status
    FROM Orders as o
    LEFT JOIN Cart as c
    ON c.cart_id = o.cart_id
    WHERE DATE(o.order_timestamp)
    BETWEEN start_date AND end_date;
END $$
DELIMITER ;

CALL getOrderDetails('2021-3-20','2021-4-10');

###########
# SQL query to create index in Product table

ALTER TABLE Products
ADD INDEX Product_Index(prod_id);

Show Index from Products;
##
ALTER TABLE Cart
ADD INDEX Product_Status_Index(item_status);

Show Index from Cart;

# SQL query to create index in Orders table

ALTER TABLE Orders ADD INDEX Order_Index(Order_Id);

Show Index from Orders;
##
ALTER TABLE Cart ADD INDEX OrderItem_Index(cart_id);

Show Index from Cart;