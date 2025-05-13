-- CREATE TABLE
CREATE TABLE shipping_summary
(
    shipping_date date,
    seller_name character varying,
    buyer_name character varying,
    buyer_address character varying,
    buyer_city character varying,
    buyer_zipcode character varying,
    receipt_code character varying
);

-- INSERT DATA
INSERT INTO shipping_summary (shipping_date, seller_name, buyer_name, buyer_address, buyer_city, buyer_zipcode, receipt_code)
SELECT 
    s.shipping_date,
    se.seller_name,
    b.buyer_name,
    b.address AS buyer_address,
    b.city AS buyer_city,
    b.zipcode AS buyer_zipcode,
	CONCAT(
        s.shipping_id, '-', 
        TO_CHAR(s.purchase_date, 'YYYYMMDD'), '-', 
        TO_CHAR(s.shipping_date, 'YYYYMMDD'), '-', 
        s.buyer_id, '-', 
        s.seller_id
    ) AS receipt_code
FROM 
    shipping_table s
JOIN 
    seller_table se ON s.seller_id = se.seller_id
JOIN 
    buyer_table b ON s.buyer_id = b.buyer_id
WHERE s.shipping_date BETWEEN '2022-12-01' AND '2022-12-31';


-- SHOW DATA
SELECT * FROM shipping_summary;