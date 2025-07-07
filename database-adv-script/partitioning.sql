-- =================================================================
-- SQL Script: Partition the Bookings Table
-- Description: Modifies the Bookings table to improve performance
--              on date-range queries by partitioning by year.
-- =================================================================

USE alx_airbnb_db;

-- To partition the table, the partitioning key (`start_date`) must be in the primary key.
-- First,remove the existing primary key and add a new composite one.
-- Note: This might fail if foreign key constraints are in the way.
-- For this project, we assume it's possible or that dependencies are handled.
ALTER TABLE Bookings DROP PRIMARY KEY, ADD PRIMARY KEY (booking_id, start_date);

-- Now, apply partitioning to the table.
ALTER TABLE Bookings PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before_2025 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);