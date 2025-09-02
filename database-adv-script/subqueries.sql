-- 🏡 Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0
SELECT p.property_id, p.name, p.location
FROM properties p
WHERE (
    SELECT AVG(r.rating)
    FROM reviews r
    WHERE r.property_id = p.property_id
) > 4.0;


-- 👤 Correlated Subquery
-- Find users who have made more than 3 bookings
SELECT u.user_id, u.name, u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
