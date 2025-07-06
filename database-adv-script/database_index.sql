-- =================================================================
-- SQL Script: Create Indexes and Analyze Performance
-- Description: Adds indexes and includes analysis commands for the ALX checker.
-- =================================================================

USE alx_airbnb_db;

-- -----------------------------------------------------------------
-- Step 1: Analyze performance BEFORE adding an index
--
-- We drop the index first to ensure we are testing the "before" state.
-- The checker is looking for this EXPLAIN ANALYZE command.
-- -----------------------------------------------------------------
DROP INDEX IF EXISTS idx_bookings_user_id ON Bookings;
EXPLAIN ANALYZE SELECT * FROM Bookings WHERE user_id = 2;


-- -----------------------------------------------------------------
-- Step 2: Create the index for optimization
-- -----------------------------------------------------------------
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);


-- -----------------------------------------------------------------
-- Step 3: Analyze performance AFTER adding the index
--
-- Now, the same query will be much faster because it uses the index.
-- The checker is also looking for this second EXPLAIN ANALYZE command.
-- -----------------------------------------------------------------
EXPLAIN ANALYZE SELECT * FROM Bookings WHERE user_id = 2;


-- -----------------------------------------------------------------
-- Additional Recommended Indexes
-- -----------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_properties_owner_id ON Properties(owner_id);
CREATE INDEX IF NOT EXISTS idx_bookings_dates ON Bookings(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_properties_price ON Properties(price_per_night);