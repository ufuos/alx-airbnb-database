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

# SQL Subqueries

This directory contains examples of **correlated** and **non-correlated** subqueries using an Airbnb-like database schema.

---

## 📘 What Are Subqueries?

A **subquery** is a query nested inside another SQL query.  
They can be used in `SELECT`, `FROM`, `WHERE`, or `HAVING` clauses to provide intermediate results.

- **Non-Correlated Subquery**: Runs once, independent of the outer query.
- **Correlated Subquery**: Runs once per row, referencing columns from the outer query.

---

## 🏡 Queries

### 1. Non-Correlated Subquery

**Find all properties where the average rating is greater than 4.0:**

```sql
SELECT p.property_id, p.name, p.location
FROM properties p
WHERE (
    SELECT AVG(r.rating)
    FROM reviews r
    WHERE r.property_id = p.property_id
) > 4.0;

```

# Mastering Aggregations and Window Functions in SQL

Databases store vast amounts of raw data, but simply retrieving data is often not enough. We need ways to summarize, analyze, and compare values across datasets. This is where **Aggregations** and **Window Functions** shine. They transform raw records into meaningful insights.

---

## 📊 Aggregations in SQL

### What Are Aggregations?

Aggregation functions perform calculations on multiple rows and return a single summarized value. They are especially useful when combined with the `GROUP BY` clause.

### Example in Our Airbnb Database

**Task: Find the total number of bookings made by each user.**

```sql
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id
ORDER BY total_bookings DESC;

```
