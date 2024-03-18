with final as (
    select distinct concat(cstmr.first_name, ' ', cstmr.last_name) as loyal_customer,
        concat(cntry.country, ' | ', city.city, ', ', addr.address) as full_address,
        count(rntl.rental_id) over (partition by loyal_customer) as rentals
from rental rntl
inner join customer cstmr on cstmr.customer_id = rntl.customer_id
left join address addr on cstmr.address_id = addr.address_id
left join city on city.city_id = addr.city_id
left join country cntry on cntry.country_id = city.country_id
order by rentals desc)

select *
from final