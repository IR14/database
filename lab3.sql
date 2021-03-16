CREATE or REPLACE VIEW remains AS
SELECT a.name, a.release_form, a.dosage, a.minimal_stock, a.pharmacy_amount 
FROM medicines a
WHERE a.pharmacy_amount < a.minimal_stock;

SELECT * FROM remains;

UPDATE remains
set release_form = 'Сapsules' WHERE pharmacy_amount = 0;
DELETE from remains where dosage < 5;
INSERT into remains VALUES (234567, 'Pills', 3, 3);

CREATE OR REPLACE view companies_zero AS
SELECT A.company FROM medicines A
WHERE A.pharmacy_amount = 0;

SELECT * FROM companies_zero;

UPDATE companies_zero
SET company = 'RPharm' WHERE company != 'RPharm';
DELETE FROM company WHERE company = 'RPharm';
INSERT INTO company VALUES ('NAOS');

CREATE OR REPLACE view recipe AS
SELECT A.health_insurance, A.full_name,
       (SELECT min(B.date) FROM only_by_prescription B WHERE B.full_name=A.full_name),
       (SELECT MAX(B.date) FROM only_by_prescription B WHERE B.full_name=A.full_name),
       count(A) as Purchases
FROM only_by_prescription A
GROUP BY A.full_name, A.health_insurance;

SELECT * FROM recipe;

UPDATE recipe
set purchases = 1 WHERE purchases > 1;
DELETE from full_name WHERE purchases = 1;
insert INTO min VALUEs ('2021-03-12');
