-- ========================================
-- Complex Queries with Joins for Airbnb DB
-- ========================================

-- 1️⃣ INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM Users u
INNER JOIN Bookings b 
    ON u.user_id = b.user_id;


-- 2️⃣ LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.property_id,
    p.title AS property_title,
    r.review_id,
    r.rating,
    r.comment
FROM Properties p
LEFT JOIN Reviews r 
    ON p.property_id = r.property_id;


-- 3️⃣ FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking 
-- or a booking is not linked to a user.
-- ⚠️ Note: MySQL doesn’t support FULL OUTER JOIN directly.
-- Workaround: UNION of LEFT JOIN + RIGHT JOIN

SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM Users u
LEFT JOIN Bookings b 
    ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM Users u
RIGHT JOIN Bookings b 
    ON u.user_id = b.user_id;
