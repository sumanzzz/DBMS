/*
. Order Database 

Consider the following relations for an order processing database application in a company:

CUSTOMER (cust #: int, cname: string, city: string)
ORDER (order #: int, odate: date, cust #: int, ord-Amt: int)
ORDER – ITEM (order #: int, item #: int, qty: int)
ITEM (item #: int, unit price: int)
SHIPMENT (order #: int, warehouse#: int, ship-date: date)
WAREHOUSE (warehouse #: int, city: string)

*/

--1.	Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, 
--where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that customer.

SELECT 
    c.cname AS CUSTNAME,
    COUNT(o.orderid) AS '#oforders',
    AVG(o.ordamt) AS AVG_ORDER_AMT
FROM 
    CUSTOMER c
LEFT JOIN 
    C_ORDER o ON c.custid = o.custid
GROUP BY 
    c.cname;


--2.	For each item that has more than two orders , 
--list the item, number of orders that are  shipped from atleast two warehouses and total  quantity of items shipped

SELECT 
    i.itemid AS Item,
    COUNT(DISTINCT oi.orderid) AS NumberOfOrders,
    COUNT(DISTINCT s.warehouseid) AS NumberOfWarehouses,
    SUM(oi.qty) AS TotalQuantityShipped
FROM 
    ITEM i
JOIN 
    ORDER_ITEM oi ON i.itemid = oi.itemid
JOIN 
    SHIPMENT s ON oi.orderid = s.orderid
GROUP BY 
    i.itemid
HAVING 
    COUNT(DISTINCT oi.orderid) > 2
    AND COUNT(DISTINCT s.warehouseid) >= 2;



--3.	List the customers who have ordered for every item that the company produces


SELECT 
    c.cname AS CustomerName
FROM 
    CUSTOMER c
WHERE NOT EXISTS (
    SELECT 
        i.itemid 
    FROM 
        ITEM i
    WHERE NOT EXISTS (
        SELECT 
            1 
        FROM 
            C_ORDER o
        JOIN 
            ORDER_ITEM oi ON o.orderid = oi.orderid
        WHERE 
            o.custid = c.custid 
            AND oi.itemid = i.itemid
    )
);