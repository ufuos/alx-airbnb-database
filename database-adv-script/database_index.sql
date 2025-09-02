-- ==============================================
-- DATABASE INDEXING & PERFORMANCE OPTIMIZATION
-- File: database_index.sql
-- ==============================================

-- ==============================================
-- 1. BEFORE INDEXING: Run queries with EXPLAIN
-- ==============================================
-- These queries simulate common usage patterns in the Airbnb app.

-- Check query plan for authentication
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- Check query plan for joining bookings with users
EXPLAIN SELECT b.* 
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE u.email = 'test@example.com';

-- Check query plan for property search by location
EXPLAIN SELECT * FROM properties WHERE location = 'New York';

-- Check query plan for filtering properties by price
EXPLAIN SELECT * FROM properties WHERE price < 200 ORDER BY price;

-- Check query plan for recent bookings
EXPLAIN SELECT * FROM bookings ORDER BY created_at DESC LIMIT 10;


-- ==============================================
-- 2. CREATE INDEXES
-- ==============================================

-- User table indexes
CREATE UNIQUE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_id ON users(id);

-- Booking table indexes
CREATE INDEX idx_booking_user_id ON bookings(user_id);
CREATE INDEX idx_booking_property_id ON bookings(property_id);
CREATE INDEX idx_booking_created_at ON bookings(created_at);

-- Property table indexes
CREATE INDEX idx_property_location ON properties(location);
CREATE INDEX idx_property_price ON properties(price);
CREATE INDEX idx_property_id ON properties(id);


-- ==============================================
-- 3. AFTER INDEXING: Run queries with EXPLAIN
-- ==============================================
-- Re-run the same queries and compare the execution plan.

EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

EXPLAIN SELECT b.* 
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE u.email = 'test@example.com';

EXPLAIN SELECT * FROM properties WHERE location = 'New York';

EXPLAIN SELECT * FROM properties WHERE price < 200 ORDER BY price;

EXPLAIN SELECT * FROM bookings ORDER BY created_at DESC LIMIT 10;

-- ==============================================
-- NOTES:
-- - In PostgreSQL, replace EXPLAIN with EXPLAIN ANALYZE
--   to see actual execution time.
-- - In MySQL, EXPLAIN shows which indexes are used.
-- ==============================================
