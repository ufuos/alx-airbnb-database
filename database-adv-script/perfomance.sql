-- Initial Query: Retrieve all bookings with user, property, and payment details
-- (unoptimized version using SELECT * and multiple joins)

SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
WHERE pay.status = 'Completed'   -- Example filter: only completed payments
AND p.location = 'New York';     -- Example filter: only properties in New York


-- Refactored Query: Fetch only the required columns + better join usage

SELECT 
    b.id AS booking_id,
    b.check_in_date,
    b.check_out_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email,
    p.id AS property_id,
    p.title AS property_title,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
WHERE pay.status = 'Completed'   -- Filter condition
AND b.check_in_date >= '2025-01-01'  -- Example: future bookings
AND p.location = 'New York';     -- Filter for specific property location


-- Suggested Indexes to improve performance
-- (to be created if not already existing)

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_bookings_check_in_date ON bookings(check_in_date);


-- Query Execution Plan Analysis (with filters)

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.check_in_date,
    b.check_out_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email,
    p.id AS property_id,
    p.title AS property_title,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
WHERE pay.status = 'Completed'
AND b.check_in_date >= '2025-01-01'
AND p.location = 'New York';
