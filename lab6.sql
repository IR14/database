CREATE TABLE Medicine_list
(
  Id_medicine NUMERIC(6) PRIMARY KEY,
  Name_medicine VARCHAR(30) NOT NULL,
  Prescription VARCHAR(3) DEFAULT 'no' CHECK (Prescription in ('no', 'yes'))
);

CREATE TABLE Companies
(
  Company_name VARCHAR(25) PRIMARY KEY,
  Country VARCHAR(20)
);

CREATE TABLE Medicines
(
  Id NUMERIC(8) PRIMARY KEY,
  Name NUMERIC(6),
  Release_form VARCHAR(20) NOT NULL,
  Package_amount NUMERIC(3) NOT NULL,
  Company VARCHAR(25),
  Dosage NUMERIC(8,3) NOT NULL,
  Pharmacy_amount NUMERIC(4),
  Price NUMERIC(8,2) NOT NULL CHECK (Price > 0),
  Minimal_stock NUMERIC(4) NOT NULL,
  FOREIGN KEY (Name) REFERENCES Medicine_list (Id_medicine),
  FOREIGN KEY (Company) REFERENCES Companies (Company_name)
);

CREATE OR REPLACE FUNCTION nessesary(pharmacy_amount NUMERIC, minimal_stock NUMERIC)
RETURNS TEXT
AS $$
BEGIN
  IF pharmacy_amount < minimal_stock THEN
  RETURN 'Необходимо закупить';
  ELSEIF 0.7*pharmacy_amount < minimal_stock THEN
  RETURN 'Подходит к концу';
  ELSE
  RETURN '';
  END IF;
END;
$$ LANGUAGE plpgsql;

INSERT INTO Medicine_list VALUES (123456, 'Penicillin', 'no');
INSERT INTO Companies VALUES ('RPharm', 'Russia');
INSERT INTO Medicines VALUES (11223344, 123456, 'Сapsules', 10, 'RPharm', 1.25, 999, 3.5, 4);

SELECT nessesary(5, 6) FROM medicines A
SELECT nessesary(8.5, 6) FROM medicines A
SELECT nessesary(A.Pharmacy_amount, A.Minimal_stock) FROM medicines A

CREATE TABLE report
(
medicine_name VARCHAR(30) NOT NULL,
company VARCHAR(25) NOT NULL,
remains NUMERIC(4),
description VARCHAR(19)
);

CREATE OR REPLACE FUNCTION make_report(param NUMERIC)
RETURNS VOID
AS $$
BEGIN
  IF param = 0 THEN
  DELETE FROM report;
  END IF;
  INSERT INTO report
  SELECT 
  (SELECT C.name_medicine WHERE C.id_medicine = A.name) as medicine_name,
  a.company as company,
  a.pharmacy_amount as remains,
  B as description
  FROM medicines A, nessesary(A.pharmacy_amount,A.minimal_stock) B, medicine_list c
  WHERE B != '';
END;
$$ LANGUAGE plpgsql;

INSERT INTO Medicines VALUES (11223345, 123456, 'Сapsules', 10, 'RPharm', 1.25, 5, 3.5, 6);

SELECT make_report(1)

SELECT make_report(1)

SELECT make_report(0)
