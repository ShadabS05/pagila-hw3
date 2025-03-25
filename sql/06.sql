/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS "Actor Name"
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
GROUP BY "Actor Name"
ORDER BY "Actor Name";
