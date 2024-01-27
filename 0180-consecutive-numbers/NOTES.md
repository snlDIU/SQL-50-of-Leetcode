180. Consecutive Numbers

The SQL query retrieves distinct 'num' values from a 'logs' table using a Common Table Expression (CTE). It selects 'num' values where the current 'num' is equal to both the next 'num' and the 'num' two positions ahead in the table.

Logic breakdown:

1. CTE (Common Table Expression):
   - The CTE, named 'cte,' is created using the 'logs' table.
   - It includes additional columns 'next1' and 'next2' using the LEAD window function.
   - 'next1' represents the next 'num' value (1 position ahead), and 'next2' represents the 'num' value two positions ahead.

   How LEAD works:
   - The LEAD function retrieves the value of a specified expression for a given row, based on the specified offset.
   - In this case, 'LEAD(num, 1)' fetches the 'num' value of the next row (1 position ahead), and 'LEAD(num, 2)' fetches the 'num' value two positions ahead.

2. Main Query:
   - Selects distinct 'num' values from the CTE.
   - Applies a WHERE clause to filter rows where the 'num' is equal to both 'next1' and 'next2.'

Example:
  logs:
  | id | num |
  | -- | --- |
  | 1  | 1   |
  | 2  | 1   |
  | 3  | 1   |
  | 4  | 2   |
  | 5  | 1   |
  | 6  | 2   |

  CTE (cte):
  | id | num | next1 | next2 |
  | -- | --- | ----- | ----- |
  | 1  | 1   | 1     | 1     |
  | 2  | 1   | 1     | 2     |
  | 3  | 1   | 2     | 1     |
  | 4  | 2   | 1     | 2     |
  | 5  | 1   | 2     | null  |
  | 6  | 2   | null  | null  |

  Result:
  | ConsecutiveNums |
  | --------------- |
  | 1               |

Explanation:
- The LEAD function assists in creating the 'next1' and 'next2' columns, providing the 'num' values for positions ahead in the table.
- The main query then uses these columns to filter and select distinct 'num' values meeting the specified conditions.
- In the example, only the 'num' value 1 satisfies these conditions, resulting in the output.
​
