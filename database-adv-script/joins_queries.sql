-- ==========================================
-- Complex Queries with Joins
-- File: joins_queries.sql
-- ==========================================

-- 1. 🧩 INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
SELECT b.booking_id, b.property_id, b.start_date, b.end_date, u.user_id, u.name
FROM bookings b
INNER JOIN users u
ON b.user_id = u.user_id
ORDER BY b.booking_id;


-- 2. 🧩 LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
SELECT p.property_id, p.property_name, r.review_id, r.comment, r.rating
FROM properties p
LEFT JOIN reviews r
ON p.property_id = r.property_id
ORDER BY p.property_id;


-- 3. 🧩 FULL OUTER JOIN
-- Retrieve all users and all bookings, even if:
--   - the user has no booking, OR
--   - a booking is not linked to a user
SELECT u.user_id, u.name, b.booking_id, b.start_date, b.end_date
FROM users u
FULL OUTER JOIN bookings b
ON u.user_id = b.user_id
ORDER BY u.user_id, b.booking_id;
