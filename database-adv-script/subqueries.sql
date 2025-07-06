-- Query 1: Find all properties where the average rating is greater than 4.0
SELECT
    property_id,
    title,
    price_per_night
FROM
    Properties
WHERE
    property_id IN (
        SELECT
            p.property_id
        FROM
            Properties p
        JOIN Bookings b ON p.property_id = b.property_id
        JOIN Reviews r ON b.booking_id = r.booking_id
        GROUP BY
            p.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

-- Query 2: Find users who have made more than a certain number of bookings.
SELECT
    user_id,
    first_name,
    last_name,
    email
FROM
    Users u
WHERE
    3 < (
        SELECT
            COUNT(*)
        FROM
            Bookings b
        WHERE
            b.user_id = u.user_id
    );