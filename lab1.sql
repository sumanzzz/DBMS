--Insurance Database--
--1.	Find the total number of people who owned cars that were involved in accidents in 1989--

select count(distinct O.driverid)
from OWNS O,PARTCIPATED P,ACCIDENT A
where O.driverid=P.driverid and P.reportno=A.reportno and year(A.accdate)='2001'


--2.	Find the number of accidents in which the cars belonging to “John Smith” were involved.
SELECT COUNT(DISTINCT report_number) AS NumOfAccidents
FROM PARTICIPATED
WHERE regno IN (
    SELECT regno
    FROM OWNS
    WHERE driver_id# IN (
        SELECT driver_id#
        FROM PERSON
        WHERE name = 'John Smith'
    )
);

