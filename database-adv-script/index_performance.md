# Indexing and Query Performance Optimization

## 1. Objective

The goal is to improve query performance in the **User**, **Booking**, and **Property** tables by identifying high-usage columns and creating appropriate indexes. This reduces query execution time and improves efficiency in the `alx-airbnb-database`.

---

## 2. Indexing

### 2.1 Identifying High-Usage Columns

Based on common queries in an Airbnb-style app:

- **User table**
  - `email` → used in authentication (`WHERE email = ?`)
  - `id` → used as a foreign key in `Booking`
- **Booking table**
  - `user_id` → used in joins with `User`
  - `property_id` → used in joins with `Property`
  - `created_at` → often used for sorting (`ORDER BY created_at DESC`)
- **Property table**
  - `location` → used in searches (`WHERE location = ?`)
  - `price` → often filtered (`WHERE price < ? ORDER BY price`)
  - `id` → used as foreign key in `Booking`

---

### 2.2 SQL Index Commands

Below are the indexes created in **database_index.sql**:

```sql
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
```
