/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
SELECT
    f.title,
    f.actors
FROM
    nicer_but_slower_film_list as f
WHERE    
    f.category = 'Documentary'
    AND f.rating = 'G'
GROUP BY
    f.title, f.actors
ORDER BY
    f.title;
