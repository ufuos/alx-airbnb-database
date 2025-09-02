-- 1. Total number of bookings made by each user
-- Using Aggregation (COUNT + GROUP BY)

SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id
ORDER BY total_bookings DESC;


-- 2. Rank properties based on the total number of bookings
-- Using Aggregation + Window Functions

WITH property_counts AS (
    SELECT property_id, COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY property_id
)
SELECT property_id, total_bookings,
       RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
       ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM property_counts
ORDER BY total_bookings DESC;
