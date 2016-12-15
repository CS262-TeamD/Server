--
-- This SQL script draft implements our database schema for the classes in our app.
-- @author Cotter Koopman, cjk45, for Cleaning Crew app, CS 262 Fall 2016
-- Begun Oct. 29, 2016
-- Edited and queries added Oct. 31, 2016
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.

DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS Assignment;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Building;

-- Create the schema.
CREATE TABLE Person (
	ID varchar(50) PRIMARY KEY, --ex. cjk45
	Name varchar(100) NOT NULL, -- Cotter Koopman
	Email varchar(50) NOT NULL,-- cjk45@students.calvin.edu
	Phonenumber varchar(20), -- 6167529317 we should strip these of - . () characters
	Role varchar(20) NOT NULL --Employee (could use boolean for binary values of employer, supervisor?)
);

CREATE TABLE Building (
	ID integer PRIMARY KEY,
	Name varchar(20), --Hiemega Hall
	Shorthand varchar(5) --CFAC, SB, HH, NH
	);

CREATE TABLE Room (
	ID integer PRIMARY KEY,
	BuildingID integer REFERENCES Building(ID) NOT NULL,
	RoomNumber integer NOT NULL
	);

CREATE TABLE Task (
	ID integer PRIMARY KEY,
	RoomID integer REFERENCES Room(ID),
	Description varchar(50), --What the Person will see
	isComplete boolean NOT NULL--true for done
	);

--Could be thought of as "PersonRoom" table (like PlayerGame)
CREATE TABLE Assignment (
	ID integer PRIMARY KEY,
	TaskID integer REFERENCES Task(ID) NOT NULL,
	PersonID varchar(50) REFERENCES Person(ID) NOT NULL,
	Comment varchar(1000), --entire comment text stored here?
	CompleteTime time --should be automatically timestamped
	);

-- Allow Persons to select data from the tables.
GRANT SELECT ON Person TO PUBLIC;
GRANT SELECT ON Room TO PUBLIC;
GRANT SELECT ON Assignment TO PUBLIC;
GRANT SELECT ON Building TO PUBLIC;
GRANT SELECT ON Task TO PUBLIC;

-- Hardcode sample records.
INSERT INTO Person VALUES ('zdw3', 'Zach Wibbenmeyer', ' zdw3@students.calvin.edu', '3148219116', 'supervisor');
INSERT INTO Person VALUES ('cjp27', 'Caleb Postma', ' cjp27@students.calvin.edu', NULL, 'employee');
INSERT INTO Person VALUES ('pno2', 'Peter Oostema', ' pno2@students.calvin.edu', '6165260230', 'employee');
INSERT INTO Person VALUES ('rga6', 'Roy Adams', ' rga6@students.calvin.edu', NULL, 'employee');
INSERT INTO Person VALUES ('cjk45', 'Cotter Koopman', ' cjk45@students.calvin.edu', '6167529317', 'employee');
INSERT INTO Person VALUES ('aaa1', 'John Doe', ' aaa1@students.calvin.edu', '1111111111', 'employee');
INSERT INTO Person VALUES ('bbb2', 'Anna Smith', ' bbb2@students.calvin.edu', NULL, 'employee');
INSERT INTO Person VALUES ('ccc3', 'Andrew Jackson', ' ccc3@students.calvin.edu', '2222222222', 'employee');
INSERT INTO Person VALUES ('ddd4', 'Abraham Lincoln', ' ddd4@students.calvin.edu', NULL, 'employee');
INSERT INTO Person VALUES ('eee5', 'Kyle Walker', ' eee5@students.calvin.edu', '3333333333', 'employee');

INSERT INTO Building VALUES (0, 'Physical Plant', 'PP');
INSERT INTO Building VALUES (1, 'Hekman Library', 'HL');
INSERT INTO Building VALUES (2, 'Commons Annex', 'CA');
INSERT INTO Building VALUES (3, 'North Hall', 'NH');
INSERT INTO Building VALUES (4, 'Science Building', 'SB');
INSERT INTO Building VALUES (5, 'DeVries Hall', 'DH');

INSERT INTO Room VALUES (0, 0, 101);
INSERT INTO Room VALUES (1, 0, 201);
INSERT INTO Room VALUES (2, 0, 110);
INSERT INTO Room VALUES (3, 0, 017);
INSERT INTO Room VALUES (4, 0, 253);
INSERT INTO Room VALUES (5, 0, 354);
INSERT INTO Room VALUES (6, 0, 110);

INSERT INTO Task VALUES (0, 0, 'Clean Glass', FALSE);
INSERT INTO Task VALUES (1, 0, 'Dust', FALSE);
INSERT INTO Task VALUES (2, 0, 'Vacuum', FALSE);

INSERT INTO Task VALUES (3, 1, 'Dust Ledges and Counters', TRUE);
INSERT INTO Task VALUES (4, 1, 'Trash and Recycling', FALSE);
INSERT INTO Task VALUES (5, 1, 'Vacuum', FALSE);

INSERT INTO Task VALUES (6, 3, 'Trash and Recycling', TRUE);
INSERT INTO Task VALUES (7, 3, 'Dust', FALSE);
INSERT INTO Task VALUES (8, 3, 'Vacuum', FALSE);

INSERT INTO Task VALUES (9, 4, 'Disinfect Tables and Chairs', FALSE);
INSERT INTO Task VALUES (10, 4, 'Clean Sink and Counters', FALSE);
INSERT INTO Task VALUES (11, 4, 'Trash and Recycling', FALSE);

INSERT INTO Task VALUES (12, 5, 'Dust', TRUE);
INSERT INTO Task VALUES (13, 5, 'Sweep/Wet Mop', FALSE);
INSERT INTO Task VALUES (14, 5, 'Trash and Recycling', FALSE);

INSERT INTO Task VALUES (15, 6, 'Trash and Recycling', TRUE);
INSERT INTO Task VALUES (16, 6, 'Dust', FALSE);
INSERT INTO Task VALUES (17, 6, 'Vacuum', FALSE);

INSERT INTO Task VALUES (18, 2, 'Sweep/Wet Mop', TRUE);
INSERT INTO Task VALUES (19, 2, 'Disinfect Toilets/Urinals & Sinks', FALSE);
INSERT INTO Task VALUES (20, 2, 'Clean Glass', FALSE);


INSERT INTO Assignment VALUES (0, 0, 'cjp27', 'Make sure you vacuum in all the corners!', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (1, 1, 'cjp27', 'Make sure you vacuum in all the corners!', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (2, 2, 'cjp27', 'Make sure you vacuum in all the corners!', '2016-06-28 13:20:00');

INSERT INTO Assignment VALUES (3, 3, 'cjp27', 'The windowsills were a bit dusty last time, make sure you get all of them.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (4, 4, 'cjp27', 'The windowsills were a bit dusty last time, make sure you get all of them.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (5, 5, 'cjp27', 'The windowsills were a bit dusty last time, make sure you get all of them.', '2016-06-28 13:20:00');

INSERT INTO Assignment VALUES (6, 6, 'cjp27', 'No comment.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (7, 7, 'cjp27', 'No comment.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (8, 8, 'cjp27', 'No comment.', '2016-06-28 13:20:00');

INSERT INTO Assignment VALUES (9, 9, 'cjp27', 'Nice job!', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (10, 10, 'cjp27', 'Nice job!', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (11, 11, 'cjp27', 'Nice job!', '2016-06-28 13:20:00');

INSERT INTO Assignment VALUES (12, 12, 'cjp27', 'Please wash all the dishes in the sink when you clean it.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (13, 13, 'cjp27', 'Please wash all the dishes in the sink when you clean it.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (14, 14, 'cjp27', 'Please wash all the dishes in the sink when you clean it.', '2016-06-28 13:20:00');

INSERT INTO Assignment VALUES (15, 15, 'cjp27', 'Looks good, keep up the good work!', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (16, 16, 'cjp27', 'Looks good, keep up the good work!', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (17, 17, 'cjp27', 'Looks good, keep up the good work!', '2016-06-28 13:20:00');

INSERT INTO Assignment VALUES (18, 18, 'cjp27', 'Sorry the bathrooms are so nasty today...', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (19, 19, 'cjp27', 'Sorry the bathrooms are so nasty today...', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (20, 20, 'cjp27', 'Sorry the bathrooms are so nasty today...', '2016-06-28 13:20:00');

-----USEFUL SAMPLE QUERIES-----

--See description all of Roy's tasks
SELECT description, isComplete
FROM Task, Assignment, Person
WHERE Person.name = 'Roy Adams'
AND Person.ID = Assignment.PersonID
AND Assignment.TaskID = Task.ID;

--See all unchecked tasks in the Science Building
SELECT description
FROM Task, Assignment, Building, Room
WHERE isComplete = FALSE
AND Building.name = 'Science Building'
AND Building.ID = Room.BuildingID
AND Task.RoomID = Room.ID;

--See which buildings Caleb is assigned tasks in
SELECT Building.name
FROM Building, Assignment, Task, Room, Person
WHERE Person.name = 'Caleb Postma'
AND Person.ID = Assignment.PersonId
AND Assignment.TaskID = Task.ID
AND Task.RoomID = Room.ID
AND Room.BuildingID = Building.ID;

--See how many employees are in the system
SELECT COUNT(*) FROM Person
WHERE role = 'employee';

--See which employees have no assignments yet
SELECT DISTINCT Person.name from Person, Assignment
WHERE Person.ID NOT IN (
--Show personIDs not present in a return of all PersonIDs registered with Assignments
	SELECT
	PersonID FROM Assignment
	)
AND Person.role = 'employee';

--Check or uncheck task 0
UPDATE Task
SET isComplete =  NOT isComplete
WHERE Task.ID = 0;
--Test query
SELECT * FROM Task
WHERE Task.ID = 0;

--Leave a comment on Assignment 0
UPDATE Assignment
SET Comment =  'Keep up the good work'
WHERE Assignment.ID = 0;
--Test query
SELECT * FROM Assignment
WHERE Assignment.ID = 0;

--Erase that comment
UPDATE Assignment
SET Comment =  NULL
WHERE Assignment.ID = 0;
--Test query
SELECT * FROM Assignment
WHERE Assignment.ID = 0;
