-- Query 1: Retrieve all bookings with their corresponding user information.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    u.email
FROM
    Bookings b
INNER JOIN
    Users u ON b.user_id = u.user_id;

-- Query 2: Retrieve all properties and their reviews, including properties without reviews.
SELECT
    p.property_id,
    p.title,
    r.rating,
    r.comment,
    r.created_on
FROM
    Properties p
LEFT JOIN
    Bookings b ON p.property_id = b.property_id
LEFT JOIN
    Reviews r ON b.booking_id = r.booking_id
ORDER BY
    p.property_id;

-- Query 3: Simulate a FULL OUTER JOIN between Users and Bookings.
-- Retrieve users and their bookings
(SELECT
    u.user_id,
    u.first_name,
    b.booking_id,
    b.status
FROM
    Users u
LEFT JOIN
    Bookings b ON u.user_id = b.user_id)
UNION
-- Retrieve bookings and their users
(SELECT
    u.user_id,
    u.first_name,
    b.booking_id,
    b.status
FROM
    Users u
RIGHT JOIN
    Bookings b ON u.user_id = b.user_id);