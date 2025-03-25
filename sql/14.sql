/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH ranked_films AS (
    SELECT
        category.name,
        f.title,
        COUNT(DISTINCT r.rental_id) AS "total rentals",
        ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY COUNT(DISTINCT r.rental_id) DESC, f.title DESC) AS rank
    FROM
        film_actor fa
    JOIN
        actor a USING (actor_id)
    JOIN
        film f USING (film_id)
    JOIN
        film_category fc USING (film_id)
    JOIN
        category USING (category_id)
    JOIN
        inventory i USING (film_id)
    JOIN
        rental r USING (inventory_id)
    GROUP BY
        category.name, f.title
    ORDER BY 
        count(*) DESC, f.title DESC
)
SELECT
    name,
    title,
    "total rentals"
FROM
    ranked_films
WHERE
    rank <= 5
ORDER BY
    name, "total rentals" DESC, title;

