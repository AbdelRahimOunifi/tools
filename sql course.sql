-- Data Definition Language (DDL) Statements

USE MASTER

 -- Command to Create Database
CREATE DATABASE School_Management_Db 

 -- Command to Alter Database
ALTER DATABASE School_Management_Db MODIFY NAME = SchoolManagementDb

 -- Command to Remove Database
DROP DATABASE School_Management_Db


CREATE DATABASE SchoolManagementDb
 GO
USE SchoolManagementDb

CREATE TABLE Students(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StudentId NVARCHAR(10) UNIQUE,
	ProgrammeOfStudy NVARCHAR(150) NOT NULL,
)

CREATE TABLE Lecturers (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StaffId NVARCHAR(10) UNIQUE
)

CREATE TABLE Courses (
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Code NVARCHAR(5) UNIQUE,
	Credits int
)


USE [SchoolManagementDb]

-- Single insert with columns specified
-- INSERT INTO TableName (Col1, Col2, Col3, Col6, Col5)
-- VALUES (val1, val2, val3, val6, val5)

-- Multi insert with columns specified
-- INSERT INTO TableName (Col1, Col2, Col3, Col6, Col5)
-- VALUES (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),
--		  (val1, val2, val3, val6, val5),

-- Single Insert without columns specified. Columns must match order and data type
-- INSERT INTO TableName VALUES (val1, val2, val3, val6, val5)

INSERT INTO Lecturers(LastName, FirstName, StaffId) 
VALUES ('Tajay', 'Reid', '1478523627'),
	   ('Lennon', 'Wilson', '1478533697'),
	   ('Howard', 'Bryant', '1478553697'),
	   ('Yanique', 'Foster', '1475523697')
	   
	   
	   
	   
USE [SchoolManagementDb]

-- Basic SELECT Query
SELECT * FROM Lecturers;
SELECT FirstName, LastName, StaffId FROM Lecturers;
SELECT * FROM Courses;

-- Query with filters
SELECT * FROM Lecturers WHERE Id = 6
 -- Adding multiple conditions
SELECT * FROM Lecturers 
	WHERE FirstName = 'Tajay' OR LastName = 'Tajay'

SELECT * FROM Lecturers 
	WHERE FirstName = 'Reid' AND LastName = 'Tajay'

-- Using wildcard to specify what string must start with
SELECT * FROM Lecturers WHERE FirstName LIKE 'W%'

-- Using wildcard to specify what string must end with
SELECT * FROM Lecturers WHERE FirstName LIKE '%r'

-- Using wildcard to specify what string must contain
SELECT * FROM Lecturers WHERE FirstName LIKE '%t%'

-- Using comparisons
SELECT * FROM Courses WHERE Credits < 3;
SELECT * FROM Courses WHERE Credits > 3;
SELECT * FROM Courses WHERE Credits >= 3;
SELECT * FROM Courses WHERE Credits <= 3;


SELECT 
       [FirstName] [First Name]
      ,[LastName] [Last Name]
      ,[DateOfBirth] [Date Of Birth]
	  ,CASE 
		WHEN StaffId IS NULL THEN 'Not Onboarded' 
		ELSE StaffId 
	   END [Staff Id]
  FROM [SchoolManagementDb].[dbo].[Lecturers]
  
 USE [SchoolManagementDb]

-- UPDATE TableName SET col1 = newValue, col2 = newValue2
/* OPTIONAL */
-- WHERE Id = 1

SELECT * FROM Lecturers WHERE Id = 4

UPDATE Lecturers SET DateOfBirth = '1988-02-05', FirstName = 'Britt'
WHERE Id = 4

UPDATE Lecturers SET DateOfBirth = '1990-01-01'
WHERE DateOfBirth IS NULL

SELECT * FROM Lecturers

USE [SchoolManagementDb]

-- DELETE FROM TableName WHERE condition

DELETE FROM Lecturers WHERE FirstName = 'Howard' AND StaffId <> '1478553697'

Select * from Lecturers 
Select * from Lecturers 
WHERE FirstName = 'Howard' AND StaffId <> '1478553697'


USE [SchoolManagementDb]

-- Transaction create a staging area for changes

/*
	BEGIN TRANSACTION
		DELETE SQL COMMANDS
		UPDATE SQL COMMANDS
		INSERT SQL COMMANDS
	COMMIT - To Confirm
	ROLLBACK - To Undo
*/

BEGIN TRANSACTION
	DELETE FROM Lecturers WHERE StaffId = '1478523627'
COMMIT;
ROLLBACK

select * from lecturers




USE [SchoolManagementDb]

-- Commands to add new column to tables with relationships
ALTER TABLE Students 
ADD ProgrammeOfStudyId int FOREIGN KEY REFERENCES ProgrammesOfStudy(Id)

ALTER TABLE Courses 
ADD ProgrammeOfStudyId int FOREIGN KEY REFERENCES ProgrammesOfStudy(Id)

-- Creating new tables with relationships and foreign keys
CREATE TABLE Classes (
	Id int PRIMARY KEY IDENTITY,
	LecturerId int FOREIGN KEY REFERENCES Lecturers(Id),
	CourseId int FOREIGN KEY REFERENCES Courses(Id),
	[Time] time 
)

CREATE TABLE Enrollments (
	Id int PRIMARY KEY IDENTITY,
	StudentId int FOREIGN KEY REFERENCES Students(Id),
	ClassId int FOREIGN KEY REFERENCES Classes(Id),
	Grade nvarchar(2) 
)






use [SchoolManagementDb]

insert into [dbo].[ProgrammesOfStudy] values
('Bsc. in Information Technology', 4),
('Bsc. in Teaching', 2),
('ASc. in Gardening', 2),
('ASc. in Finance', 2)

select * from ProgrammesOfStudy

insert into students values 
('Peter', 'Johnson', '1991-08-09', '1478523685', 1),
('Peter', 'Pan', '1991-08-09', '1478523756', 2),
('John', 'Paul', '1991-08-09', '1478523678', 3),
('Matthew', 'Swanson', '1991-08-09', '1278523696', 3)

select * from students


select * from Lecturers

insert into courses values
('Database Development'		,'DB101',	3,	1),
('C++ Development'			,'CP101',	3,	1),
('C# Programming'			,'CS101',	4,	1)

select * from Courses
insert into classes values
(11, 1, '12:00'), 
(11, 3, '13:00'), 
(12, 1, '10:00'), 
(17, 1, '08:00'), 
(17, 5, '15:00')

select * from classes
select * from students

insert into Enrollments values
(3, 1, NULL), 
(3, 3, NULL), 
(5, 1, NULL), 
(6, 1, NULL), 
(6, 5, NULL)

select * from Enrollments



use [SchoolManagementDb]

select * from students
select * from ProgrammesOfStudy
select * from Classes


SELECT Students.StudentId [Student Id], 
		Students.FirstName [First Name], 
		Students.LastName [Last Name], 
		ProgrammesOfStudy.Name [Programmes Of Study], 
		ProgrammesOfStudy.DurationInYears [Estimated Duration In Years]
FROM Students 
	INNER JOIN ProgrammesOfStudy 
		ON Students.ProgrammeOfStudyId = ProgrammesOfStudy.Id

SELECT 
	co.Name [Course Name],
	co.Code [Course Code],
	l.FirstName + ' ' + l.LastName [Lecturer],
	c.Time [Class Time]
FROM Classes c
INNER JOIN Lecturers l ON c.LecturerId = l.Id
INNER JOIN Courses co ON c.CourseId = co.Id




USE [SchoolManagementDb]

-- We want classes and who is teaching them
SELECT * FROM Classes c
INNER JOIN Lecturers l ON c.LecturerId = l.Id

-- We want classes and who is teaching them even if no one is assigned
SELECT * FROM Classes c 
LEFT JOIN Lecturers l ON c.LecturerId = l.Id
-- RIGHT JOIN Lecturers l ON c.LecturerId = l.Id
SELECT * FROM Classes c 
RIGHT JOIN Lecturers l ON c.LecturerId = l.Id
-- FUll Join
SELECT * FROM Classes c 
FULL JOIN Lecturers l ON c.LecturerId = l.Id
-- Cross Join
SELECT * FROM Classes c CROSS JOIN Lecturers


USE [SchoolManagementDb]

select * from Enrollments
select * from Classes

-- Select distinct
SELECT DISTINCT * FROM Enrollments
SELECT DISTINCT e.StudentId, s.FirstName + ' ' + s.LastName [Student Name] 
FROM Enrollments e
INNER JOIN Students s on s.Id = e.StudentId

-- group by
select CourseId, co.Code, co.Name from Classes c
INNER JOIN Courses co on co.Id = c.CourseId
WHERE LecturerId = 11
GROUP BY CourseId, co.Code, co.Name


USE [SchoolManagementDb]

select * from Enrollments
select * from Classes

-- Select distinct
SELECT DISTINCT * FROM Enrollments
SELECT DISTINCT e.StudentId, s.FirstName + ' ' + s.LastName [Student Name] 
FROM Enrollments e
INNER JOIN Students s on s.Id = e.StudentId

-- group by
select CourseId, co.Code, co.Name from Classes c
INNER JOIN Courses co on co.Id = c.CourseId
WHERE LecturerId = 11
GROUP BY CourseId, co.Code, co.Name




SELECT e.StudentId [Student Id],
	   s.FirstName + ' ' + s.LastName [Student name],
	   AVG(Grade)[Average Grade],
	   MIN(Grade)[Lowest Grade],
	   MAX(Grade)[Maximum Grade],
	   COUNT(Grade) [Number of Classes]
	FROM Enrollments e
	INNER JOIN Students s on s.Id = e.StudentId
	GROUP BY e.StudentID, s.FirstName, s.LastName

SELECT AVG(Grade) FROM Enrollments
where ClassId = 1

SELECT COUNT(ID) [Number of Students],
	   AVG(Grade)[Average Grade],
	   MIN(Grade)[Lowest Grade],
	   MAX(Grade)[Maximum Grade],
	FROM Enrollments
where ClassId = 1



SELECT * FROM Enrollments e
INNER JOIN Classes cl on cl.Id = e.ClassId
INNER JOIN Courses co on co.Id = cl.CourseId
INNER JOIN Students s on s.Id = e.StudentId



SELECT e.StudentId [Student Id],
	   s.FirstName + ' ' + s.LastName [Student name],
	   AVG(Grade)[Average Grade],
	   SUM(co.Credits) [Credits]
	    FROM Enrollments e
INNER JOIN Classes cl on cl.Id = e.ClassId
INNER JOIN Courses co on co.Id = cl.CourseId
INNER JOIN Students s on s.Id = e.StudentId
GROUP BY e.StudentId, s.FirstName, s.LastName



SELECT e.StudentId [Student Id],
	   s.FirstName + ' ' + s.LastName [Student name],
	   AVG(Grade)[Average Grade],
	   SUM(co.Credits) [Credits]
	    FROM Enrollments e
INNER JOIN Classes cl on cl.Id = e.ClassId
INNER JOIN Courses co on co.Id = cl.CourseId
INNER JOIN Students s on s.Id = e.StudentId
GROUP BY e.StudentId, s.FirstName, s.LastName
HAVING SUM(co.Credits) > 3



SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;


USE [SchoolManagementDb]
GO
CREATE VIEW VW_StudentEnrollmentDetails AS

SELECT e.StudentId [Student Id],
	   s.FirstName + ' ' + s.LastName [Student name],
	   AVG(Grade)[Average Grade],
	   MIN(Grade)[Lowest Grade],
	   MAX(Grade)[Maximum Grade],
	   COUNT(Grade) [Number of Classes]
	FROM Enrollments e
	INNER JOIN Students s on s.Id = e.StudentId
	GROUP BY e.StudentID, s.FirstName, s.LastName;


