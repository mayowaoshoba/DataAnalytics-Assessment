-- 3. Account Inactivity Alert

use adashi_staging;

-- a cte table was created to optimise the script and get the last transaction carried out on the savings account by users
with last_savings_txn as (
    select
        id as plan_id,
        owner_id,
        'Savings' as type,
        max(transaction_date) as last_transaction_date
    from
        savings_savingsaccount
    where
        confirmed_amount > 0
    group by
        id, owner_id
),
-- a cte table was created to optimise the script and get the last transaction carried out on the investment account by users
last_investment_txn as (
    select
        id as plan_id,
        owner_id,
        'Investment' as type,
        max(start_date) as last_transaction_date
    from
        plans_plan
    where
        is_a_fund = 1 and amount > 0
    group by
        id, owner_id
),
-- the two results are then combined using union all
combined as (
    select * from last_savings_txn
    union all
    select * from last_investment_txn
)

-- from the combined table the inactive days is calculate as current_date(curdate()) - last_transaction_date in the last 365 days
select
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    datediff(curdate(), last_transaction_date) as inactivity_days
from
    combined
where
    datediff(curdate(), last_transaction_date) > 365;
