-- 1. High-Value Customers with Multiple Products

use adashi_staging;

select
    a.id as owner_id,
    concat(a.first_name, ' ', a.last_name) as name, --to get full name, first_name and last_name was concatenated
    count(distinct b.id) as savings_count,
    count(distinct c.id) as investment_count,
    sum(b.confirmed_amount)/100 as total_deposits --converting from kobo to naira
from
    users_customuser a
join savings_savingsaccount b on b.owner_id = a.id and b.confirmed_amount > 0 
join plans_plan c on c.owner_id = a.id and c.is_a_fund = 1 and c.amount > 0
group by
    a.id, a.first_name, a.last_name
order by
    total_deposits desc;
