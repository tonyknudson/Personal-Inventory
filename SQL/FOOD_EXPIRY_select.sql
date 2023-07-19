select 
        date() as 'Today', 
        food_expiry_label as 'Food Type', 
        date(date(),'+'||FOOD_EXPIRY_WARNING_INTERVAL_DAYS||' DAYS') as 'Expiration Date', 
        FOOD_EXPIRY_WARNING_INTERVAL_DAYS as 'Warning Interval Days' 
from FOOD_EXPIRY WHERE FOOD_EXPIRY_LABEL = 'Vegetables';


select date(date(), '+'|| FOOD_EXPIRY_WARNING_INTERVAL_DAYS || ' days') from food_expiry where FOOD_EXPIRY_LABEL = 'Fruit'