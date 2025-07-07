-- =================================================================
-- SQL Script: Initial and Optimized Queries
-- Description: Demonstrates query optimization by refactoring a complex query.
-- =================================================================

USE alx_airbnb_db;

-- -----------------------------------------------------------------
-- Query 1: Initial Inefficient Query
--
-- This query retrieves booking details along with extensive user,
-- property, and payment information. It includes an unnecessary JOIN
-- to the Addresses table for the user's address, adding overhead.
-- -----------------------------------------------------------------
SELECT
    b.booking_id,
    b.start_date,
    p.title AS property_title,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    user_addr.city AS user_city, -- Unnecessary detail
    pay.amount,
    pay.payment_date
FROM
    Bookings b
JOIN
    Users u ON b.user_id = u.user_id
JOIN
    Properties p ON b.property_id = p.property_id
JOIN
    Payments pay ON b.booking_id = pay.booking_id
JOIN
    Addresses user_addr ON u.address_id = user_addr.address_id -- This JOIN is inefficient and unnecessary
WHERE
    p.price_per_night > 100;


-- -----------------------------------------------------------------
-- Query 2: Refactored and Optimized Query
--
-- This version retrieves the same essential information but removes
-- the unnecessary JOIN on the user's address. This reduces the
-- query complexity and improves execution time.
-- -----------------------------------------------------------------
SELECT
    b.booking_id,
    b.start_date,
    p.title AS property_title,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    pay.amount,
    pay.payment_date
FROM
    Bookings b
JOIN
    Users u ON b.user_id = u.user_id
JOIN
    Properties p ON b.property_id = p.property_id
JOIN
    Payments pay ON b.booking_id = pay.booking_id
WHERE
    p.price_per_night > 100;