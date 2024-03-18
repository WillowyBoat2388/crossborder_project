with final as (
    select cntry.country, coalesce(sum(pymnt.amount), 0) as vol_sales, count(cstmr.customer_id) as customers
from country cntry
left join city on cntry.country_id = city.country_id
left join address addr on city.city_id = addr.city_id
left join customer cstmr on addr.address_id = cstmr.address_id
left join payment pymnt on cstmr.customer_id = pymnt.customer_id
group by cntry.country
order by vol_sales desc, customers desc
limit 5
)

select *
from final