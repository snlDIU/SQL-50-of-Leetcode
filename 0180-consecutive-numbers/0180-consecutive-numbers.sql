With CTE as
(Select *, lead(num, 1)  over() as next1, lead(num, 2) over() as next2
from logs)

Select Distinct num as ConsecutiveNums
from cte
where
    num = next1 and num = next2