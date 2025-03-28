/*
 * Compute the number of customers who live outside of the US.
 *
 * NOTE:
 * It is possible to solve this problem with the "cheesy" query
 * ```
 * SELECT 563 AS count;
 * ```
 * Although this type of query will pass the test case for your homework,
 * it will not score you any points on your midterm/final exams.
 * I therefore strongly recommend that you solve this query "properly".
 *
 * Your goal should be to have your queries remain correct even if the data in the database changes arbitrarily.
 */
SELECT count(*) AS count
FROM (
	SELECT customer_id
	FROM customer
	LEFT JOIN address USING (address_id)
	LEFT JOIN city USING (city_id)
	LEFT JOIN country USING (country_id)
	WHERE country!='United States'
	ORDER BY customer_id
) as a;
