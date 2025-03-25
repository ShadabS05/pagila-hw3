/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT country.country, SUM(payment.amount) AS total_payments
    FROM payment
    LEFT JOIN customer USING (customer_id)
    LEFT JOIN address USING (address_id)
    LEFT JOIN city USING (city_id)
    LEFT JOIN country USING (country_id)
    GROUP BY country.country
    ORDER BY total_payments DESC, country.country;
