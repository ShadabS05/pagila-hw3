/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT f.title
FROM film f
JOIN film_category fc1 ON f.film_id = fc1.film_id
JOIN category c1 ON fc1.category_id = c1.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE c1.category_id IN (
    SELECT category_id
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)
AND fa.actor_id IN (
    SELECT actor_id
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)
GROUP BY f.film_id
HAVING COUNT(DISTINCT c1.category_id) >= 2
ORDER BY f.title;

