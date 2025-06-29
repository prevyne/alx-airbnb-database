-- SQL Schema for AirBnB Clone Database
-- This script is written in standard SQL and should be compatible with PostgreSQL.

-- Creatng ENUM types first to be used in table definitions
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');


-- -----------------------------------------------------
-- Table `USER`
-- -----------------------------------------------------
CREATE TABLE "USER" (
  "user_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "first_name" VARCHAR(255) NOT NULL,
  "last_name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL UNIQUE,
  "password_hash" VARCHAR(255) NOT NULL,
  "phone_number" VARCHAR(50),
  "role" user_role NOT NULL DEFAULT 'guest',
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster email lookups
CREATE INDEX "idx_user_email" ON "USER" ("email");


-- -----------------------------------------------------
-- Table `PROPERTY`
-- -----------------------------------------------------
CREATE TABLE "PROPERTY" (
  "property_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "host_id" UUID NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "description" TEXT NOT NULL,
  "location" VARCHAR(255) NOT NULL,
  "price_per_night" DECIMAL(10, 2) NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "fk_property_host"
    FOREIGN KEY ("host_id")
    REFERENCES "USER" ("user_id")
    ON DELETE CASCADE
);

-- Index for finding properties by host
CREATE INDEX "idx_property_host_id" ON "PROPERTY" ("host_id");


-- -----------------------------------------------------
-- Table `BOOKING`
-- -----------------------------------------------------
CREATE TABLE "BOOKING" (
  "booking_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "property_id" UUID NOT NULL,
  "user_id" UUID NOT NULL,
  "start_date" DATE NOT NULL,
  "end_date" DATE NOT NULL,
  "total_price" DECIMAL(12, 2) NOT NULL,
  "status" booking_status NOT NULL DEFAULT 'pending',
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "fk_booking_property"
    FOREIGN KEY ("property_id")
    REFERENCES "PROPERTY" ("property_id")
    ON DELETE CASCADE,
  CONSTRAINT "fk_booking_user"
    FOREIGN KEY ("user_id")
    REFERENCES "USER" ("user_id")
    ON DELETE CASCADE,
  CONSTRAINT "check_booking_dates" CHECK ("start_date" < "end_date")
);

-- Indexes for finding bookings by property or user
CREATE INDEX "idx_booking_property_id" ON "BOOKING" ("property_id");
CREATE INDEX "idx_booking_user_id" ON "BOOKING" ("user_id");


-- -----------------------------------------------------
-- Table `PAYMENT`
-- -----------------------------------------------------
CREATE TABLE "PAYMENT" (
  "payment_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "booking_id" UUID NOT NULL UNIQUE, -- Each booking has one payment
  "amount" DECIMAL(12, 2) NOT NULL,
  "payment_date" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "payment_method" payment_method_enum NOT NULL,
  CONSTRAINT "fk_payment_booking"
    FOREIGN KEY ("booking_id")
    REFERENCES "BOOKING" ("booking_id")
    ON DELETE RESTRICT -- Prevent deleting a booking if a payment exists
);

-- Index for finding payments by booking
CREATE INDEX "idx_payment_booking_id" ON "PAYMENT" ("booking_id");


-- -----------------------------------------------------
-- Table `REVIEW`
-- -----------------------------------------------------
CREATE TABLE "REVIEW" (
  "review_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "property_id" UUID NOT NULL,
  "user_id" UUID NOT NULL,
  "rating" INTEGER NOT NULL,
  "comment" TEXT NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "fk_review_property"
    FOREIGN KEY ("property_id")
    REFERENCES "PROPERTY" ("property_id")
    ON DELETE CASCADE,
  CONSTRAINT "fk_review_user"
    FOREIGN KEY ("user_id")
    REFERENCES "USER" ("user_id")
    ON DELETE SET NULL, -- Keep review even if user account is deleted
  CONSTRAINT "check_rating_value" CHECK ("rating" >= 1 AND "rating" <= 5)
);

-- Indexes for finding reviews by property or user
CREATE INDEX "idx_review_property_id" ON "REVIEW" ("property_id");
CREATE INDEX "idx_review_user_id" ON "REVIEW" ("user_id");


-- -----------------------------------------------------
-- Table `MESSAGE`
-- -----------------------------------------------------
CREATE TABLE "MESSAGE" (
  "message_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "sender_id" UUID NOT NULL,
  "recipient_id" UUID NOT NULL,
  "message_body" TEXT NOT NULL,
  "sent_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "fk_message_sender"
    FOREIGN KEY ("sender_id")
    REFERENCES "USER" ("user_id")
    ON DELETE CASCADE,
  CONSTRAINT "fk_message_recipient"
    FOREIGN KEY ("recipient_id")
    REFERENCES "USER" ("user_id")
    ON DELETE CASCADE
);

-- Indexes for efficient message retrieval
CREATE INDEX "idx_message_sender_id" ON "MESSAGE" ("sender_id");
CREATE INDEX "idx_message_recipient_id" ON "MESSAGE" ("recipient_id");
