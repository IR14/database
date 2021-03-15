--1
select a.full_name, a.date from only_by_prescription a

--2
select a.company from medicines a where a.pharmacy_amount > 100 GROUP by a.company

--3
select * from medicine_list, companies

--4
select * from medicines a WHERE a.price > 3.5 UNION SELECT * FROM medicines a where a.price < 500

--5
SELECT * FROM medicines a 
where a.id NOT IN 
(SELECT B.Drug from only_by_prescription B);

--6
select * from only_by_prescription a WHERE amount = 1 AND a.health_insurance = '5552222444'

--7
select * 
from medicines a 
INNER JOIN medicine_list B ON a.name = B.id_medicine 
