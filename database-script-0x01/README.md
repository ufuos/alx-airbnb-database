# AirBnB Database Schema (DDL)

## Overview

This directory contains the SQL schema for the **AirBnB-style platform** defined in the ERD and normalization documents.

- File: `schema.sql`
- Database: PostgreSQL
- Normalization: 3NF (with controlled denormalization of `Booking.total_price` for audit purposes)

## Entities

- **Users**: Guest, Host, or Admin accounts.
- **Properties**: Listings created by hosts.
- **Bookings**: Reservations made by guests for properties.
- **Payments**: Transactions linked to bookings (supports multiple partial/refund payments).
- **Reviews**: User reviews on properties.
- **Messages**: Messaging between users (guest ↔ host, etc.).

## Features

- UUIDs as primary keys.
- Foreign key constraints with `ON DELETE CASCADE`.
- ENUM-like constraints implemented via `CHECK`.
- Indexes on frequently queried columns (`email`, `host_id`, `property_id`, `booking_id`, etc.).
- Data integrity enforced via `CHECK` constraints (`rating`, `role`, `status`, `payment_method`).

## How to Use

1. Create a PostgreSQL database:
   ```bash
   createdb airbnb_db
   ```
