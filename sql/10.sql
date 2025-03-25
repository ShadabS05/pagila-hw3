/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */
SELECT a.customer_id, a.name, a.total_payment, a.percentile
FROM (
    SELECT customer.customer_id, 
           CONCAT(customer.first_name, ' ', customer.last_name) AS name, 
           SUM(payment.amount) AS total_payment,
           ntile(100) OVER (ORDER BY SUM(payment.amount)) AS percentile
    FROM rental
    JOIN payment USING (rental_id)
    JOIN customer ON payment.customer_id = customer.customer_id
    GROUP BY customer.customer_id
) AS a
WHERE a.percentile >= 90
ORDER BY a.name;
