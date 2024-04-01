with final as (
    select distinct ctgry.name as genre,
        count(cstmr.customer_id) as demand, sum(pymnt.amount) as total_sales
from category ctgry
inner join film_category flm_ctgry on ctgry.category_id = flm_ctgry.category_id
inner join film on flm_ctgry.film_id = film.film_id
inner join inventory invtry on film.film_id = invtry.film_id
inner join rental rntl on invtry.inventory_id = rntl.inventory_id
inner join customer cstmr on rntl.customer_id = cstmr.customer_id
inner join payment pymnt on rntl.rental_id = pymnt.rental_id
group by ctgry.category_id, ctgry.name
order by demand desc, total_sales desc
limit 3
)

select *
from final