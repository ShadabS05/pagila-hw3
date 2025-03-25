/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT film.title
FROM film_actor
LEFT JOIN actor USING (actor_id)
LEFT JOIN film USING (film_id)
WHERE actor.actor_id IN (
    SELECT actor.actor_id
    FROM film_actor
    LEFT JOIN actor USING (actor_id)
    LEFT JOIN film USING (film_id)
    WHERE film.title = 'AMERICAN CIRCUS'
)
GROUP BY film.title
HAVING COUNT(DISTINCT actor.actor_id) >= 2;

