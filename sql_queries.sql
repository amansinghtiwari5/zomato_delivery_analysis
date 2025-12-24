create database zomato;

use zomato;

CREATE TABLE zomato_delivery (
    id VARCHAR(50),
    delivery_person_id VARCHAR(50),
    delivery_person_age INT,
    delivery_person_ratings FLOAT,
    restaurant_latitude FLOAT,
    restaurant_longitude FLOAT,
    delivery_location_latitude FLOAT,
    delivery_location_longitude FLOAT,
    order_date DATE,
    time_ordered TIME,
    time_order_picked TIME,
    weather_conditions VARCHAR(50),
    road_traffic_density VARCHAR(50),
    vehicle_condition INT,
    type_of_order VARCHAR(50),
    type_of_vehicle VARCHAR(50),
    multiple_deliveries INT,
    festival VARCHAR(10),
    city VARCHAR(50),
    time_taken_min INT
);

SELECT COUNT(*) FROM zomato_delivery;

SELECT * FROM zomato_delivery LIMIT 5;

DROP TABLE zomato_delivery;

CREATE TABLE zomato_delivery (
    id VARCHAR(50),
    delivery_person_id VARCHAR(50),
    delivery_person_age INT,
    delivery_person_ratings FLOAT,
    restaurant_latitude DOUBLE,
    restaurant_longitude DOUBLE,
    delivery_location_latitude DOUBLE,
    delivery_location_longitude DOUBLE,
    order_date DATE,
    time_ordered TIME,
    time_order_picked TIME,
    weather_conditions VARCHAR(50),
    road_traffic_density VARCHAR(50),
    vehicle_condition INT,
    type_of_order VARCHAR(50),
    type_of_vehicle VARCHAR(50),
    multiple_deliveries INT,
    festival VARCHAR(10),
    city VARCHAR(50),
    time_taken_min INT
);


ALTER TABLE zomato_delivery MODIFY order_date VARCHAR(20);

SELECT order_date FROM zomato_delivery LIMIT 5;

UPDATE zomato_delivery SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE zomato_delivery
MODIFY order_date DATE;

SELECT order_date FROM zomato_delivery LIMIT 5;

ALTER TABLE zomato_delivery
MODIFY delivery_person_age VARCHAR(20),
MODIFY delivery_person_ratings VARCHAR(20),
MODIFY multiple_deliveries VARCHAR(20),
MODIFY time_taken_min VARCHAR(20);

UPDATE zomato_delivery
SET delivery_person_age = NULL
WHERE delivery_person_age = 'NaN';

UPDATE zomato_delivery
SET delivery_person_ratings = NULL
WHERE delivery_person_ratings = 'NaN';

UPDATE zomato_delivery
SET multiple_deliveries = NULL
WHERE multiple_deliveries = 'NaN';

UPDATE zomato_delivery
SET time_taken_min = NULL
WHERE time_taken_min = 'NaN';

UPDATE zomato_delivery
SET delivery_person_age = (
    SELECT avg_age FROM (
        SELECT FLOOR(AVG(delivery_person_age)) AS avg_age
        FROM zomato_delivery
        WHERE delivery_person_age IS NOT NULL
    ) t
)
WHERE delivery_person_age IS NULL;


UPDATE zomato_delivery
SET delivery_person_ratings = (
    SELECT avg_rating FROM (
        SELECT ROUND(AVG(delivery_person_ratings),2) AS avg_rating
        FROM zomato_delivery
        WHERE delivery_person_ratings IS NOT NULL
    ) t
)
WHERE delivery_person_ratings IS NULL;

UPDATE zomato_delivery
SET multiple_deliveries = 0
WHERE multiple_deliveries IS NULL;

ALTER TABLE zomato_delivery
MODIFY delivery_person_age INT,
MODIFY delivery_person_ratings FLOAT,
MODIFY multiple_deliveries INT,
MODIFY time_taken_min INT;

SELECT
    SUM(delivery_person_age IS NULL),
    SUM(delivery_person_ratings IS NULL),
    SUM(multiple_deliveries IS NULL),
    SUM(time_taken_min IS NULL)
FROM zomato_delivery;

select * from zomato_delivery;


-- Q1: Average Delivery Time by City

SELECT city,
       ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM zomato_delivery
GROUP BY city
ORDER BY avg_delivery_time DESC;

-- Q2: Impact of Traffic on Delivery Time

SELECT road_traffic_density,
       ROUND(AVG(time_taken_min), 2) AS avg_time
FROM zomato_delivery
GROUP BY road_traffic_density
ORDER BY avg_time DESC;

-- Q3: Festival vs Non-Festival Delivery Performance

SELECT festival,
       ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM zomato_delivery
GROUP BY festival;

-- Q4: Effect of Multiple Deliveries

SELECT multiple_deliveries,
       ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM zomato_delivery
GROUP BY multiple_deliveries
ORDER BY multiple_deliveries;

-- Q5: Delivery Partner Rating vs Performance

SELECT 
    CASE
        WHEN delivery_person_ratings >= 4.5 THEN 'Excellent'
        WHEN delivery_person_ratings >= 4.0 THEN 'Good'
        ELSE 'Average'
    END AS rating_category,
    ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM zomato_delivery
GROUP BY rating_category;

-- Q6: Peak Delivery Delay Hours

SELECT HOUR(time_ordered) AS order_hour,
       ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM zomato_delivery
GROUP BY order_hour
ORDER BY avg_delivery_time DESC;

-- Q7: Weather Impact Analysis

SELECT weather_conditions,
       ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM zomato_delivery
GROUP BY weather_conditions
ORDER BY avg_delivery_time DESC;









