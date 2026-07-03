-- Query to check current stock levels for all products
SELECT
    product,
    MAX(date_of_check) as last_checked_date,
    LAST_VALUE(IGNORE NULLS(stock_amount)) OVER (PARTITION BY product ORDER BY date_of_check
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as current_stock
FROM testing_data
QUALIFY ROW_NUMBER() OVER (PARTITION BY product ORDER BY date_of_check DESC) = 1
ORDER BY product;