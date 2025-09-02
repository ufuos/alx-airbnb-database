-- ======================================================
-- Partitioning the Bookings Table by start_date (YEAR)
-- ======================================================

-- 1. Drop old partitioned table if exists (safety step)
DROP TABLE IF EXISTS bookings_partitioned CASCADE;

-- 2. Create a partitioned table
CREATE TABLE bookings_partitioned (
    booking_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20),
    amount DECIMAL(10,2),
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (EXTRACT(YEAR FROM start_date));

-- 3. Create partitions by year

-- Partition for 2021
CREATE TABLE bookings_2021 PARTITION OF bookings_partitioned
    FOR VALUES FROM (2021) TO (2022);

-- Partition for 2022
CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM (2022) TO (2023);

-- Partition for 2023
CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM (2023) TO (2024);

-- Partition for future years (2024 and beyond)
CREATE TABLE bookings_future PARTITION OF bookings_partitioned
    FOR VALUES FROM (2024) TO (MAXVALUE);

-- 4. (Optional) Add indexes to each partition for faster lookups
CREATE INDEX idx_bookings_2021_user ON bookings_2021 (user_id);
CREATE INDEX idx_bookings_2022_user ON bookings_2022 (user_id);
CREATE INDEX idx_bookings_2023_user ON bookings_2023 (user_id);
CREATE INDEX idx_bookings_future_user ON bookings_future (user_id);

-- 5. Example query to test performance
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
