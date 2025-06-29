Database Schema Implementation (DDL)
This section details the SQL Data Definition Language (DDL) script used to create the database structure for the AirBnB clone application. The complete script can be found in the schema.sql file.

Script Overview
The SQL script is responsible for building the entire database schema from scratch. It is written in a standard SQL dialect (optimized for PostgreSQL) and performs the following actions:

Type Definitions: It begins by creating custom ENUM types for fields with a predefined set of values, such as user_role, booking_status, and payment_method. This enforces data consistency at the database level.

Table Creation: It executes CREATE TABLE statements for each entity defined in our ERD:

USER

PROPERTY

BOOKING

PAYMENT

REVIEW

MESSAGE

Column and Data Type Definitions: Each column is defined with the appropriate data type (e.g., UUID, VARCHAR, TEXT, DECIMAL, TIMESTAMP).

Constraint Enforcement: The script sets up all necessary constraints to ensure data integrity:

Primary Keys: Each table has a UUID primary key that defaults to a randomly generated value.

Foreign Keys: Relationships between tables are established using foreign key constraints, which define referential actions like ON DELETE CASCADE or ON DELETE SET NULL.

Unique Constraints: Ensures that values in certain columns, like the user's email, are unique across all records.

Not Null Constraints: Guarantees that essential columns cannot be empty.

Check Constraints: Implements business rules, such as ensuring a rating is between 1 and 5.

Indexing: To optimize query performance, CREATE INDEX statements are included for columns that are frequently used in search conditions (WHERE clauses) or JOIN operations. This includes foreign key columns and the email column in the USER table.
