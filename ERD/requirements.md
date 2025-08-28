from graphviz import Digraph

# Create a directed graph for ERD

erd = Digraph("AirbnbERD", format="png")
erd.attr(rankdir="LR", size="8")

# Entities as boxes

entities = {
"User": ["user_id (PK)", "first_name", "last_name", "email (UNIQUE)", "password_hash",
"phone_number", "role", "created_at"],
"Property": ["property_id (PK)", "host_id (FK)", "name", "description", "location",
"pricepernight", "created_at", "updated_at"],
"Booking": ["booking_id (PK)", "property_id (FK)", "user_id (FK)", "start_date",
"end_date", "total_price", "status", "created_at"],
"Payment": ["payment_id (PK)", "booking_id (FK)", "amount", "payment_date", "payment_method"],
"Review": ["review_id (PK)", "property_id (FK)", "user_id (FK)", "rating", "comment", "created_at"],
"Message": ["message_id (PK)", "sender_id (FK)", "recipient_id (FK)", "message_body", "sent_at"]
}

# Add entity nodes with attributes

for entity, attrs in entities.items():
label = f"<<b>{entity}</b><br/>" + "<br/>".join(attrs) + ">"
erd.node(entity, label=label, shape="record")

# Relationships

erd.edge("User", "Property", label="1 — N (host_id)")
erd.edge("User", "Booking", label="1 — N (user_id)")
erd.edge("Property", "Booking", label="1 — N (property_id)")
erd.edge("Booking", "Payment", label="1 — N (booking_id)")
erd.edge("User", "Review", label="1 — N (user_id)")
erd.edge("Property", "Review", label="1 — N (property_id)")
erd.edge("User", "Message", label="1 — N (sender_id)")
erd.edge("User", "Message", label="1 — N (recipient_id)")

# Render ER diagram

output_path = "/mnt/data/airbnb_erd"
erd.render(output_path)

output_path + ".png"
