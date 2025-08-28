# Database Seeding Script

## 📌 Overview

This directory contains the `seed.sql` script used to populate the **AirBnB Database** with sample data.  
The data reflects real-world usage with multiple users, properties, bookings, payments, reviews, and messages.

## 📂 Files

- **seed.sql** → Inserts sample records into all tables.
- **schema.sql** → Must be executed first (from previous step).

## 🚀 How to Run

1. Ensure PostgreSQL is running and the database has been created.
2. Run the schema first:
   ```bash
   psql -U <username> -d <database> -f ../database-script-0x01/schema.sql
   ```
