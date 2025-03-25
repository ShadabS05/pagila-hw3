/*
 * Compute the country with the most customers in it. 
 */
SELECT a.country
FROM (
    SELECT country.country, COUNT(customer_id) AS customer_count
    FROM customer
    LEFT JOIN address USING (address_id)
    LEFT JOIN city USING (city_id)
    LEFT JOIN country USING (country_id)
    GROUP BY country.country
) AS a
WHERE a.customer_count = (
    SELECT MAX(customer_count)
    FROM (
        SELECT COUNT(customer_id) AS customer_count
        FROM customer
        LEFT JOIN address USING (address_id)
        LEFT JOIN city USING (city_id)
        LEFT JOIN country USING (country_id)
        GROUP BY country.country
    ) AS b
);

