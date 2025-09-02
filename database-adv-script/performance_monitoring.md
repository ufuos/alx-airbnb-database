# Performance Monitoring and Schema Refinement in SQL

Efficient SQL queries aren’t just about syntax—they depend heavily on how your database schema is structured and how queries are executed internally. Monitoring performance and refining schema design are critical for scaling real-world applications.

This document demonstrates how to monitor, identify, and refine performance for the **Airbnb database**.

---

## 1. 🔍 Monitoring Query Performance

### 1.1 Using SHOW PROFILE (MySQL / MariaDB)

`SHOW PROFILE` provides detailed performance metrics of a query, such as CPU usage, I/O, and execution stages.

Steps:

```sql
-- Enable profiling
SET profiling = 1;

-- Run query
SELECT *
FROM bookings
WHERE booking_date BETWEEN '2023-01-01' AND '2023-12-31';

-- View profiles
SHOW PROFILES;

-- Get detailed breakdown
SHOW PROFILE FOR QUERY 1;
```

👉 This tells you which part of the query consumed the most time (e.g., sorting, sending data).

### 1.2 Using EXPLAIN ANALYZE (MySQL 8.0+ / PostgreSQL)

`EXPLAIN` shows the execution plan, while `ANALYZE` actually runs the query and returns performance stats.

Example:

```sql
EXPLAIN ANALYZE
SELECT b.id, u.name, p.title, pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
WHERE pay.status = 'Completed'
AND b.booking_date >= '2023-01-01';
```

📊 Output includes:

- Query cost estimates
- Join methods used (Nested Loop, Hash Join, Merge Join)
- Rows scanned vs returned
- Execution time

---

## 2. ⚡ Identifying Bottlenecks

From profiling tools, look for:

- **Full table scans** → happens when no index supports the `WHERE` clause.
- **High number of rows examined** → query is scanning too much data.
- **Slow joins** → caused by missing indexes on foreign keys.
- **Expensive sorting or grouping** → may require composite indexes.

**Example finding:**

If `EXPLAIN` shows:

```
Using where; Using filesort
```

👉 It means the query is sorting results without using an index → schema optimization needed.

---

## 3. 🛠️ Schema Refinement Techniques

### 3.1 Indexing

**Single-column index**:

```sql
CREATE INDEX idx_booking_date ON bookings (booking_date);
```

**Composite index**:

```sql
CREATE INDEX idx_payment_status_date
ON payments (status, created_at);
```

### 3.2 Normalization

Break large tables into smaller, related ones to reduce redundancy.

Example: Instead of storing `user_email` in `bookings`, store `user_id` only.

### 3.3 Partitioning

Useful for large time-based datasets (e.g., logs, bookings).

```sql
CREATE TABLE bookings_2023 PARTITION OF bookings
FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');
```

### 3.4 Materialized Views (PostgreSQL)

Precompute expensive joins/aggregations:

```sql
CREATE MATERIALIZED VIEW booking_summary AS
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;
```

---

## 4. 🧪 Practical Task Flow

1. **Run baseline queries**

   - Use `SHOW PROFILE` or `EXPLAIN ANALYZE` on a slow query.
   - Document execution time, rows examined, and plan.

2. **Identify bottlenecks**

   - Look for missing indexes, full table scans, or expensive joins.

3. **Propose schema refinements**

   - Suggest indexes, normalization, partitioning, or materialized views.

4. **Implement schema changes**

   - Apply one optimization at a time.
   - Example: Add an index on `booking_date`.

5. **Re-run performance tests**

   - Compare before/after execution time.

6. **Document improvements**

   - Record changes in query speed and resource usage.

---

## 5. 📑 Example Documentation Template

| Query Description      | Before Optimization        | After Optimization        | Schema Change Applied                     |
| ---------------------- | -------------------------- | ------------------------- | ----------------------------------------- |
| Booking search by date | 2.4 sec, 120k rows scanned | 0.05 sec, 1k rows scanned | Index on booking_date                     |
| Booking + payment join | 3.1 sec, full table scan   | 0.4 sec, using index join | Composite index on (status, booking_date) |

---

## ✅ Final Notes

- Use **SHOW PROFILE** (MySQL/MariaDB) or **EXPLAIN ANALYZE** (PostgreSQL/MySQL 8+) for real query analysis.
- Always **document before/after** results to measure improvement.
- Refine schema iteratively (indexes → normalization → partitioning → materialized views).

By following these steps, you ensure that your **Airbnb database** remains scalable and optimized for real-world workloads.
