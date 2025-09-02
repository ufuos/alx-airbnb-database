# Advanced SQL Joins Queries

This directory contains advanced SQL queries demonstrating the use of INNER JOIN, LEFT JOIN, and FULL OUTER JOIN in the context of the **alx-airbnb-database**.

---

## Queries

### 1. INNER JOIN: Users with their Bookings

```sql
SELECT u.user_id, u.name, b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
INNER JOIN Bookings b ON u.user_id = b.user_id;
```
