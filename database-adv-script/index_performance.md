# Index Performance Report

This report documents the process of identifying a performance bottleneck in the `alx_airbnb_db` database and the improvement observed after implementing an index.

## 1. Identified Performance Bottleneck

**Problem:** Queries searching for all bookings made by a specific user are slow. As the `Bookings` table grows, this operation will become a major performance issue. Without an index, the database has to perform a **full table scan**, checking every single row to find matches.

**Test Query:**
```sql
EXPLAIN SELECT * FROM Bookings WHERE user_id = 2;