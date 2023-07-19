CREATE TABLE FOOD (
    INDX int,
    LABEL varchar(255),
	CATEGORY varchar(255),
	PURCHASE_DATE date,
	WARNING_DATE date,
	TOSS_DATE date
);

CREATE INDEX idx_index
ON FOOD (INDX);







INSERT INTO FOOD (INDX, LABEL, CATEGORY, PURCHASE_DATE, WARNING_DATE, TOSS_DATE)
VALUES (
        0,
        'Apple', 
        'Fruit', 
        date(), 
        (select date(date(), '+'|| WARNING_INTERVAL_DAYS || ' days') from food_expiry where LABEL = 'Fruit'), 
        (select date(date(), '+'|| TOSS_INTERVAL_DAYS || ' days') from food_expiry where LABEL = 'Fruit')
);





--DOESN'T WORK


declare @TODAY as DATE = GETDATE();

declare @WARNING_DAYS as int = SELECT @WARNING_DAYS = SELECT WARNING_INTERVAL_DAYS FROM INVENTORY.EXPIRY WHERE LABEL = 'Fruit';

declare @TOSS_DAYS int = SELECT @TOSS_DAYS = SELECT TOSS_INTERVAL_DAYS FROM INVENTORY.EXPIRY WHERE LABEL = 'Fruit';

INSERT INTO FOOD (INDX, LABEL, CATEGORY, PURCHASE_DATE, WARNING_DATE, TOSS_DATE)
VALUES (0,'Apple', 'Fruit', @TODAY, select DATEADD(day, @WARNING_DAYS, @TODAY), select DATEADD(day, @TOSS_DAYS, @TODAY);




INSERT INTO FOOD (INDX, LABEL, CATEGORY, PURCHASE_DATE, WARNING_DATE, TOSS_DATE)
VALUES (0,'Apple', 'Fruit', date(), date(date(), '+'|| select FOOD_EXPIRY_WARNING_INTERVAL_DAYS from food_expiry|| ' days'), date(date(), '+'|| select FOOD_EXPIRY_TOSS_INTERVAL_DAYS from food_expiry|| ' days');