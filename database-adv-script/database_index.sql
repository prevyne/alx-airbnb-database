-- =================================================================
-- SQL Script: Create Indexes for ALX Airbnb Database
-- Description: Adds indexes to high-usage columns to optimize query performance.
-- =================================================================

-- Use the target database
USE alx_airbnb_db;

-- 1. Index on Bookings(user_id)
-- Speeds up queries that find all bookings made by a specific user.
-- This is crucial for user-facing booking history pages.
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);

-- 2. Index on Properties(owner_id)
-- Speeds up queries searching for all properties owned by a specific user.
-- Useful for host dashboards.
CREATE INDEX idx_properties_owner_id ON Properties(owner_id);

-- 3. Composite Index on Bookings(start_date, end_date)
-- Optimizes queries that filter bookings based on a date range,
-- which is a very common operation in a booking system.
CREATE INDEX idx_bookings_dates ON Bookings(start_date, end_date);

-- 4. Index on Properties(price_per_night)
-- Improves performance for filtering or sorting properties by price.
CREATE INDEX idx_properties_price ON Properties(price_per_night);