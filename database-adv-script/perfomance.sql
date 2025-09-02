-- Optimized Query: Retrieve bookings with user, property, and payment details
-- Only fetch required columns, avoid SELECT *

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
WHERE pay.status = 'Completed'        -- ✅ Filter: only completed payments
  AND b.check_in_date >= '2025-01-01' -- ✅ Filter: only future bookings
  AND p.location = 'New York';        -- ✅ Filter: only properties in New York


-- Suggested Indexes (create only if not already existing)

CREATE INDEX idx_bookings_user_id        ON bookings(user_id);
CREATE INDEX idx_bookings_property_id    ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id     ON bookings(payment_id);
CREATE INDEX idx_bookings_check_in_date  ON bookings(check_in_date);
CREATE INDEX idx_payments_status         ON payments(status);
CREATE INDEX idx_properties_location     ON properties(location);


-- Query Execution Plan Analysis

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
