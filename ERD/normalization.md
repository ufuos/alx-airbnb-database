# Database Normalization: AirBnB Schema

**Repo**: `alx-airbnb-database`  
**File**: `ERD/normalization.md`

---

## Objective

Apply database normalization principles to the AirBnB schema design to ensure it is in **Third Normal Form (3NF)**.

---

## Step 1 — First Normal Form (1NF)

**Rule:** Eliminate repeating groups; ensure atomic values.

- All attributes contain **atomic values** (no multi-valued attributes).
  - Example: `User.email` is a single value, not a list of emails.
- Each table has a **primary key** (`user_id`, `property_id`, `booking_id`, etc.).
- No repeating groups in any table.

✅ The schema satisfies **1NF**.

---

## Step 2 — Second Normal Form (2NF)

**Rule:** Eliminate partial dependency (no non-key attribute depends only on part of a composite key).

- All primary keys are **single-column surrogate keys** (UUIDs).
  - Example: `booking_id` uniquely identifies a booking, no composite keys required.
- All non-key attributes depend **entirely** on their primary key.
  - Example: In `Booking`, `start_date`, `end_date`, and `total_price` all depend only on `booking_id`.

✅ The schema satisfies **2NF**.

---

## Step 3 — Third Normal Form (3NF)

**Rule:** Eliminate transitive dependencies (non-key attributes should not depend on other non-key attributes).

- `User`

  - Attributes (`first_name`, `last_name`, `email`, `password_hash`, etc.) depend directly on `user_id`.
  - No transitive dependencies.

- `Property`

  - Attributes (`name`, `description`, `location`, `pricepernight`) depend on `property_id`.
  - `host_id` is a foreign key referencing `User`, not a derived value.
  - ✅ No transitive dependency.

- `Booking`

  - Attributes depend on `booking_id`.
  - `total_price` is stored for audit purposes (calculated from `pricepernight * nights` at booking time). This is **denormalization by design**, but it avoids recalculation after property price changes.
  - Justification: acceptable controlled denormalization.

- `Payment`

  - All attributes (`amount`, `payment_date`, `payment_method`) depend on `payment_id`.
  - ✅ No transitive dependency.

- `Review`

  - Attributes (`rating`, `comment`, `created_at`) depend on `review_id`.
  - ✅ No transitive dependency.

- `Message`
  - Attributes (`message_body`, `sent_at`) depend only on `message_id`.
  - ✅ No transitive dependency.

✅ The schema satisfies **3NF**.

---

## Final Notes

- The database schema is in **Third Normal Form (3NF)**.
- The only **intentional denormalization** is `Booking.total_price`, which preserves historical accuracy even if the property price changes.
- Additional constraints that could be applied:
  - `Review`: `(property_id, user_id)` could be made unique to prevent multiple reviews by the same user for the same property.
  - `Message`: Ensure `sender_id != recipient_id` for integrity.

---

## Conclusion

The AirBnB-style schema is normalized to **3NF**.  
No redundant data exists, dependencies are properly defined, and controlled denormalization (for `Booking.total_price`) is justified.
