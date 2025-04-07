/*BRANCH (branch-name: string, branch-city: string, assets: real)
ACCOUNT (accno: int, branch-name: string, balance: real)
DEPOSITOR (customer-name: string, accno: int)
CUSTOMER (customer-name: string, customer-street: string, customer-city: string)
LOAN (loan-number: int, branch-name: string, amount: real)
BORROWER (customer-name: string, loan-number: int)


1.	Find all the customers who have atleast 2  accounts at all the branches located in a specific city.
2.	Find all the customers who have accounts in atleast 1 branch located in all the cities
3.	Find all the customers who have accounts in atleast 2 branches located in a specific city.*/

1.select D.cname from DEPOSITOR D,ACCOUNT A,BRANCH B where D.accno=A.accno and A.bname=B.bname and B.bcity='karkala'
group by D.cname having count(*)>=2


 2.select C.cname from CUSTOMER  C where not exists(
	           select distinct(B.bcity)   from  BRANCH B where  not exists(
                          select A.bname from ACCOUNT A ,DEPOSITOR D 
                          where  D.accno = A.accno
			              and D.cname =C.cname  
                          and  A.bname  in (
                            select bname from BRANCH where bcity = B.bcity)

			)
		)


3.select C.cname from CUSTOMER  C where  exists(   
	       select  count( distinct B.bname) from BRANCH B, ACCOUNT A ,DEPOSITOR D 
           where A.bname = B.bname
	       and D.accno = A.accno
	       and B.bcity  = 'karkala'
	       and D.cname = C.cname   group by B.bcity having count(*) >=2)
