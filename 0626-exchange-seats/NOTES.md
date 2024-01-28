```sql
-- Write your MySQL query statement below
WITH cet AS (
    SELECT
        id,
        student,
        LAG(student) OVER (ORDER BY id) AS lag_stud,
        LEAD(student) OVER (ORDER BY id) AS lead_stud
    FROM seat
)

SELECT
    id,
    IFNULL(
        (CASE WHEN MOD(id, 2) = 0 THEN lag_stud ELSE lead_stud END),
        student
    ) AS student
FROM cet;
```

## CET Table

| id | student | lag_stud | lead_stud |
| -- | ------- | -------- | --------- |
| 1  | Abbot   | null     | Doris     |
| 2  | Doris   | Abbot    | Emerson   |
| 3  | Emerson | Doris    | Green     |
| 4  | Green   | Emerson  | Jeames    |
| 5  | Jeames  | Green    | null      |


## Final table
| id | student |
| -- | ------- |
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
