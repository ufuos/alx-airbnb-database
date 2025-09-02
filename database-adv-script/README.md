# Airbnb Database – Advanced SQL Joins

This project demonstrates **complex queries with different types of joins** in SQL, applied to the `alx-airbnb-database` project.

## ✅ Task Objectives

- Write a query using an **INNER JOIN** to retrieve all bookings and the respective users who made those bookings.
- Write a query using a **LEFT JOIN** to retrieve all properties and their reviews, including properties that have no reviews.
- Write a query using a **FULL OUTER JOIN** to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

---

## 🔗 Queries Overview

### 1. INNER JOIN – Users & Bookings

```sql
SELECT u.user_id, u.name, b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
INNER JOIN Bookings b ON u.user_id = b.user_id;
```
