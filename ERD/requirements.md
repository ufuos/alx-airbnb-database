# AirBnB Database ERD Requirements

**Repo**: `alx-airbnb-database`  
**Directory**: `ERD/`  
**File**: `requirements.md`

## Objective

Define entities, attributes, relationships, and constraints for the AirBnB-style platform and provide an ER diagram.

## Entities & Attributes

### User

- `user_id` **PK**, UUID, indexed
- `first_name` VARCHAR NOT NULL
- `last_name` VARCHAR NOT NULL
- `email` VARCHAR UNIQUE NOT NULL
- `password_hash` VARCHAR NOT NULL
- `phone_number` VARCHAR NULL
- `role` ENUM(`guest`, `host`, `admin`) NOT NULL
- `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP

**Indexes**

- `email` (unique)

---

### Property

- `property_id` **PK**, UUID, indexed
- `host_id` **FK** → `User(user_id)`
- `name` VARCHAR NOT NULL
- `description` TEXT NOT NULL
- `location` VARCHAR NOT NULL
- `pricepernight` DECIMAL NOT NULL
- `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

**Constraints**

- `host_id` references `User(user_id)`

**Indexes**

- `property_id`

---

### Booking

- `booking_id` **PK**, UUID, indexed
- `property_id` **FK** → `Property(property_id)`
- `user_id` **FK** → `User(user_id)`
- `start_date` DATE NOT NULL
- `end_date` DATE NOT NULL
- `total_price` DECIMAL NOT NULL
- `status` ENUM(`pending`, `confirmed`, `canceled`) NOT NULL
- `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP

**Constraints**

- `status` limited to enum values
- `property_id`, `user_id` valid FKs

**Indexes**

- `booking_id`, `property_id`

---

### Payment

- `payment_id` **PK**, UUID, indexed
- `booking_id` **FK** → `Booking(booking_id)`
- `amount` DECIMAL NOT NULL
- `payment_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- `payment_method` ENUM(`credit_card`, `paypal`, `stripe`) NOT NULL

**Constraints**

- `booking_id` valid FK
- A booking can have one or more payments (supports partial payments/refunds)

**Indexes**

- `booking_id`

---

### Review

- `review_id` **PK**, UUID, indexed
- `property_id` **FK** → `Property(property_id)`
- `user_id` **FK** → `User(user_id)`
- `rating` INTEGER CHECK 1–5 NOT NULL
- `comment` TEXT NOT NULL
- `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP

**Constraints**

- `rating` must be between 1 and 5 inclusive
- FKs on `property_id`, `user_id`

---

### Message

- `message_id` **PK**, UUID, indexed
- `sender_id` **FK** → `User(user_id)`
- `recipient_id` **FK** → `User(user_id)`
- `message_body` TEXT NOT NULL
- `sent_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP

**Constraints**

- FKs on `sender_id`, `recipient_id`

---

## Relationships & Cardinalities

- **User (host)** 1 — 0..\* **Property** (via `Property.host_id`)
- **User (guest)** 1 — 0..\* **Booking** (via `Booking.user_id`)
- **Property** 1 — 0..\* **Booking** (via `Booking.property_id`)
- **Booking** 1 — 0..\* **Payment** (via `Payment.booking_id`)
- **User** 1 — 0..\* **Review** (via `Review.user_id`)
- **Property** 1 — 0..\* **Review** (via `Review.property_id`)
- **User ↔ User** via **Message**: a user can send 0..\* messages to other users; each message has exactly one sender and one recipient.

## Assumptions

- Payments allow multiple rows per booking (to support partial payments, retries, or refunds).
- Reviews are not restricted to one per booking in this spec (can be added with a unique constraint on `(property_id, user_id)` or `(booking_id)` if desired).
- `pricepernight` is stored on `Property`; `total_price` is captured on `Booking` for immutability/audit.

## ER Diagram (Mermaid for documentation)

```mermaid
erDiagram
  User ||--o{ Property : hosts
  User ||--o{ Booking : makes
  Property ||--o{ Booking : receives
  Booking ||--o{ Payment : has
  User ||--o{ Review : writes
  Property ||--o{ Review : gets
  User ||--o{ Message : sends
  Message }o--|| User : to

  User {
    UUID user_id PK
    VARCHAR first_name
    VARCHAR last_name
    VARCHAR email UNIQUE
    VARCHAR password_hash
    VARCHAR phone_number
    ENUM role
    TIMESTAMP created_at
  }
  Property {
    UUID property_id PK
    UUID host_id FK
    VARCHAR name
    TEXT description
    VARCHAR location
    DECIMAL pricepernight
    TIMESTAMP created_at
    TIMESTAMP updated_at
  }
  Booking {
    UUID booking_id PK
    UUID property_id FK
    UUID user_id FK
    DATE start_date
    DATE end_date
    DECIMAL total_price
    ENUM status
    TIMESTAMP created_at
  }
  Payment {
    UUID payment_id PK
    UUID booking_id FK
    DECIMAL amount
    TIMESTAMP payment_date
    ENUM payment_method
  }
  Review {
    UUID review_id PK
    UUID property_id FK
    UUID user_id FK
    INTEGER rating
    TEXT comment
    TIMESTAMP created_at
  }
  Message {
    UUID message_id PK
    UUID sender_id FK
    UUID recipient_id FK
    TEXT message_body
    TIMESTAMP sent_at
  }
```

## Files Provided

- `airbnb_erd.drawio` — Draw.io diagram file (import directly at https://app.diagrams.net/)
- This `requirements.md` document (place in `ERD/`).
