CREATE TABLE FOOD_EXPIRY (
	ID INTEGER PRIMARY KEY ASC,
	LABEL VARCHAR(255) NOT NULL,
	WARNING_INTERVAL_DAYS INT NOT NULL,
	TOSS_INTERVAL_DAYS INT NOT NULL
);

INSERT INTO FOOD_EXPIRY (LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES ('Vegetables', 5, 10);

INSERT INTO FOOD_EXPIRY (LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES ('Fruit', 5, 10);

INSERT INTO FOOD_EXPIRY (LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES ('Meat', 7, 14);

INSERT INTO FOOD_EXPIRY (LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES ('Cheese', 14, 28);

INSERT INTO FOOD_EXPIRY (LABEL, WARNING_INTERVAL_DAYS, TOSS_INTERVAL_DAYS)
VALUES ('Frozen', 365, 2920); --1 year, 8 years