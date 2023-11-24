CREATE DATABASE records;
USE records;
CREATE TABLE tutorials_tbl(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   tutorial_author VARCHAR(40) NOT NULL,
   submission_status INT(1) DEFAULT 0, -- Status, not done is 0, done is 1
   PRIMARY KEY ( tutorial_id )
  );

-- This code inserts a single record into the table for test purposes
INSERT INTO tutorials_tbl(tutorial_title,turotial_author,submission_status) VALUES('Best Book Ever',"Joseph Hajek",0);