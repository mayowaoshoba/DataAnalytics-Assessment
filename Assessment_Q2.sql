-- 2. Transaction Frequency Analysis

use adashi_staging;

--a cte table was created to optimise the script and get the months active of users
with transaction_count as (
    select
        owner_id,
        count(*) as total_transactions,
        timestampdiff(month, min(transaction_date), max(transaction_date)) + 1 as months_active
    from
        savings_savingsaccount
    group by
        owner_id
),
--from the cte created above the average transaction per month was calculated then categorized below
 monthly_avg as ( 
    select
        owner_id,
        total_transactions,
        months_active,
        total_transactions / nullif(months_active, 0) as avg_per_month
    from
        transaction_count
),
 categorized as (
    select
        case
            when avg_per_month >= 10 then 'High Frequency'
            when avg_per_month between 3 and 9 then 'Medium Frequency'
            else 'Low Frequency'
        end as frequency_category,
        avg_per_month
    from
        monthly_avg
)
select
    frequency_category,
    count(*) as customer_count,
    round(avg(avg_per_month), 1) as avg_transactions_per_month
from
    categorized
group by
    frequency_category;
