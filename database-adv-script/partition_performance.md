# Partitioning Performance Report

## Objective

Optimize queries on the large `Booking` table by applying **table partitioning** on the `start_date` column.

## Implementation

- Created a new partitioned table: `bookings_partitioned`.
- Applied **RANGE partitioning** by `YEAR(start_date)`.
- Defined partitions for:
  - 2021
  - 2022
  - 2023
  - Future (2024+)
- Added indexes on `user_id` per partition for query optimization.

## Test Query

```sql
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
```
