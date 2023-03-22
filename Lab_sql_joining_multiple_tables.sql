USE sakila;

#1 Write a query to display for each store its store ID, city, and country.
SELECT a.store_id, c.city, d.country
FROM store a
JOIN address b
ON a.address_id = b.address_id
JOIN city c
ON b.city_id = c.city_id
JOIN country d
ON c.country_id = d.country_id;

#2 Write a query to display how much business, in dollars, each store brought in.
SELECT a.store_id, SUM(c.amount) AS Total_Amount_USD
FROM store a
JOIN staff b
ON a.store_id = b.store_id
JOIN payment c
ON b.staff_id = c.staff_id
GROUP BY a.store_id;

#3 What is the average running time of films by category?
SELECT a.name, ROUND(AVG(c.length),2) AS Average_Time
FROM category a
JOIN film_category b
ON a.category_id = b.category_id
JOIN film c
ON b.film_id = c.film_id
GROUP BY a.category_id;

#4 Which film categories are longest?
SELECT a.name, ROUND(AVG(c.length),2) AS Average_Time
FROM category a
JOIN film_category b
ON a.category_id = b.category_id
JOIN film c
ON b.film_id = c.film_id
GROUP BY a.category_id
ORDER BY Average_Time DESC
LIMIT 3;

#5 Display the most frequently rented movies in descending order.
SELECT c.title, COUNT(a.rental_id) AS Amount_Rented
FROM rental a
JOIN inventory b
ON a.inventory_id = b.inventory_id
JOIN film c
ON b.film_id = c.film_id
GROUP BY c.title
ORDER BY Amount_Rented DESC
LIMIT 5;

#6 List the top five genres in gross revenue in descending order.
SELECT a.name, SUM(f.amount) AS Revenue
FROM category a
JOIN film_category b
ON a.category_id = b.category_id
JOIN film c
ON b.film_id = c.film_id
JOIN inventory d
ON c.film_id = d.film_id
JOIN rental e
ON d.inventory_id = e.inventory_id
JOIN payment f
ON e.rental_id = f.rental_id
GROUP BY a.name
ORDER BY Revenue DESC
LIMIT 5; 


#7 Is "Academy Dinosaur" available for rent from Store 1?
SELECT a.title, c.return_date 
FROM film a
JOIN inventory b
ON a.film_id = b.film_id
JOIN rental c
ON b.inventory_id = c.inventory_id
WHERE a.title = "Academy Dinosaur"
AND return_date IS NULL
AND b.store_id = 2;
#ANS : there are no copies left in store 1, but there are 2 copies available in store 2.
