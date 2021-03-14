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

CREATE TABLE Only_by_prescription
(
  Drug NUMERIC(8),
  Recipe_num NUMERIC(10) NOT NULL,
  Full_name VARCHAR(45) NOT NULL,
  Health_insurance NUMERIC(10) NOT NULL,
  Date VARCHAR(20) NOT NULL,
  Amount NUMERIC(3) NOT NULL,
  FOREIGN KEY (Drug) REFERENCES Medicines (Id)
);

INSERT INTO Medicine_list VALUES (123456, 'Penicillin', 'no');
INSERT INTO Medicine_list VALUES (234567, 'Paracetamol', 'no');
INSERT INTO Medicine_list VALUES (345678, 'Morphine', 'yes');

INSERT INTO Companies VALUES ('RPharm', 'Russia');
INSERT INTO Companies VALUES ('LAMC', 'The USA');
INSERT INTO Companies VALUES ('Никомед', 'Russia');

INSERT INTO Medicines VALUES (11223344, 123456, 'Сapsules', 10, 'RPharm', 1.25, 999, 3.5, 4);
INSERT INTO Medicines VALUES (22334455, 234567, 'Pills', 20, 'Никомед', 2, 0, 4.7, 3);
INSERT INTO Medicines VALUES (22334455, 234567, 'Pills', 15, 'RPharm', 3, 0, 4, 0);
INSERT INTO Medicines VALUES (33445566, 345678, 'Dropper liquid', 1, 'Morphine', 0.07 , 12, 985, 1);

INSERT INTO Only_by_prescription VALUES (33445566, 1234567890, 'Maria Brown', 5552222444, "1999.05.23", 0.5);
