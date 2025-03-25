/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT first_name, last_name
FROM (
	SELECT actor.first_name, actor.last_name
	FROM film_actor	
	LEFT JOIN actor USING (actor_id)
	LEFT JOIN film USING (film_id)
	LEFT JOIN film_category USING (film_id)
	LEFT JOIN category USING (category_id)
	WHERE category.name='Children'
	GROUP BY first_name, last_name
) as a
WHERE (first_name, last_name) NOT IN (
	SELECT actor.first_name, actor.last_name                        FROM film_actor
        LEFT JOIN actor USING (actor_id)
        LEFT JOIN film USING (film_id)
        LEFT JOIN film_category USING (film_id)
        LEFT JOIN category USING (category_id)
        WHERE category.name='Horror'
	GROUP BY first_name, last_name
)
ORDER BY last_name;
