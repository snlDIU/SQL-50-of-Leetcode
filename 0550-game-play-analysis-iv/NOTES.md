
```sql
-- Common Table Expression 1 (cte)
WITH cte AS (
    SELECT 
        DISTINCT player_id, 
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),

-- Common Table Expression 2 (cte2)
cte2 AS (
    SELECT 
        *, 
        DATE_ADD(first_login, INTERVAL 1 DAY) AS next_day 
    FROM cte
)

-- Main Query
SELECT 
    ROUND(
        (
            SELECT COUNT(DISTINCT player_id)
            FROM Activity
            WHERE (player_id, event_date) IN (
                SELECT player_id, next_day
                FROM cte2
            )
        ) / (
            SELECT COUNT(DISTINCT player_id)
            FROM Activity
        ), 
        2
    ) AS fraction;
```

**Explanation:**

1. **cte (Common Table Expression 1):**
   - Selects distinct `player_id` and their corresponding earliest `event_date` as `first_login`.
   - Example cte table:

     ```plaintext
     | player_id | first_login |
     |-----------|-------------|
     | 1         | 2016-03-01  |
     | 2         | 2017-06-25  |
     | 3         | 2016-03-02  |
     ```

2. **cte2 (Common Table Expression 2):**
   - Extends `cte` by adding a new column `next_day` using `DATE_ADD` to represent the day after `first_login`.
   - Example cte2 table:

     ```plaintext
     | player_id | first_login | next_day   |
     |-----------|-------------|------------|
     | 1         | 2016-03-01  | 2016-03-02 |
     | 2         | 2017-06-25  | 2017-06-26 |
     | 3         | 2016-03-02  | 2016-03-03 |
     ```

3. **Main Query:**
   - Calculates the fraction of distinct players who logged in on the day after their first login.
   - Example final table (after executing the whole query):

     ```plaintext
     | fraction |
     |----------|
     | 0.33     |
     ```

   The fraction represents the ratio of players who logged in on the day after their first login to the total number of distinct players in the Activity table. In this example, it is calculated as 1/3 (0.33).
