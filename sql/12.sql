/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
CROSS JOIN LATERAL (
    SELECT COUNT(*) AS action_count
    FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    JOIN film_category fc USING (film_id)
    JOIN category ca USING (category_id)
    WHERE r.customer_id = c.customer_id
    AND ca.name = 'Action'
    AND r.rental_date IN (
        SELECT r2.rental_date
        FROM rental r2
        WHERE r2.customer_id = c.customer_id
        ORDER BY r2.rental_date DESC
        LIMIT 5
    )
) AS recent_action_movies
WHERE recent_action_movies.action_count >= 4
ORDER BY c.customer_id;

