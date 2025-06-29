Database Seeding
This section describes the process for populating the database with sample data. A complete script with sample data can be found in the seeds.sql file.

Purpose of Seeding
Seeding the database is a crucial step for development and testing. It populates the application with a set of realistic, interconnected data that mimics real-world usage. This allows developers to:

Test application features with a populated database.

Develop frontend components with realistic data.

Verify that database relationships, constraints, and queries are working as expected.

Script Overview
The seeds.sql script contains a series of SQL INSERT statements that add sample records to each table in the correct order to respect foreign key constraints.

The script populates the database with:

Multiple Users: Creates a set of users with different roles (host and guest).

Properties: Adds properties that are owned by the host users.

Bookings: Creates active bookings made by guest users for the available properties.

Payments: Adds corresponding payment records for each booking.

Reviews: Includes sample reviews from guests for properties they have stayed at.

Messages: Simulates a conversation between a guest and a host.

By running this script, the application will be in a usable state with data that reflects a live environment.
