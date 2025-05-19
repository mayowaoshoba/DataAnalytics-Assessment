-- 4. Customer Lifetime Value (CLV) Estimation

use adashi_staging;

-- a cte table was created to optimise the script and get the total transaction of the customers and first transaction carried on the account
with transaction_tbl as (
    select
        owner_id as customer_id,
        count(*) as total_transactions,
        sum(confirmed_amount)/100 as total_value, -- converting from kobo to naira
        min(transaction_date) as first_transaction
    from
        savings_savingsaccount
    group by
        owner_id
),
-- from the above table the tenure months of the customer is calculated as well as profit made on the transaction and also the average pofit per transaction
tenure as (
    select
        t.customer_id,
        concat(u.first_name, ' ', u.last_name) as name,
        timestampdiff(month, u.date_joined, curdate()) as tenure_months,
        t.total_transactions,
        t.total_value,
        (0.001 * t.total_value) as total_profit,
        (0.001 * t.total_value) / nullif(t.total_transactions, 0) as avg_profit_per_txn
    from
        transaction_tbl t
    join users_customuser u on u.id = t.customer_id
),
clv as (
    select
        customer_id,
        name,
        tenure_months,
        total_transactions,
        round((total_transactions / nullif(tenure_months, 0)) * 12 * avg_profit_per_txn, 2) as estimated_clv
    from
        tenure
)
select *
from clv
order by estimated_clv desc;
