with final as (
    select distinct concat(cstmr.first_name, ' ', cstmr.last_name) as loyal_customer,
        concat(cntry.country, ' | ', city.city, ', ', addr.address) as full_address,
        {# count(rntl.rental_id) as rentals #}
        sum(pymnt.total_amount) as total_payments
from rental rntl
inner join customer cstmr on cstmr.customer_id = rntl.customer_id
inner join address addr on cstmr.address_id = addr.address_id
inner join city on city.city_id = addr.city_id
inner join country cntry on cntry.country_id = city.country_id
group by loyal_customer
order by rentals desc)

select *
from final