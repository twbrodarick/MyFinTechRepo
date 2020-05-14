-- sales by category
select c.name, 
	sum(p.inventory) as total_inventory
from
	category c 
	inner join film_category fc
	on c.category_id = fc.category_id
	inner join inventory i
	on fc.film_id = i.film_id
	inner join rental r
	on i.inventory_id = r.inventory_id
	inner join payment p
	on r.rental_id = p.rental_id
group by c.name
order by sum(p.inventory)
fetch first 1 rows only;