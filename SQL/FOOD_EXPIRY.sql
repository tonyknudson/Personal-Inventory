CREATE TABLE FOOD_EXPIRY (
	INDX int,
	LABEL varchar(255),
	WARNING_INTERVAL_DAYS int,
	TOSS_INTERVAL_DAYS int
);

INSERT INTO FOOD_EXPIRY (INDX, LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES (0,'Vegetables', 5, 10);

INSERT INTO FOOD_EXPIRY (INDX, LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES (1,'Fruit', 5, 10);

INSERT INTO FOOD_EXPIRY (INDX, LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES (2,'Meat', 7, 14);

INSERT INTO FOOD_EXPIRY (INDX, LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES (3,'Cheese', 14, 28);

INSERT INTO FOOD_EXPIRY (INDX, LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES (4,'Frozen', 365, 2920); --1 year, 8 years