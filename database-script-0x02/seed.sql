-- ============================================================
-- AirBnB Database Seed Data
-- File: seed.sql
-- Repo: alx-airbnb-database
-- ============================================================

-- ====================
-- USERS
-- ====================
INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Alice', 'Johnson', 'alice@example.com', 'hashedpassword1', '+1234567890', 'guest'),
('Bob', 'Smith', 'bob@example.com', 'hashedpassword2', '+1987654321', 'host'),
('Charlie', 'Brown', 'charlie@example.com', 'hashedpassword3', '+1122334455', 'host'),
('Diana', 'Prince', 'diana@example.com', 'hashedpassword4', '+1098765432', 'guest'),
('Admin', 'User', 'admin@example.com', 'hashedpassword5', '+1010101010', 'admin');

-- ====================
-- PROPERTIES
-- ====================
INSERT INTO properties (host_id, name, description, location, pricepernight)
VALUES
((SELECT user_id FROM users WHERE email = 'bob@example.com'), 
 'Cozy Apartment', 'A small cozy apartment near downtown.', 'New York, USA', 120.00),
((SELECT user_id FROM users WHERE email = 'charlie@example.com'), 
 'Beach House', 'Beautiful beach house with ocean views.', 'Miami, USA', 250.00),
((SELECT user_id FROM users WHERE email = 'charlie@example.com'), 
 'Mountain Cabin', 'Secluded cabin in the mountains.', 'Denver, USA', 180.00);

-- ====================
-- BOOKINGS
-- ====================
INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM properties WHERE name = 'Cozy Apartment'),
 (SELECT user_id FROM users WHERE email = 'alice@example.com'),
 '2025-09-01', '2025-09-05', 480.00, 'confirmed'),
((SELECT property_id FROM properties WHERE name = 'Beach House'),
 (SELECT user_id FROM users WHERE email = 'diana@example.com'),
 '2025-09-10', '2025-09-15', 1250.00, 'pending'),
((SELECT property_id FROM properties WHERE name = 'Mountain Cabin'),
 (SELECT user_id FROM users WHERE email = 'alice@example.com'),
 '2025-09-20', '2025-09-22', 360.00, 'canceled');

-- ====================
-- PAYMENTS
-- ====================
INSERT INTO payments (booking_id, amount, payment_method)
VALUES
((SELECT booking_id FROM bookings WHERE total_price = 480.00), 480.00, 'credit_card'),
((SELECT booking_id FROM bookings WHERE total_price = 1250.00), 1250.00, 'paypal');

-- ====================
-- REVIEWS
-- ====================
INSERT INTO reviews (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM properties WHERE name = 'Cozy Apartment'),
 (SELECT user_id FROM users WHERE email = 'alice@example.com'),
 5, 'Amazing stay, very comfortable and clean!'),
((SELECT property_id FROM properties WHERE name = 'Beach House'),
 (SELECT user_id FROM users WHERE email = 'diana@example.com'),
 4, 'Great location and view, but a bit pricey.');

-- ====================
-- MESSAGES
-- ====================
INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES
((SELECT user_id FROM users WHERE email = 'alice@example.com'),
 (SELECT user_id FROM users WHERE email = 'bob@example.com'),
 'Hi Bob, is your apartment available for early check-in?'),
((SELECT user_id FROM users WHERE email = 'bob@example.com'),
 (SELECT user_id FROM users WHERE email = 'alice@example.com'),
 'Hi Alice, yes early check-in is possible, no problem.'),
((SELECT user_id FROM users WHERE email = 'diana@example.com'),
 (SELECT user_id FROM users WHERE email = 'charlie@example.com'),
 'Hello Charlie, can you confirm the amenities of the beach house?');
