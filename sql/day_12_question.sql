-- Hard SQL: transactions table with user_id, amount, transaction_date. Single query to find users who 
-- ① spent more in month 2 than month 1 
-- ② had 3+ consecutive days with a transaction 
-- ③ whose average transaction is in top 10% of all users. No temp tables.

WITH monthly_spend AS (
    SELECT
        user_id,
        SUM(CASE
                WHEN EXTRACT(MONTH FROM transaction_date) = 1
                THEN amount
                ELSE 0
            END) AS month1_spend,
        SUM(CASE
                WHEN EXTRACT(MONTH FROM transaction_date) = 2
                THEN amount
                ELSE 0
            END) AS month2_spend
    FROM transactions
    GROUP BY user_id
),

consecutive_users AS (
    SELECT user_id
    FROM (
        SELECT
            user_id,
            grp,
            COUNT(*) AS consecutive_days
        FROM (
            SELECT
                user_id,
                txn_date,
                txn_date - ROW_NUMBER() OVER (
                    PARTITION BY user_id
                    ORDER BY txn_date
                )::INT AS grp
            FROM (
                SELECT DISTINCT
                    user_id,
                    transaction_date::DATE AS txn_date
                FROM transactions
            ) d
        ) x
        GROUP BY user_id, grp
    ) y
    WHERE consecutive_days >= 3
),

user_avg AS (
    SELECT
        user_id,
        AVG(amount) AS avg_txn
    FROM transactions
    GROUP BY user_id
),

top_10_percent AS (
    SELECT user_id
    FROM (
        SELECT
            user_id,
            avg_txn,
            NTILE(10) OVER (ORDER BY avg_txn DESC) AS bucket
        FROM user_avg
    ) t
    WHERE bucket = 1
)

SELECT m.user_id
FROM monthly_spend m
JOIN consecutive_users c
    ON m.user_id = c.user_id
JOIN top_10_percent t
    ON m.user_id = t.user_id
WHERE m.month2_spend > m.month1_spend;
