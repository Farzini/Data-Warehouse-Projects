
-- by Farzam Salimi

-- Dimension 1: Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    MaritalStatus VARCHAR(10),
    HireDate DATE,
    TerminationDate DATE
);

-- Dimension 2: Department
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    DepartmentManager INT,
    DepartmentBudget FLOAT
);

-- Dimension 3: Time
CREATE TABLE Time (
    Date DATE PRIMARY KEY,
    DayOfWeek VARCHAR(10),
    Month VARCHAR(10),
    Year INT,
    FiscalYear INT,
    FiscalQuarter INT
);

-- Dimension 4: Location
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    StreetAddress VARCHAR(100),
    City VARCHAR(50),
    StateProvince VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

-- Dimension 5: JobTitle
CREATE TABLE JobTitle (
    JobTitleID INT PRIMARY KEY,
    JobTitleName VARCHAR(50),
    JobLevel INT,
    JobDescription TEXT
);

-- Fact Table 1: EmployeeSalary
CREATE TABLE EmployeeSalary (
    EmployeeID INT,
    DepartmentID INT,
    TimeID DATE,
    LocationID INT,
    JobTitleID INT,
    Salary FLOAT,
    Bonus FLOAT,
    OvertimePay FLOAT,
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY (TimeID) REFERENCES Time(Date),
FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
FOREIGN KEY (JobTitleID) REFERENCES JobTitle(JobTitleID)
);

-- Fact Table 2: EmployeeAttendance
CREATE TABLE EmployeeAttendance (
    EmployeeID INT,
    DepartmentID INT,
    TimeID DATE,
    LocationID INT,
    JobTitleID INT,
DaysPresent INT,
DaysAbsent INT,
DaysLate INT,
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY (TimeID) REFERENCES Time(Date),
FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
FOREIGN KEY (JobTitleID) REFERENCES JobTitle(JobTitleID)
);


-- Load data into Fact Table 1: EmployeeSalary
INSERT INTO EmployeeSalary (EmployeeID, DepartmentID, TimeID, LocationID, JobTitleID, Salary, Bonus, OvertimePay)
SELECT E.EmployeeID, D.DepartmentID, T.Date, L.LocationID, J.JobTitleID,
       E.Salary * (1 + B.BonusPercentage/100) AS Salary,
       E.Salary * B.BonusPercentage/100 AS Bonus,
       E.OvertimeHours * E.OvertimeRate AS OvertimePay
FROM EmployeeData E
JOIN Department D
ON E.DepartmentName = D.DepartmentName
JOIN Time T
ON E.Date = T.Date
JOIN Location L
ON E.City = L.City AND E.StateProvince = L.StateProvince AND E.Country = L.Country
JOIN JobTitle J
ON E.JobTitleName = J.JobTitleName
JOIN Bonus B
ON D.DepartmentID = B.DepartmentID AND T.FiscalYear = B.FiscalYear;



-- Load data into Fact Table 2: EmployeeAttendance
INSERT INTO EmployeeAttendance (EmployeeID, DepartmentID, TimeID, LocationID, JobTitleID, DaysPresent, DaysAbsent, DaysLate)
SELECT E.EmployeeID, D.DepartmentID, T.Date, L.LocationID, J.JobTitleID,
       E.DaysPresent,
       E.DaysAbsent,
       E.DaysLate
FROM EmployeeData E
JOIN Department D
ON E.DepartmentName = D.DepartmentName
JOIN Time T
ON E.Date = T.Date
JOIN Location L
ON E.City = L.City AND E.StateProvince = L.StateProvince AND E.Country = L.Country
JOIN JobTitle J
ON E.JobTitleName = J.JobTitleName;
