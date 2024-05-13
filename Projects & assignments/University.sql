-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` DEFAULT CHARACTER SET utf8 ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`colleges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`colleges` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`departments` (
  `departments_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(100) NOT NULL,
  `department_code` VARCHAR(20) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`departments_id`),
  INDEX `fk_departments_college_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_departments_college`
    FOREIGN KEY (`college_id`)
    REFERENCES `University`.`colleges` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`courses` (
  `courses_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(100) NOT NULL,
  `credits` INT NOT NULL,
  `departments_id` INT NOT NULL,
  PRIMARY KEY (`courses_id`),
  INDEX `fk_courses_departments1_idx` (`departments_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_departments1`
    FOREIGN KEY (`departments_id`)
    REFERENCES `University`.`departments` (`departments_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(50) NOT NULL,
  `faculty_lname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`sections` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR NOT NULL,
  `term` VARCHAR(10) NOT NULL,
  `section_number` INT NOT NULL,
  `capacity` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `courses_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_sections_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_sections_courses1_idx` (`courses_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `University`.`courses` (`courses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`students` (
  `students_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`students_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `students_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_enrollment_students1_idx` (`students_id` ASC) VISIBLE,
  INDEX `fk_enrollment_sections1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrollment_students1`
    FOREIGN KEY (`students_id`)
    REFERENCES `University`.`students` (`students_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_sections1`
    FOREIGN KEY (`section_id`)
    REFERENCES `University`.`sections` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Load the University database
-- Insert the University Data

-- Insert data to Table college

INSERT INTO colleges (college_name) VALUES
	('College of Physical Science and Engineering'),
	('College of Business and Communication'),
	('College of Language and Letters');
    
-- Insert data to Table departments    
    
INSERT INTO departments (department_name, department_code, college_id) VALUES
	('Computer Information Technology', 'CIT', 1),
	('Economics', 'ECON', 2),                        
	('Humanities and Philosophy', 'HUM', 3);
    
-- Insert data to Table courses

INSERT INTO courses (course_num, course_title, credits, departments_id) VALUES
	(111, 'Intro to Databases', 3, 1),
	(388, 'Econometrics', 4, 2),
	(150, 'Micro Economics', 3, 2),
	(376, 'Classical Heritage', 2, 3);
    
-- Insert data to Table faculty
    
INSERT INTO faculty (faculty_fname, faculty_lname) VALUES
    ('Marty', 'Morring'),
    ('Nate', 'Norris'),
    ('Ben', 'Barrus'),
    ('John', 'Jensen'),
    ('Bill', 'Barney');
    
-- Insert data to Table sections

INSERT INTO sections (year, term, section_number, capacity, faculty_id, courses_id) VALUES
	(2019, 'Fall', 1, 30, 1, 1),  
	(2019, 'Fall', 1, 50, 2, 3), 
	(2019, 'Fall', 2, 50, 2, 3),  
	(2019, 'Fall', 1, 35, 3, 2),  
	(2019, 'Fall', 1, 30, 4, 4),  
	(2018, 'Winter', 2, 30, 1, 1), 
	(2018, 'Winter', 3, 35, 5, 1), 
	(2018, 'Winter', 1, 50, 2, 3), 
	(2018, 'Winter', 2, 50, 2, 3), 
	(2018, 'Winter', 1, 30, 4, 4); 
    
-- Insert data to Table students
    
INSERT INTO students (first_name, last_name, gender, city, state, birthdate) VALUES
	('Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
	('Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
	('Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
	('Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
	('Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
	('Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
	('Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
	('Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
	('Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
	('Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

-- Insert data to Table enrollment

INSERT INTO enrollment (students_id, section_id) VALUES
	(6, 7),
    (7, 6),
    (7, 8),
    (7, 10),
    (4, 5),
    (9, 8),
    (2, 4),
    (3, 4),
    (5, 4),
    (5, 5),
    (1, 1),
    (1, 3),
    (8, 9),
    (10, 6);


-- Query the University database

-- Query #01

SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %d, %Y') AS 'Sep Birthdays'
FROM students
WHERE MONTH(birthdate) = 9
ORDER BY last_name;
    
-- Query #02

SELECT last_name, first_name, TIMESTAMPDIFF(YEAR, birthdate, '2017-01-05') AS Years,
DATEDIFF('2017-01-05', DATE_ADD(birthdate, INTERVAL TIMESTAMPDIFF(YEAR, birthdate, '2017-01-05') YEAR)) % 365 AS Days,
CONCAT(
	TIMESTAMPDIFF(YEAR, birthdate, '2017-01-05'), ' - Yrs, ',
	DATEDIFF('2017-01-05', DATE_ADD(birthdate, INTERVAL TIMESTAMPDIFF(YEAR, birthdate, '2017-01-05') YEAR)) % 365, ' - days'
) AS 'Years and Days'
FROM students
ORDER BY Years DESC, Days DESC;

-- Query #03

SELECT s.first_name, s.last_name
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN sections sec ON e.section_id = sec.section_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE f.faculty_fname = 'John' AND f.faculty_lname = 'Jensen'
ORDER BY s.last_name;

-- Query #04

SELECT DISTINCT f.faculty_fname, f.faculty_lname
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN sections sec ON e.section_id = sec.section_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE s.first_name = 'Bryce' AND sec.year = 2018 AND sec.term = 'Winter'
ORDER BY f.faculty_lname;

-- Query #05

SELECT DISTINCT s.first_name, s.last_name
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN sections sec ON e.section_id = sec.section_id
JOIN courses c ON sec.courses_id = c.courses_id
WHERE c.course_title = 'Econometrics' AND sec.year = 2019 AND sec.term = 'Fall'
ORDER BY s.last_name;

-- Query #06

SELECT d.department_code, c.course_num, c.course_title AS name
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN sections sec ON e.section_id = sec.section_id
JOIN courses c ON sec.courses_id = c.courses_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
JOIN departments d ON c.departments_id = d.departments_id
WHERE s.first_name = 'Bryce' AND s.last_name = 'Carlson' AND sec.year = 2018 AND sec.term = 'Winter'
ORDER BY c.course_title;

-- Query #07

SELECT term, year, COUNT(*) AS Enrollment
FROM enrollment
JOIN sections ON enrollment.section_id = sections.section_id
WHERE sections.year = 2019 AND sections.term = 'Fall'
GROUP BY term, year;

-- Query #08

SELECT c.college_name AS Colleges, COUNT(distinct cr.courses_id) AS Courses
FROM colleges c
LEFT JOIN departments d ON c.college_id = d.college_id
LEFT JOIN courses cr ON d.departments_id = cr.departments_id
GROUP BY c.college_name
ORDER BY c.college_name;

-- Query #09

SELECT f.faculty_fname AS fname, f.faculty_lname AS lname, SUM(s.capacity) AS TeachingCapacity
FROM faculty f
JOIN sections s ON f.faculty_id = s.faculty_id
WHERE s.year = 2018 AND s.term = 'Winter'
GROUP BY f.faculty_id
ORDER BY TeachingCapacity ASC;

-- Query #10

SELECT s.last_name, s.first_name, SUM(c.credits) AS Credits
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN sections sec ON e.section_id = sec.section_id
JOIN courses c ON sec.courses_id = c.courses_id
WHERE sec.year = 2019 AND sec.term = 'Fall'
GROUP BY s.students_id
HAVING Credits > 3
ORDER BY Credits DESC;

























    
