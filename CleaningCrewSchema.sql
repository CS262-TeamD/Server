--
-- This SQL script draft implements our database schema for the classes in our app.
-- @author Cotter Koopman, cjk45, for Cleaning Crew app, CS 262 Fall 2016
-- Begun Oct. 29, 2016
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.

DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS Assignment;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Building;

-- Create the schema.
CREATE TABLE User (
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

--Could be thought of as "UserRoom" table (like PlayerGame)
CREATE TABLE Assignment (
	ID integer PRIMARY KEY,
	RoomID integer REFERENCES Room(ID) NOT NULL,
	UserID integer REFERENCES User(ID) NOT NULL,
	Comment varchar(1000), --entire comment text stored here?
	CompleteTime time --should be automatically timestamped
	);

CREATE TABLE Task (
	ID integer PRIMARY KEY,
	AssignmentID integer REFERENCES Assignment(ID),
	Description varchar(50), --What the user will see
	isComplete boolean NOT NULL--true for done
	);

-- Allow users to select data from the tables.
GRANT SELECT ON User TO PUBLIC;
GRANT SELECT ON Room TO PUBLIC;
GRANT SELECT ON Assignment TO PUBLIC;
GRANT SELECT ON Building TO PUBLIC;
GRANT SELECT ON Task TO PUBLIC;

-- Hardcode sample records.
INSERT INTO User VALUES ('zdw3', 'Zach Wibbenmeyer', ' zdw3@students.calvin.edu', '3148219116', 'supervisor');
INSERT INTO User VALUES ('cjp27', 'Caleb Postma', ' cjp27@students.calvin.edu', NULL, 'employee');
INSERT INTO User VALUES ('pno2', 'Peter Oostema', ' pno2@students.calvin.edu', '6165260230', 'employee');
INSERT INTO User VALUES ('rga6', 'Roy Adams', ' rga6@students.calvin.edu', NULL, 'employee');
INSERT INTO User VALUES ('cjk45', 'Cotter Koopman', ' cjk45@students.calvin.edu', '6167529317', 'employee');

INSERT INTO Building VALUES (0, 'Hiemega Hall', 'HH');
INSERT INTO Building VALUES (1, 'Hekman Library', 'HL');
INSERT INTO Building VALUES (2, 'Commons Annex', 'CA');
INSERT INTO Building VALUES (3, 'North Hall', 'NH');
INSERT INTO Building VALUES (4, 'Science Building', 'SB');
INSERT INTO Building VALUES (5, 'DeVries Hall', 'DH');

INSERT INTO Room VALUES (0, 0, 101); --HH101
INSERT INTO Room VALUES (1, 0, 201); --HH201
INSERT INTO Room VALUES (2, 1, 110); --HL110
INSERT INTO Room VALUES (3, 2, 017); --Dialogue Office
INSERT INTO Room VALUES (4, 3, 253); --262 classroom
INSERT INTO Room VALUES (5, 4, 354); --UNIX Lab
INSERT INTO Room VALUES (6, 5, 110); --DV 110

INSERT INTO Assignment VALUES (0, 3, 'cjk45', 'Looks amazing.', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (1, 4, 'cjp27', 'Wow, there\'s dust everywhere, yogurt spilled on the computer, and \'I H8 CLEEN KREW\' written on the board. Really dissapointed in your work ethic. -Zach', '2016-06-28 13:20:00');
INSERT INTO Assignment VALUES (2, 5, 'rga6', 'Chris likes the Buffalo Wrap from Knollcrest.', NULL); --Roy still needs to clean the UNIX lab

INSERT INTO Task VALUES (0, 1, 'Clean the yogurt.', FALSE); -- Next three tasks on same assignment
INSERT INTO Task VALUES (1, 1, 'Erase the board.', FALSE);
INSERT INTO Task VALUES (2, 1, 'Dust entire room.', FALSE);
INSERT INTO Task VALUES (3, 0, 'Vaccuum.', TRUE);
INSERT INTO Task VALUES (4, 2, 'Make sure all computers are logged out.', FALSE);
INSERT INTO Task VALUES (5, 2, 'Turn off lights.', TRUE);
INSERT INTO Task VALUES (6, 2, 'Feed Chris Wierenga.', FALSE);

/*
--Useful sample queries
--See description all of Roy's tasks
SELECT description, isComplete
FROM Task, Assignment, User
WHERE User.name = 'Roy Adams'
AND User.ID = Assignment.UserID
AND Assignment.ID = Task.AssignmentID;

--See all unchecked tasks in the Science Building
SELECT description
FROM Task, Assignment, Building
WHERE isComplete = FALSE
AND Building.name = 'Science Building'
AND Building.ID = Assignment.RoomID
AND Task.AssignmentID = Assignment.ID;

--See which buildings Caleb is assigned tasks in
SELECT Building.name
FROM Building, Assignment, Room, User
WHERE User.name = "Caleb Postma"
AND User.ID = Assignment.UserId
AND Assignment.RoomID = Room.ID
AND Room.BuildingID = Building.ID;
*/
