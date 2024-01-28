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