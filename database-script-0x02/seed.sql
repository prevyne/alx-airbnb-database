- SQL Seed Script for AirBnB Clone Database
-- This script populates the tables with sample data for testing and development.

-- To make this script self-contained and runnable, we'll declare UUIDs as variables
-- In a real application, you might fetch these IDs after the initial insert.
-- For simplicity, we are pre-defining them here.

-- Sample User UUIDs
-- User 1: John Doe (Host)
-- User 2: Jane Smith (Guest)
-- User 3: Alice Johnson (Guest)
DO $$
DECLARE
    user1_id UUID := 'a1b2c3d4-e5f6-7890-1234-567890abcdef';
    user2_id UUID := 'b2c3d4e5-f6a7-8901-2345-67890abcdef1';
    user3_id UUID := 'c3d4e5f6-a7b8-9012-3456-7890abcdef12';
    
    prop1_id UUID := 'd4e5f6a7-b8c9-0123-4567-890abcdef123';
    prop2_id UUID := 'e5f6a7b8-c9d0-1234-5678-90abcdef1234';

    booking1_id UUID := 'f6a7b8c9-d0e1-2345-6789-0abcdef12345';
    booking2_id UUID := 'a7b8c9d0-e1f2-3456-7890-bcdef1234567';
BEGIN

-- Insert Users
INSERT INTO "USER" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
(user1_id, 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '123-456-7890', 'host'),
(user2_id, 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '234-567-8901', 'guest'),
(user3_id, 'Alice', 'Johnson', 'alice.j@example.com', 'hashed_password_3', '345-678-9012', 'guest');

-- Insert Properties (Owned by John Doe)
INSERT INTO "PROPERTY" (property_id, host_id, name, description, location, price_per_night) VALUES
(prop1_id, user1_id, 'Cozy Downtown Apartment', 'A beautiful and cozy apartment in the heart of the city. Perfect for a weekend getaway.', 'New York, NY', 150.00),
(prop2_id, user1_id, 'Sunny Beachside Villa', 'A stunning villa with a private pool and direct access to the beach.', 'Miami, FL', 350.50);

-- Insert Bookings
-- Jane Smith books the Cozy Apartment
INSERT INTO "BOOKING" (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
(booking1_id, prop1_id, user2_id, '2025-07-10', '2025-07-15', 750.00, 'confirmed');

-- Alice Johnson books the Beachside Villa
INSERT INTO "BOOKING" (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
(booking2_id, prop2_id, user3_id, '2025-08-01', '2025-08-08', 2453.50, 'confirmed');

-- Insert Payments
INSERT INTO "PAYMENT" (booking_id, amount, payment_method) VALUES
(booking1_id, 750.00, 'credit_card'),
(booking2_id, 2453.50, 'paypal');

-- Insert Reviews
-- Jane reviews the Cozy Apartment
INSERT INTO "REVIEW" (property_id, user_id, rating, comment) VALUES
(prop1_id, user2_id, 5, 'Amazing place! John was a great host. The apartment was clean, comfortable, and in a perfect location. Highly recommend!');

-- Alice reviews the Beachside Villa
INSERT INTO "REVIEW" (property_id, user_id, rating, comment) VALUES
(prop2_id, user3_id, 4, 'The villa was beautiful and the pool was fantastic. We had a great time. Minor issue with the Wi-Fi, but it was resolved quickly.');

-- Insert Messages (A conversation between Jane and John)
INSERT INTO "MESSAGE" (sender_id, recipient_id, message_body) VALUES
(user2_id, user1_id, 'Hi John, just wanted to confirm our check-in time for the 10th. We are expecting to arrive around 3 PM. Is that okay?'),
(user1_id, user2_id, 'Hi Jane, 3 PM works perfectly! The apartment will be ready for you. Let me know if you need anything else.');

END $$;
