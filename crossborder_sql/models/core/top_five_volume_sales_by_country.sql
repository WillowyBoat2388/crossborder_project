with final as (
    select cntry.country, sum(pymnt.amount) as vol_sales, count(cstmr.customer_id) as customers
from country cntry
inner join city on cntry.country_id = city.country_id
inner join address addr on city.city_id = addr.city_id
inner join customer cstmr on addr.address_id = cstmr.address_id
inner join payment pymnt on cstmr.customer_id = pymnt.customer_id
group by cntry.country
order by vol_sales desc, customers desc
limit 5
)

select *
from final