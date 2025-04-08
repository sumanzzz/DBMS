/*
Consider the following database of student enrollment in courses & books adopted for each course:

STUDENT (regno: string, name: string, major: string, bdate: date)
COURSE (course #: int, cname: string, dept: string)
ENROLL (regno: string, course#: int, sem: int marks: int)
BOOK _ ADOPTION (course#: int, sem: int, book-ISBN: int)
TEXT (book-ISBN: int, book-title: string, publisher: string, author: string)
*/

--1.	Produce a list of text books (include Course #, Book-ISBN,Book-title) in the alphabetical 
--order for courses offered by th   ‘CS’ department that use more than two books.

SELECT 
    c.course AS 'Course #',
    ba.bookISBN AS 'Book-ISBN',
    tb.title AS 'Book-title'
FROM 
    COURSE c
JOIN 
    BOOK_ADAPTION ba ON c.course = ba.course
JOIN 
    TEXTBOOK tb ON ba.bookISBN = tb.bookISBN
WHERE 
    c.dept = 'CS'
    AND c.course IN (
        SELECT course
        FROM BOOK_ADAPTION
        GROUP BY course
        HAVING COUNT(DISTINCT bookISBN) > 2
    )
ORDER BY 
    tb.title ASC;
--2.	List any department that has all its adopted books published by a specific publisher
SELECT DISTINCT
    c.dept
FROM 
    COURSE c
WHERE NOT EXISTS (
    SELECT ba.bookISBN
    FROM BOOK_ADAPTION ba
    JOIN TEXTBOOK tb ON ba.bookISBN = tb.bookISBN
    WHERE ba.course = c.course
    AND tb.publisher <> 'McGraw'
);

--3.	List the bookISBNs and book titles of the department that has maximum number of students
SELECT 
    tb.bookISBN,
    tb.title
FROM 
    TEXTBOOK tb
JOIN 
    BOOK_ADAPTION ba ON tb.bookISBN = ba.bookISBN
JOIN 
    COURSE c ON ba.course = c.course
WHERE 
    c.dept = (
        SELECT TOP 1 c.dept
        FROM ENROLL e
        JOIN COURSE c ON e.course = c.course
        GROUP BY c.dept
        ORDER BY COUNT(DISTINCT e.regno) DESC
    );
