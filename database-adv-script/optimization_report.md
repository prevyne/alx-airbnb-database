# Query Optimization Report

This report details the analysis and optimization of a complex query in the `alx_airbnb_db` database.

## 1. The Initial Query

The initial query was designed to gather comprehensive details for bookings where the property price is over $100 per night.

```sql
SELECT
    b.booking_id,
    b.start_date,
    p.title AS property_title,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    user_addr.city AS user_city,
    pay.amount,
    pay.payment_date
FROM
    Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
JOIN Payments pay ON b.booking_id = pay.booking_id
JOIN Addresses user_addr ON u.address_id = user_addr.address_id
WHERE p.price_per_night > 100;