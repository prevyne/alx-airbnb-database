-- Query 1: Find the total number of bookings made by each user.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    Users u
LEFT JOIN
    Bookings b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name
ORDER BY
    total_bookings DESC;

-- Query 2: Rank properties based on booking count using RANK().
SELECT
    p.property_id,
    p.title,
    booking_counts.total_bookings,
    RANK() OVER (ORDER BY booking_counts.total_bookings DESC) AS property_rank
FROM
    Properties p
JOIN
    (SELECT property_id, COUNT(booking_id) AS total_bookings FROM Bookings GROUP BY property_id) AS booking_counts
ON
    p.property_id = booking_counts.property_id
ORDER BY
    property_rank;