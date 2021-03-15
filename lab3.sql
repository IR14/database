CREATE or REPLACE VIEW remains AS
SELECT a.name, a.release_form, a.dosage, a.minimal_stock, a.pharmacy_amount 
FROM medicines a
WHERE a.pharmacy_amount < a.minimal_stock;

SELECT * FROM remains;

CREATE OR REPLACE view companies_zero AS
SELECT A.company FROM medicines A
WHERE A.pharmacy_amount = 0;

SELECT * FROM companies_zero;

CREATE OR REPLACE view recipe AS
SELECT A.health_insurance,
	     A.full_name,
       (SELECT min(B.date) FROM only_by_prescription B WHERE B.full_name=A.full_name),
       (SELECT MAX(B.date) FROM only_by_prescription B WHERE B.full_name=A.full_name),
       count(A)
FROM only_by_prescription A
GROUP BY A.full_name, A.health_insurance;

SELECT * FROM recipe;
