with final as (
    select distinct year(rental_date) as years,
        case when datediff(day, rntl.rental_date, rntl.return_date) > flm.rental_duration 
            then 'early_return'
        when datediff(day, rntl.rental_date, rntl.return_date) < flm.rental_duration
            then 'late_return'
        else 'on_time'
        end as rental_return_type,
        count(rental_return) over (partition by years, rental_return) as rental_performance
from rental rntl
left join inventory invntry on rntl.inventory_id = invntry.inventory_id
left join film flm on invntry.film_id = flm.film_id
order by rental_performance desc)

select  * 
from final;