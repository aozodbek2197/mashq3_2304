WITH order_counts AS (
    SELECT 
        o.customer_id,
        COUNT(o.id) AS total_orders
    FROM orders o
    GROUP BY o.customer_id
),

ranked_customers AS (
    SELECT 
        oc.customer_id,
        oc.total_orders,
        RANK() OVER (
            ORDER BY oc.total_orders DESC
        ) AS order_rank
    FROM order_counts oc
),

top_customer AS (
    SELECT *
    FROM ranked_customers
    WHERE order_rank = 1
)

SELECT 
    c.id,
    c.name,
    tc.total_orders
FROM top_customer tc
JOIN customers c
    ON tc.customer_id = c.id;
