1) WITH CTE_TOP_CUSTOMERS AS (
    SELECT
        se_c.customer_id,
        se_c.first_name,
        se_c.last_name,
        COUNT(DISTINCT se_r.inventory_id) AS distinct_films_rented
    FROM public.customer AS se_c
    INNER JOIN public.rental AS se_r 
	ON se_c.customer_id = se_r.customer_id
    GROUP BY
        se_c.customer_id,
        se_c.first_name,
        se_c.last_name
    ORDER BY
        COUNT(DISTINCT se_r.inventory_id) DESC
    LIMIT 10
)
SELECT
    *
FROM
    CTE_TOP_CUSTOMERS;

2)



3) DROP TABLE IF EXISTS temp_film_inventory;
CREATE TEMPORARY TABLE temp_film_inventory AS
(
SELECT
    se_f.film_id,
    se_f.title,
    COUNT(se_i.inventory_id) AS available_inventory_count
FROM
    public.film AS se_f
    INNER JOIN public.inventory AS se_i 
	ON se_f.film_id = se_i.film_id
    LEFT JOIN public.rental AS se_r 
	ON se_i.inventory_id = se_r.inventory_id AND se_r.return_date IS NULL
GROUP BY
    se_f.film_id,
    se_f.title
	);
	
SELECT *
FROM temp_film_inventory

4)

5)




6)DROP TABLE IF EXISTS store_performance;

CREATE TEMPORARY TABLE store_performance AS(
SELECT
    se_s.store_id,
    SUM(se_p.amount) AS total_revenue,
    AVG(se_p.amount) AS avg_payment_per_rental
FROM
    public.store AS se_s
    INNER JOIN public.staff AS se_st 
	ON se_s.store_id = se_st.store_id
    INNER JOIN public.payment AS se_p 
	ON se_st.staff_id = se_p.staff_id
GROUP BY
    se_s.store_id
);

SELECT *

FROM store_performance