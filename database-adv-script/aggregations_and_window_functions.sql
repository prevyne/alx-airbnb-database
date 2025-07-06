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

-- Query 2: Rank properties based on the total number of bookings they have received.
WITH PropertyBookingCounts AS (
    SELECT
        property_id,
        COUNT(booking_id) AS booking_count
    FROM
        Bookings
    GROUP BY
        property_id
)
SELECT
    p.property_id,
    p.title,
    pbc.booking_count,
    RANK() OVER (ORDER BY pbc.booking_count DESC) AS property_rank
FROM
    Properties p
JOIN
    PropertyBookingCounts pbc ON p.property_id = pbc.property_id
ORDER BY
    property_rank;