CREATE TABLE FOOD_STORAGE_TYPE (
    ID INTEGER PRIMARY KEY ASC,
    LABEL VARCHAR(255) NOT NULL
);

INSERT INTO FOOD_STORAGE_TYPE (LABEL)
VALUES ('Shelf');

INSERT INTO FOOD_STORAGE_TYPE (LABEL)
VALUES ('Refrigerate');

INSERT INTO FOOD_STORAGE_TYPE (LABEL)
VALUES ('Freeze');