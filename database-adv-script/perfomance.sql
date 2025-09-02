-- Initial Query: Retrieve all bookings with user, property, and payment details
-- (unoptimized version using SELECT * and multiple joins)

SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id;


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
JOIN payments pay ON b.payment_id = pay.id;


-- Suggested Indexes to improve performance
-- (to be created if not already existing)

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);
CREATE INDEX idx_payments_status ON payments(status);
