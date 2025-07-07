# Partitioning Performance Report

This report documents the implementation of table partitioning on the `Bookings` table and analyzes the resulting performance improvements for date-range queries.

## 1. The Performance Challenge

As the `Bookings` table grows to millions or billions of rows, queries that filter by a date range become increasingly slow. For example, finding all bookings within a specific year requires the database to scan a massive amount of data, even with an index on the `start_date` column.

## 2. What is Table Partitioning?

Table partitioning is the process of physically dividing a large table into smaller, independent sub-tables called **partitions**. The database engine is aware of this structure. When a query includes a filter on the partitioning key (in our case, `start_date`), the engine can use a technique called **partition pruning**. This means it only scans the relevant partition(s) and completely ignores the others, leading to a dramatic reduction in I/O and a significant speed increase.

## 3. Performance Test

We will analyze the following query, which seeks to find all bookings made in the year 2025.

**Test Query:**
```sql
EXPLAIN SELECT * FROM Bookings WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';