with final as (
    select
        case when datediff(day, rntl.rental_date, rntl.return_date) > flm.rental_duration 
            then 'early_return'
        when datediff(day, rntl.rental_date, rntl.return_date) < flm.rental_duration
            then 'late_return'
        else 'on_time'
        end as rental_return_type,
        {# count(rental_return_type) over (partition by years, rental_return_type) as rental_performance #}
        count(1) as total_rental_status
from rental rntl
inner join inventory invntry on rntl.inventory_id = invntry.inventory_id
inner join film flm on invntry.film_id = flm.film_id
order by rental_performance desc)

select  * 
from final