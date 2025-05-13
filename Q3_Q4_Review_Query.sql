CREATE TABLE q3_q4_review
(
    purchase_date date,
    total_price numeric,
    promo_code character varying,
    sales_after_promo numeric,
    status_promo character varying
);

-- INSERT DATA
INSERT INTO q3_q4_review (purchase_date, total_price, promo_code, sales_after_promo, status_promo)
SELECT 
    s.purchase_date,
    s.quantity * m.price AS total_price, 
    CASE 
        WHEN p.promo_id BETWEEN 1 AND 11 THEN p.promo_name
        ELSE NULL
    END AS promo_code, 
    CASE 
        WHEN p.promo_id BETWEEN 1 AND 11 THEN (s.quantity * m.price) - p.price_deduction
        ELSE s.quantity * m.price
    END AS sales_after_promo,
    CASE 
        WHEN p.promo_id BETWEEN 1 AND 11 THEN 'Promo'
        ELSE 'Non Promo'
    END AS status_promo
FROM sales_table s
JOIN marketplace_table m ON s.item_id = m.item_id
LEFT JOIN promo_code p ON p.promo_id = s.promo_id
WHERE s.purchase_date BETWEEN '2022-07-01' AND '2022-12-31';

-- SHOW DATA
SELECT * FROM q3_q4_review
ORDER BY purchase_date, total_price;