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

CREATE TABLE Medicines_old
(
Id_old NUMERIC(8) NOT NULL,
Name_old NUMERIC(6),
Release_form_old VARCHAR(20) NOT NULL,
Package_amount_old NUMERIC(3) NOT NULL,
Company_old VARCHAR(25),
Dosage_old NUMERIC(8,3) NOT NULL,
Pharmacy_amount_old NUMERIC(4),
Price_old NUMERIC(8,2) NOT NULL CHECK (Price_old > 0),
Minimal_stock_old NUMERIC(4) NOT NULL,
Change_date TIMESTAMP,
Change_user NAME,
FOREIGN KEY (Name_old) REFERENCES Medicine_list (Id_medicine),
FOREIGN KEY (Company_old) REFERENCES Companies (Company_name)
);

CREATE OR REPLACE FUNCTION replication()
RETURNS TRIGGER
LANGUAGE plpgSQL
AS $$
BEGIN
INSERT INTO medicines_old values(OLD.Id,OLD.Name,OLD.Release_form,OLD.Package_amount,OLD.Company,OLD.Dosage,OLD.Pharmacy_amount,OLD.Price,OLD.Minimal_stock,current_timestamp,current_user);
RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_replication
BEFORE DELETE ON medicines
FOR EACH ROW
EXECUTE FUNCTION replication();

INSERT INTO Medicine_list VALUES (123456, 'Penicillin', 'no');
INSERT INTO Companies VALUES ('RPharm', 'Russia');
INSERT INTO Medicines VALUES (11223344, 123456, 'Сapsules', 10, 'RPharm', 1.25, 999, 3.5, 4);

DELETE FROM Medicines WHERE ID='11223344';
SHOW * FROM Medicines_old;

