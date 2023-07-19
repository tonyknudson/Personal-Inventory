SELECT 
        DATE() AS 'Today', 
        LABEL AS 'Food Type', 
        DATE(DATE(),'+'||WARNING_INTERVAL_DAYS||' DAYS') AS 'Expiration DATE', 
        WARNING_INTERVAL_DAYS AS 'Warning Interval Days' 
FROM FOOD_EXPIRY WHERE LABEL = 'Vegetables';


SELECT DATE(DATE(), '+'|| WARNING_INTERVAL_DAYS || ' days') FROM FOOD_EXPIRY WHERE LABEL = 'Fruit'