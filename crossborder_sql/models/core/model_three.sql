with final as (
    select distinct ctgry.name as genre, 
        year(rental_date) as years,
        count(rntl.rental_id) as demand, sum(pymnt.amount) as total_sales
from category ctgry
right join film_category flm_ctgry on ctgry.category_id = flm_ctgry.category_id
right join film on flm_ctgry.film_id = film.film_id
right join inventory invtry on film.film_id = invtry.film_id
right join rental rntl on invtry.inventory_id = rntl.inventory_id
join payment pymnt on rntl.rental_id = pymnt.rental_id
group by ctgry.category_id, ctgry.name, years
order by demand desc, total_sales desc
limit 3
)

select *
from final