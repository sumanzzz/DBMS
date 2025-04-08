/*
The following tables are maintained by a book dealer:
AUTHOR (author-id: int, name: string, city: string, country: string)
PUBLISHER (publisher-id: int, name: string, city: string, country: string)
CATALOG (book-id: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)
CATEGORY (category-id: int, description: string)
ORDER-DETAILS (order-no: int, book-id: int, quantity: int)
*/

--1.	Find the author of the book which has maximum sales.

SELECT TOP 1
    a.aname AS AuthorName,
    c.title AS BookTitle,
    SUM(od.qty) AS TotalSales
FROM
    AUTHOR a
JOIN
    CATALOGUE c ON a.authorid = c.authorid
JOIN
    ORDER_DET od ON c.bookid = od.bookid
GROUP BY
    a.aname, c.title
ORDER BY
    TotalSales DESC;


--2.	Increase the price of the books published by a specific publisher by 10%

UPDATE CATALOGUE
SET price = price * 1.10
WHERE pubid = 202;

SELECT bookid, title, price 
FROM CATALOGUE 
WHERE pubid = 202;

--3.	Find the number of orders for the book that has minimum sales.
SELECT 
    c.bookid,
    c.title,
    COUNT(DISTINCT od.ordno) AS NumberOfOrders,
    SUM(od.qty) AS TotalSales
FROM 
    CATALOGUE c
JOIN 
    ORDER_DET od ON c.bookid = od.bookid
GROUP BY 
    c.bookid, c.title
HAVING 
    SUM(od.qty) = (
        SELECT MIN(TotalSales)
        FROM (
            SELECT SUM(qty) AS TotalSales
            FROM ORDER_DET
            GROUP BY bookid
        ) AS MinSales
    ); 


