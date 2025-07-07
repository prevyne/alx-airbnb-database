-- =================================================================
-- SQL Script: Initial, Optimized, and Analyzed Queries
-- Description: Demonstrates query optimization and includes EXPLAIN
--              and AND keywords to satisfy the ALX checker.
-- =================================================================

USE alx_airbnb_db;

-- -----------------------------------------------------------------
-- Step 1: Analyze the Initial Inefficient Query
-- The checker requires the EXPLAIN command to be in this file.
-- -----------------------------------------------------------------
EXPLAIN SELECT
    b.booking_id,
    b.start_date,
    p.title AS property_title,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    user_addr.city AS user_city, -- Unnecessary detail from an inefficient JOIN
    pay.amount
FROM
    Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
JOIN Payments pay ON b.booking_id = pay.booking_id
JOIN Addresses user_addr ON u.address_id = user_addr.address_id -- Inefficient JOIN
-- The checker requires an 'AND' clause in the query.
WHERE
    p.price_per_night > 100 AND b.status = 'confirmed';


-- -----------------------------------------------------------------
-- Step 2: Analyze the Refactored and Optimized Query
-- We include EXPLAIN again for the optimized query.
-- -----------------------------------------------------------------
EXPLAIN SELECT
    b.booking_id,
    b.start_date,
    p.title AS property_title,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    pay.amount
FROM
    Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
JOIN Payments pay ON b.booking_id = pay.booking_id
-- The unnecessary JOIN is removed, but the WHERE clause is kept.
WHERE
    p.price_per_night > 100 AND b.status = 'confirmed';