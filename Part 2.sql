CREATE TABLE Airports (
    AirportID INT PRIMARY KEY AUTO_INCREMENT,
    AirportName VARCHAR(100) NOT NULL,
    IATACode CHAR(3) UNIQUE,
    ICAOCode CHAR(4) UNIQUE,
    Country VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Latitude DECIMAL(9, 6) NOT NULL,
    Longitude DECIMAL(9, 6) NOT NULL
);

CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY AUTO_INCREMENT,
    AirlineName VARCHAR(100) NOT NULL,
    IATACode CHAR(3),
    ICAOCode CHAR(4)
);

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY AUTO_INCREMENT,
    FlightNumber VARCHAR(10) NOT NULL,
    AirlineID INT,
    DepartureAirportID INT,
    ArrivalAirportID INT,
    ScheduledDepartureTime DATETIME,
    ScheduledArrivalTime DATETIME,
    ActualDepartureTime DATETIME,
    ActualArrivalTime DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
    FOREIGN KEY (DepartureAirportID) REFERENCES Airports(AirportID),
    FOREIGN KEY (ArrivalAirportID) REFERENCES Airports(AirportID)
);

-- 2. Data Insertion and Querying
-- Insert Mock Data for 5 German Airports:

INSERT INTO Airports (AirportName, IATACode, ICAOCode, Country, City, Latitude, Longitude)
VALUES 
('Frankfurt Airport', 'FRA', 'EDDF', 'Germany', 'Frankfurt', 50.033333, 8.570556),
('Munich Airport', 'MUC', 'EDDM', 'Germany', 'Munich', 48.353889, 11.786111),
('Berlin Brandenburg Airport', 'BER', 'EDDB', 'Germany', 'Berlin', 52.366667, 13.503333),
('Hamburg Airport', 'HAM', 'EDDH', 'Germany', 'Hamburg', 53.630278, 9.988333),
('Cologne Bonn Airport', 'CGN', 'EDDK', 'Germany', 'Cologne', 50.865833, 7.142778);

-- Insert Mock Data for Airlines:

INSERT INTO Airlines (AirlineName, IATACode, ICAOCode)
VALUES
('Lufthansa', 'LH', 'DLH'),
('British Airways', 'BA', 'BAW'),
('Air France', 'AF', 'AFR'),
('KLM Royal Dutch Airlines', 'KL', 'KLM');

-- Insert Mock Data for 10 Sample Flights:

INSERT INTO Flights (FlightNumber, AirlineID, DepartureAirportID, ArrivalAirportID, ScheduledDepartureTime, ScheduledArrivalTime, ActualDepartureTime, ActualArrivalTime, Status)
VALUES
('LH123', 1, 1, 2, '2023-10-01 10:00:00', '2023-10-01 11:30:00', '2023-10-01 10:05:00', '2023-10-01 11:35:00', 'On-Time'),
('LH456', 1, 2, 3, '2023-10-01 12:00:00', '2023-10-01 13:30:00', '2023-10-01 12:30:00', '2023-10-01 14:00:00', 'Delayed'),
('BA789', 2, 3, 4, '2023-10-01 14:00:00', '2023-10-01 15:30:00', '2023-10-01 14:10:00', '2023-10-01 15:40:00', 'On-Time'),
('AF101', 3, 4, 5, '2023-10-01 16:00:00', '2023-10-01 17:30:00', '2023-10-01 16:20:00', '2023-10-01 18:00:00', 'Delayed'),
('KL202', 4, 5, 1, '2023-10-01 18:00:00', '2023-10-01 19:30:00', '2023-10-01 18:05:00', '2023-10-01 19:35:00', 'On-Time');

-- QUERIES
-- 1.Retrieve all flights from a specific airport (e.g., Frankfurt Airport):

SELECT f.FlightNumber, f.ScheduledDepartureTime, f.ActualDepartureTime, f.Status
FROM Flights f
JOIN Airports a ON f.DepartureAirportID = a.AirportID
WHERE a.IATACode = 'FRA';

-- 2.Identify flights delayed by more than 2 hours:

SELECT f.FlightNumber, f.ScheduledDepartureTime, f.ActualDepartureTime, f.Status
FROM Flights f
WHERE TIMESTAMPDIFF(MINUTE, f.ScheduledDepartureTime, f.ActualDepartureTime) > 120;

-- 3.Fetch flight details using the flight number:

SELECT f.FlightNumber, f.ScheduledDepartureTime, f.ActualDepartureTime, f.Status
FROM Flights f
WHERE TIMESTAMPDIFF(MINUTE, f.ScheduledDepartureTime, f.ActualDepartureTime) > 120;
