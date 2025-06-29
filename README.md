# alx-airbnb-database

Database Schema: AirBnB Clone
This document outlines the database schema for the AirBnB clone application. The schema is designed to handle users, properties, bookings, payments, reviews, and messaging functionalities. Below is a detailed breakdown of each table and its relationships.

Entity Relationship Diagram (ERD)
The ERD illustrates the structure of the database, including all tables, their columns, and the relationships between them.

Entities (Tables)
1. USER
Stores information about all users of the application, including guests, hosts, and administrators.

user_id: A unique UUID for each user (Primary Key).

email: The user's email address, which must be unique.

role: Defines the user's permissions (e.g., guest, host, admin).

2. PROPERTY
Contains details about the properties listed for rent.

property_id: A unique UUID for each property (Primary Key).

host_id: A foreign key that links to the user_id of the user who owns the property.

3. BOOKING
Manages booking requests made by users for properties. This table acts as a link between users and properties.

booking_id: A unique UUID for each booking (Primary Key).

user_id: A foreign key linking to the user who made the booking.

property_id: A foreign key linking to the property that was booked.

status: The current state of the booking (e.g., pending, confirmed, canceled).

4. PAYMENT
Stores records of all financial transactions related to bookings.

payment_id: A unique UUID for each payment (Primary Key).

booking_id: A foreign key that links to the booking for which the payment was made.

5. REVIEW
Contains user-submitted reviews and ratings for properties.

review_id: A unique UUID for each review (Primary Key).

user_id: A foreign key linking to the user who wrote the review.

property_id: A foreign key linking to the property being reviewed.

rating: A numerical score from 1 to 5.

6. MESSAGE
Handles the direct messaging system between users.

message_id: A unique UUID for each message (Primary Key).

sender_id: A foreign key linking to the user who sent the message.

recipient_id: A foreign key linking to the user who received the message.

Relationships
USER and PROPERTY: A one-to-many relationship. One user can host multiple properties, but each property has only one host.

USER and BOOKING: A one-to-many relationship. One user can make multiple bookings.

PROPERTY and BOOKING: A one-to-many relationship. One property can be part of multiple bookings.

BOOKING and PAYMENT: A one-to-one relationship. Each booking has exactly one associated payment.

USER and REVIEW: A one-to-many relationship. One user can write multiple reviews.

PROPERTY and REVIEW: A one-to-many relationship. One property can have multiple reviews.

USER and MESSAGE: A one-to-many relationship where the USER table is related to the MESSAGE table twice (for sender and recipient), enabling many-to-many messaging between users.
