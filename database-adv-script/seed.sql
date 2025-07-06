-- =================================================================
-- SQL Script: ALX Airbnb Project Seeder
-- Description: Creates the full database schema and populates it
--              with sample data for development and testing.
-- Version:     1.0
-- =================================================================

-- Creates and selects the database first
CREATE DATABASE IF NOT EXISTS alx_airbnb_db;
USE alx_airbnb_db;

-- To ensure a fresh start, drop tables in reverse dependency order
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS PropertyImages;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Properties;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Addresses;

-- ================================================
-- 1. Addresses: Centralized location data
-- ================================================
CREATE TABLE Addresses (
  address_id    INT AUTO_INCREMENT PRIMARY KEY,     -- Surrogate key
  street        VARCHAR(255) NOT NULL,            -- Street address
  city          VARCHAR(100) NOT NULL,            -- City name
  state         VARCHAR(100),                     -- State or province
  postal_code   VARCHAR(20),                      -- ZIP or postal code
  country       VARCHAR(100) NOT NULL,            -- Country name

  -- Indexes to speed up lookups by city and country
  INDEX idx_addresses_city    (city),
  INDEX idx_addresses_country (country)
) ENGINE=InnoDB;


-- ================================================
-- 2. Users: Tenants and property owners
-- ================================================
CREATE TABLE Users (
  user_id       INT AUTO_INCREMENT PRIMARY KEY,     -- Surrogate user key
  first_name    VARCHAR(50)  NOT NULL,            -- User’s first name
  last_name     VARCHAR(50)  NOT NULL,            -- User’s last name
  email         VARCHAR(100) NOT NULL,            -- User’s email (unique)
  phone         VARCHAR(20),                      -- User’s phone number
  address_id    INT          NOT NULL,            -- FK to Addresses

  UNIQUE KEY uq_users_email (email),               -- Enforce unique email
  FOREIGN KEY (address_id)
    REFERENCES Addresses(address_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,                           -- Prevent deleting used addresses

  INDEX idx_users_address (address_id)            -- Speed up address joins
) ENGINE=InnoDB;


-- ================================================
-- 3. Properties: Listings posted by owners
-- ================================================
CREATE TABLE Properties (
  property_id     INT AUTO_INCREMENT PRIMARY KEY, -- Surrogate property key
  owner_id        INT          NOT NULL,          -- FK to Users
  title           VARCHAR(255) NOT NULL,          -- Short listing title
  description     TEXT,                           -- Detailed description
  price_per_night DECIMAL(10,2) NOT NULL,         -- Nightly rate
  address_id      INT          NOT NULL,          -- FK to Addresses

  FOREIGN KEY (owner_id)
    REFERENCES Users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,                            -- Remove properties if owner deleted

  FOREIGN KEY (address_id)
    REFERENCES Addresses(address_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,                           -- Keep properties if address removed

  INDEX idx_props_owner   (owner_id),             -- Speed up owner lookups
  INDEX idx_props_address (address_id),           -- Speed up address joins
  INDEX idx_props_price   (price_per_night)       -- Speed up price filtering
) ENGINE=InnoDB;


-- ================================================
-- 4. Bookings: Reservations made by users
-- ================================================
CREATE TABLE Bookings (
  booking_id    INT AUTO_INCREMENT PRIMARY KEY,   -- Surrogate booking key
  user_id       INT          NOT NULL,            -- FK to Users
  property_id   INT          NOT NULL,            -- FK to Properties
  start_date    DATE         NOT NULL,            -- Check-in date
  end_date      DATE         NOT NULL,            -- Check-out date
  status        VARCHAR(50)  NOT NULL,            -- e.g., 'confirmed', 'pending'

  FOREIGN KEY (user_id)
    REFERENCES Users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,                            -- Remove bookings if user deleted

  FOREIGN KEY (property_id)
    REFERENCES Properties(property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,                            -- Remove bookings if property deleted

  -- Ensure end_date is after start_date
  CONSTRAINT chk_dates CHECK (end_date > start_date),

  INDEX idx_book_user  (user_id),                 -- Speed up user booking queries
  INDEX idx_book_prop  (property_id)              -- Speed up property booking queries
) ENGINE=InnoDB;


-- ================================================
-- 5. Payments: Transaction records for bookings
-- ================================================
CREATE TABLE Payments (
  payment_id      INT AUTO_INCREMENT PRIMARY KEY,  -- Surrogate payment key
  booking_id      INT          NOT NULL,           -- FK to Bookings
  payment_date    DATETIME     NOT NULL
                    DEFAULT CURRENT_TIMESTAMP,     -- Timestamp of payment
  amount          DECIMAL(10,2) NOT NULL,          -- Amount paid
  payment_method  VARCHAR(50)  NOT NULL,           -- e.g. 'Credit Card', 'M-Pesa'

  FOREIGN KEY (booking_id)
    REFERENCES Bookings(booking_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,                             -- Remove payments if booking deleted

  INDEX idx_pay_booking (booking_id),              -- Speed up lookup by booking
  INDEX idx_pay_date    (payment_date)             -- Speed up date-range queries
) ENGINE=InnoDB;


-- ================================================
-- 6. PropertyImages: Images for each property
-- ================================================
CREATE TABLE PropertyImages (
  image_id      INT AUTO_INCREMENT PRIMARY KEY,   -- Surrogate image key
  property_id   INT           NOT NULL,           -- FK to Properties
  image_url     VARCHAR(2083) NOT NULL,           -- Image link (max URL length)
  alt_text      VARCHAR(255),                     -- Accessible description

  FOREIGN KEY (property_id)
    REFERENCES Properties(property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,                             -- Remove images if property deleted

  INDEX idx_img_property (property_id)            -- Speed up image-by-property queries
) ENGINE=InnoDB;


-- ================================================
-- 7. Reviews: One review per booking
-- ================================================
CREATE TABLE Reviews (
  review_id     INT AUTO_INCREMENT PRIMARY KEY,    -- Surrogate review key
  booking_id    INT           NOT NULL,            -- FK to Bookings
  rating        TINYINT       NOT NULL             -- Rating 1 to 5
                  CHECK (rating BETWEEN 1 AND 5),
  comment       TEXT,                              -- Review text
  created_on    DATETIME      NOT NULL
                  DEFAULT CURRENT_TIMESTAMP,       -- When review was left

  FOREIGN KEY (booking_id)
    REFERENCES Bookings(booking_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,                             -- Remove reviews if booking deleted

  UNIQUE KEY uq_review_booking (booking_id),       -- One review per booking
  INDEX idx_rev_booking (booking_id),              -- Speed up lookup by booking
  INDEX idx_rev_date    (created_on)               -- Speed up date-range queries
) ENGINE=InnoDB;


-- =================================================================
-- POPULATE TABLES WITH SAMPLE DATA
-- Data is inserted in order of dependency.
-- =================================================================

-- 1. Insert Addresses
INSERT INTO Addresses (street, city, state, postal_code, country) VALUES
('123 Koinange St', 'Nakuru', 'Nakuru County', '20100', 'Kenya'),
('456 Oginga Odinga Rd', 'Kisumu', 'Kisumu County', '40100', 'Kenya'),
('789 Moi Avenue', 'Mombasa', 'Mombasa County', '80100', 'Kenya'),
('101 Kimathi St', 'Nanyuki', 'Laikipia County', '10400', 'Kenya'),
('202 Kenyatta Avenue', 'Nairobi', 'Nairobi County', '00100', 'Kenya');

-- 2. Insert Users
INSERT INTO Users (first_name, last_name, email, phone, address_id) VALUES
('Juma', 'Otieno', 'j.otieno@example.com', '0712345678', 1),
('Aisha', 'Mwangi', 'a.mwangi@example.com', '0723456789', 2),
('Samuel', 'Kariuki', 's.kariuki@example.com', '0734567890', 5),
('Fatima', 'Ali', 'f.ali@example.com', '0745678901', 3);

-- 3. Insert Properties
INSERT INTO Properties (owner_id, title, description, price_per_night, address_id) VALUES
(1, 'Serene Lake Nakuru Cottage', 'A beautiful cottage with views of the flamingo-filled lake.', 150.00, 1),
(2, 'Vibrant City Loft in Kisumu', 'Modern loft apartment in the heart of Kisumu, perfect for exploring the city.', 110.50, 2),
(1, 'Cozy Beachfront Banda', 'Relax in this charming banda right on the shores of the Indian Ocean.', 200.00, 3),
(3, 'Luxury Nanyuki Retreat', 'Escape to this stunning retreat near Mt. Kenya with top-tier amenities.', 250.75, 4);

-- 4. Insert Bookings
-- Juma (User 1) is a host, but let's have him book another property
INSERT INTO Bookings (user_id, property_id, start_date, end_date, status) VALUES
(2, 4, '2025-08-10', '2025-08-15', 'confirmed'), -- Aisha books Samuel's place
(3, 1, '2025-09-01', '2025-09-05', 'confirmed'), -- Samuel books Juma's place
(4, 2, '2025-09-20', '2025-09-23', 'pending'),   -- Fatima books Aisha's place
(2, 1, '2025-10-05', '2025-10-10', 'confirmed'); -- Aisha also books Juma's cottage

-- 5. Insert Payments
INSERT INTO Payments (booking_id, amount, payment_method) VALUES
(1, 1253.75, 'M-Pesa'), -- 5 nights * 250.75
(2, 600.00, 'Credit Card'),  -- 4 nights * 150.00
(4, 750.00, 'PayPal');      -- 5 nights * 150.00
-- Note: Booking 3 is 'pending' and has no payment yet.

-- 6. Insert PropertyImages
INSERT INTO PropertyImages (property_id, image_url, alt_text) VALUES
(1, 'https://example.com/images/nakuru_cottage_1.jpg', 'Exterior view of the Nakuru cottage'),
(1, 'https://example.com/images/nakuru_cottage_2.jpg', 'Living room of the Nakuru cottage'),
(2, 'https://example.com/images/kisumu_loft_1.jpg', 'Main living area of the Kisumu loft'),
(3, 'https://example.com/images/mombasa_banda_1.jpg', 'View of the Mombasa banda from the beach'),
(4, 'https://example.com/images/nanyuki_retreat_1.jpg', 'Pool area at the Nanyuki retreat');

-- 7. Insert Reviews
-- Reviews are only for completed bookings
INSERT INTO Reviews (booking_id, rating, comment) VALUES
(1, 5, 'Absolutely breathtaking! The property was stunning and the service was impeccable. Will return!'),
(2, 4, 'A lovely, clean, and quiet place. Juma was a great host. The location is perfect for seeing the flamingos.'),
(4, 5, 'We had another fantastic stay at the cottage. It feels like a home away from home. Highly recommended.');


-- =================================================================
-- Script Execution Complete
-- =================================================================
SELECT 'Database schema created and seeded successfully.' AS Status;