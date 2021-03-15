CREATE or REPLACE VIEW remains AS
SELECT a.name, a.release_form, a.dosage, a.minimal_stock, a.pharmacy_amount 
FROM medicines a
WHERE a.pharmacy_amount < a.minimal_stock;

SELECT * FROM remains;
