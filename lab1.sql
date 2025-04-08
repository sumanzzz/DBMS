/*
Consider the Insurance database given below. 
PERSON (driver – id #: String, name: string, address: string)
CAR (regno: string, model: string, year: int)
ACCIDENT (report-number: int, accd-date: date, location: string)
OWNS (driver-id #: string, regno: string)
PARTICIPATED (driver-id: string, Regno: string, report-number: int, damage amount: int)
*/



--1)Find the total number of people who owned cars that were involved in accidents in 1989.--

select count (distinct P.driverid)
from accident A, partcipated P
where A.reportno = P.reportno
and year(A.accdate) = '1998'

or

SELECT COUNT(DISTINCT o.driverid)
FROM ACCIDENT a, PARTICIPATED p, OWNS o
WHERE a.report = p.report
  AND p.regno = o.regno
  AND YEAR(a.accdate) = 1989;

--2)Find the number of accidents in which the cars belonging to “John Smith” were involved.

select count(distinct pa.report)
from person p, owns o, participated pa
where p.driverid = o.driverid
and o.regno = pa.regno
and p.dname = 'John Smith';

--3)Update the damage amount for the car with reg number “KA-12” in the accident with report number “1” to $3000.

update participated
set dmgamt = 3000
where regno = 'KA-12' and report = 1;
