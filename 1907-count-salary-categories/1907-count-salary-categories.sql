# Write your MySQL query statement below

select "Low Salary" AS category,
    sum(income<20000) as accounts_count

from accounts 

union

select "Average Salary" AS category,
    sum(income BETWEEN 20000 AND 50000) as accounts_count

from accounts 

union 

select "High Salary" AS category,
    sum(income > 50000) as accounts_count
from accounts 