-- INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT u.user_id, u.name, b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
INNER JOIN Bookings b ON u.user_id = b.user_id;


-- LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT p.property_id, p.name AS property_name, r.review_id, r.rating, r.comment
FROM Properties p
LEFT JOIN Reviews r ON p.property_id = r.property_id;


-- FULL OUTER JOIN: Retrieve all users and all bookings,
-- even if the user has no booking or a booking is not linked to a user
-- (PostgreSQL / SQL Server syntax)
SELECT u.user_id, u.name, b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
FULL OUTER JOIN Bookings b ON u.user_id = b.user_id;

-- MySQL does not support FULL OUTER JOIN directly.
-- In MySQL, we emulate it using UNION of LEFT JOIN and RIGHT JOIN:
SELECT u.user_id, u.name, b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
UNION
SELECT u.user_id, u.name, b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
RIGHT JOIN Bookings b ON u.user_id = b.user_id;
