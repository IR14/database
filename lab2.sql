-- sqlite
SELECT a.Name from Medicines a WHERE a.Pharmacy_amount == 0 AND a.company == "Никомед";
-- postgresql
SELECT a.Name from Medicines a WHERE a.Pharmacy_amount = 0 AND a.company = 'Никомед';

SELECT a.Drug FROM Only_by_prescription a WHERE a.Date = CURRENT_DATE;

-- sqlite
SELECT a.Name, a.Release_form, SUM(a.Pharmacy_amount) FROM Medicines a GROUP BY a.Name;
-- postgresql
SELECT a.name, A.release_form, SUM(a.pharmacy_amount) FROM Medicines a GROUP BY a.name, a.release_form;

-- 1
SELECT a.Full_name FROM Only_by_prescription a GROUP BY a.Full_name having count(a.Full_name) >= 2;
-- 2
SELECT a.Full_name FROM Only_by_prescription a GROUP BY a.Full_name having count(*) >= 2;
