/* For each customer, find the movie that they have rented most recently.
 *
 * NOTE:
 * This problem can be solved with either a subquery (using techniques we've covered in class),
 * or a new type of join called a LATERAL JOIN.
 * You are not required to use LATERAL JOINs,
 * and we will not cover in class how to use them.
 * Nevertheless, they can greatly simplify your code,
 * and so I recommend that you learn to use them.
 * The website <https://linuxhint.com/postgres-lateral-join/> provides a LATERAL JOIN that solves this problem.
 * All of the subsequent problems in this homework can be solved with LATERAL JOINs
 * (or slightly less conveniently with subqueries).
 */
WITH ranked_rentals AS (
    SELECT customer.customer_id, 
           customer.first_name, 
           customer.last_name, 
           film.title, 
           rental.rental_date,
           ROW_NUMBER() OVER (PARTITION BY customer.customer_id ORDER BY rental.rental_date DESC) AS rental_rank
    FROM customer
    JOIN rental USING (customer_id)
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
)
SELECT first_name, 
       last_name, 
       title, 
       rental_date
FROM ranked_rentals
WHERE rental_rank = 1
ORDER BY last_name;

