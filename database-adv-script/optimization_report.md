# Query Optimization Report

## Objective

Refactor complex queries in the **alx-airbnb-database** project to improve performance by:

- Reducing unnecessary joins,
- Selecting only needed columns,
- Using indexing to improve query execution time.

---

## 1. Initial Query

The original query fetched **all columns** from multiple tables:

```sql
SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id;
```
