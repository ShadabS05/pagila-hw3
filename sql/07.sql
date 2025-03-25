/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH table1 AS (
    SELECT actor.actor_id, actor.first_name, actor.last_name
    FROM film_actor
    LEFT JOIN actor USING (actor_id)
    LEFT JOIN film USING (film_id)
    WHERE film.title IN (
        SELECT film.title
        FROM film_actor
        LEFT JOIN actor USING (actor_id)
        LEFT JOIN film USING (film_id)
        WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
    )
    AND (actor.first_name != 'RUSSELL' OR actor.last_name != 'BACALL')
    GROUP BY actor.actor_id, actor.first_name, actor.last_name
)
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS "Actor Name"
FROM film_actor
LEFT JOIN actor USING (actor_id)
LEFT JOIN film USING (film_id)
WHERE film.title IN (
    SELECT film.title
    FROM film_actor
    LEFT JOIN actor USING (actor_id)
    LEFT JOIN film USING (film_id)
    WHERE EXISTS (
        SELECT 1
        FROM table1
        WHERE table1.actor_id = actor.actor_id
    )
    GROUP BY film.title
)
AND NOT EXISTS (
    SELECT 1
    FROM table1
    WHERE table1.actor_id = actor.actor_id
)
AND NOT (actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL')
GROUP BY "Actor Name"
ORDER BY "Actor Name";

