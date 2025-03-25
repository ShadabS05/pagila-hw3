/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */
SELECT f.title
FROM film f
WHERE f.film_id IN (
SELECT f.film_id
FROM film_actor fa
JOIN actor a USING (actor_id)
JOIN film f USING (film_id)
JOIN film_actor fa2 ON fa.actor_id = fa2.actor_id
JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f2.title IN ('AMERICAN CIRCUS')
GROUP BY f.film_id
ORDER BY f.title
)
INTERSECT
SELECT f.title
FROM film f
WHERE f.film_id IN (
SELECT f.film_id
FROM film_actor fa
JOIN actor a USING (actor_id)
JOIN film f USING (film_id)
JOIN film_actor fa2 ON fa.actor_id = fa2.actor_id
JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f2.title IN ('ACADEMY DINOSAUR')
GROUP BY f.film_id
ORDER BY f.title
)
INTERSECT
SELECT f.title
FROM film f
WHERE f.film_id IN (
SELECT f.film_id
FROM film_actor fa
JOIN actor a USING (actor_id)
JOIN film f USING (film_id)
JOIN film_actor fa2 ON fa.actor_id = fa2.actor_id
JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f2.title IN ('AGENT TRUMAN')
GROUP BY f.film_id
ORDER BY f.title
) ORDER BY title;
