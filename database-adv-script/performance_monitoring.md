# Performance Monitoring and Refinement Report

This report documents the process of monitoring a frequently used query, identifying a performance bottleneck, and implementing a schema change to optimize its performance.

---

## 1. Monitoring a Frequently Used Query

We begin by monitoring a query that searches for properties containing a specific keyword in their description. This is a common feature in applications that allow for text-based searches.

**Query to Monitor:**
```sql
-- This query uses LIKE with a leading wildcard, which is inefficient.
SELECT property_id, title, description
FROM Properties
WHERE description LIKE '%beautiful%';