/*
The following tables are maintained by a book dealer:
AUTHOR (author-id: int, name: string, city: string, country: string)
PUBLISHER (publisher-id: int, name: string, city: string, country: string)
CATALOG (book-id: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)
CATEGORY (category-id: int, description: string)
ORDER-DETAILS (order-no: int, book-id: int, quantity: int)

1.	Find the author of the book which has maximum sales.
2.	Increase the price of the books published by a specific publisher by 10%
3.	Find the number of orders for the book that has minimum sales. 
*/

1.select * from  tb_auth   where QTY_SUM in (select max(QTY_SUM) from tb_auth)