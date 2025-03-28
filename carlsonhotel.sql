/*Databasen är skapad av Henrik Karlsson och Mattias Karlsson*/
/*Skapar databasen Hotell*/
CREATE DATABASE CarlsonHotel;
USE CarlsonHotel;
/*bookingservice
Skapar tabellen Guest
*/
CREATE TABLE Guest (
    GuestID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
    );
 /*
 Skapar tabellen RoomType
 */
 CREATE TABLE RoomType (
     RoomTypeID INT PRIMARY KEY AUTO_INCREMENT,
     RoomName VARCHAR(50) NOT NULL,
     Price DECIMAL(10,2) NOT NULL
     );
 /*
 Skapar tabellen Room
 */
 CREATE TABLE Room (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomTypeID INT NOT NULL,
    RoomNumber VARCHAR(10) UNIQUE NOT NULL,
    RoomStatus ENUM('Available', 'Occupied') NOT NULL DEFAULT 'Available',
    FOREIGN KEY (RoomTypeID) REFERENCES RoomType(RoomTypeID)
    );
/* 
Skapar tabellen Booking
*/
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    CheckinDate DATE NOT NULL,
    CheckoutDate DATE NOT NULL,
    BookingStatus ENUM('Booked', 'Checked-in', 'Checked-out', 'Cancelled') NOT NULL DEFAULT 'Booked',
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
    );
/*
Lägg till en constraint i tabellen Booking
*/
ALTER TABLE Booking
ADD CONSTRAINT check_min_one_night
CHECK (CheckoutDate > CheckinDate); -- Utcheckning ska vara större än incheckning 
    
/*
Skapar tabellen PayMethod
*/
CREATE TABLE PayMethod (
	 PayMethodID INT PRIMARY KEY AUTO_INCREMENT,
     MethodName VARCHAR(50) NOT NULL
     );
/*
Skapar tabellen Payment
*/
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT NOT NULL,
    PayMethodID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentStatus ENUM('Pending', 'Paid', 'Refunded') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (PayMethodID) REFERENCES PayMethod(PayMethodID)
    );

 /*
 Skapar tabellen Service
 */
 CREATE TABLE Service (
     ServiceID INT PRIMARY KEY AUTO_INCREMENT,
     ServiceName VARCHAR(50) NOT NULL,
     Price DECIMAL(10,2) NOT NULL
     );
 /*
 Skapar tabellen BookingService
 */
 CREATE TABLE BookingService (
     BKServiceID INT PRIMARY KEY AUTO_INCREMENT,
     BookingID INT NOT NULL,
     ServiceID INT NOT NULL,
     Quantity INT NOT NULL,
     FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
     FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
     );
 /*
Skapar tabellen BokingLog
*/
CREATE TABLE BookingLog (
        LogID INT PRIMARY KEY AUTO_INCREMENT,
        BookingID INT NOT NULL,
        Action VARCHAR(50) NOT NULL DEFAULT 'NEW',
        LogTime DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
        );
/*
Infogar data i tabellen Guest
*/

INSERT INTO Guest (FirstName, LastName, Phone, Email) VALUES
('Matilda', 'Andersson', '0707-610 632', 'Matildas@mail.com'),
('Mattias', 'Karlsson', '0735-401 390', 'Mattias70@spray.se'),
('Henrik', 'Henriksson','0761-610 259', 'Henrik.karlsson@hotmail.com'),
('Sandra','Dahlberg', '0744-999 333', 'Sandra.D@gmail.com');

/*
Infogar data i tabellen RoomType
*/
INSERT INTO RoomType (RoomName, Price) VALUES
('Enkelrum', 990),
('Dubbelrum', 1590),
('Deluxe Dubbelrum', 1995),
('Premium Deluxe', 2990);
/*
Infogar data i tabellen Room
*/
INSERT INTO Room (RoomTypeID, RoomNumber) VALUES
(1, '101'), -- Enkelrum
(1, '102'),
(2, '201'), -- Dubbelrum
(2, '202'),
(3, '301'), -- Deluxe Dubbelrum 
(3, '302'),
(4, '401'), -- Premium Deluxe
(4, '402');
/*
Infogar data i tabellen Booking
*/
INSERT INTO Booking (GuestID, RoomID, CheckinDate, CheckoutDate ) VALUES
(1, 1, '2025-03-24', '2025-03-25'),  -- RoomID 1 är enkelrum med rumsnummer 101
(2, 7, '2025-03-25', '2025-03-28'),  -- RoomID 7 är Premium Deluxe med rumsnummer 401
(3, 5, '2025-07-14', '2025-07-16'),  -- RoomID 5 är Deluxe Dubbelrum med rumsnummer 301
(4, 3, '2025-10-07', '2025-10-08'),  -- RoomID 3 är Dubbelrum med rumsnummer 201
(2, 4, '2025-10-07', '2025-10-08'),  -- RoomID 4 är Dubbelrum med rumsnummer 202
(1, 5, '2025-12-24', '2025-12-25');
/*
Infogar betalmetoder i tabellen PayMethod
*/
INSERT INTO PayMethod (MethodName ) VALUES
('Kontanter'),
('Kortbetalning'),
('Swish'),
('Faktura');
/*
Infogar data i tabellen Payment
*/
INSERT INTO Payment (BookingID, PayMethodID, PaymentDate, Amount, PaymentStatus ) VALUES
( 1, 2, '2025-03-24', 990,'Paid'),
( 2, 3, '2025-03-24', 8970,'Paid'),
( 3, 3, '2025-03-22', 3990,'Paid'),
( 4, 4, '2025-02-23', 1590,'Paid'),
( 5, 1, '2025-03-28', 1590,'Paid'),
( 6, 4, '2025-12-23', 1995,'pending');
/*
Infogar data i tabellen Service
Produkterna i rummets minibar
*/
INSERT INTO Service (ServiceName, Price) VALUES
('Chips', 39),
('Carlsberg', 69),
('Jordnötter', 45);
/*
Infogar data i tabellen BookingService
*/
INSERT INTO BookingService (BookingID, ServiceID, Quantity) VALUES
( 1, 1, 1),
( 1, 2, 2);
/*
INNER JOIN för namn och rumsnummer
*/
SELECT 
Guest.FirstName, 
Guest.LastName,
Room.RoomNumber                     
FROM Booking                                                       
INNER JOIN Guest ON Booking.GuestID = Guest.GuestID
INNER JOIN Room ON Booking.RoomID = Room.RoomID;
/*
Inner join för att se information om kunder och bokningsdetaljer
*/
SELECT
Guest.FirstName,
Guest.LastName,
Guest.Phone,
Room.RoomNumber,
RoomType.RoomName,
Booking.CheckinDate,
Booking.CheckoutDate,
Payment.Amount, 
Payment.PaymentStatus,
PayMethod.MethodName
FROM Booking
INNER JOIN Guest ON Booking.GuestID = Guest.GuestID  -- FK i Booking kopplas till PK i Guest
INNER JOIN Room ON Booking.RoomID = Room.RoomID
INNER JOIN RoomType ON Room.RoomTypeID = RoomType.RoomTypeID
INNER JOIN Payment ON Booking.BookingID = Payment.BookingID
INNER JOIN PayMethod ON Payment.PaymethodID = PayMethod.PaymethodID
WHERE Booking.CheckinDate = '2025-12-24';
/*
Visar hur många bokningar varje kund har gjort
*/
SELECT Guest.FirstName, Guest.LastName,
COUNT(BookingID) AS `Qauntity of Booking`
FROM Booking
INNER JOIN Guest ON Booking.GuestID = Guest.GuestID
GROUP BY Guest.FirstName, Guest.LastName;
/*													
Provar at lägga in datum där utcheckning är mindre än incheckning
*/                                                    
INSERT INTO Booking (GuestID, RoomID, CheckinDate, CheckoutDate ) VALUES
(1, 1, '2025-03-18', '2025-03-01');  bookinglog
/*
Trigger som loggar ny bokning till Bokningsloggen
*/
DELIMITER $$

CREATE TRIGGER trg_bookinglog_insert
AFTER INSERT ON Booking
FOR EACH ROW
BEGIN
    INSERT INTO BookingLog (BookingID, Action)
    VALUES (NEW.BookingID, 'NEW');
END$$

DELIMITER ;
/*
Lägg till bokning för att testa bokningsloggen
*/
INSERT INTO Booking (GuestID, RoomID, CheckinDate, CheckoutDate ) VALUES
(3, 2, '2025-05-18', '2025-05-19');  -- Kund 3 bokar rumsnr 1
/*
/*
Lägger till en transaktion bokning för att testa bokningsloggen
*/
START TRANSACTION;  -- Börjar en transaktion
INSERT INTO Booking (GuestID, RoomID, CheckinDate, CheckoutDate ) VALUES
(4, 5, '2025-06-15', '2025-06-17');  -- Kund 4 bokar rumsnr 301

COMMIT;  -- Spara ändringen permanent. 

ROLLBACK;  -- Ångra ändringen.
/*
Trigger som loggar updateringar i Bokningsloggen
*/
DELIMITER $$

CREATE TRIGGER trg_bookinglog_update
AFTER UPDATE ON Booking
FOR EACH ROW
BEGIN
    INSERT INTO BookingLog (BookingID, Action)
    VALUES (NEW.BookingID, 'UPDATED');
END$$
booking
DELIMITER ;
/*
Ändra en kundbokning för att se ändring i kundlogg
*/
START TRANSACTION;  -- Börjar en transaktion
UPDATE Booking
SET CheckinDate = '2025-05-17' 
WHERE BookingID = 8;

COMMIT;  -- Spara ändringen permanent.

ROLLBACK;  -- Ångra ändringen.

/*
Sparad procedur för att visa ankomstlista för ett valfritt datum
*/
DELIMITER $$

CREATE PROCEDURE GetBookingsByDate (
    IN in_CheckinDate DATE
)
BEGIN
    SELECT
        Guest.FirstName,
        Guest.LastName,
        Guest.Phone,
        Room.RoomNumber,
        RoomType.RoomName,
        Booking.CheckinDate,
        Booking.CheckoutDate,
        Payment.Amount, 
        Payment.PaymentStatus,
        PayMethod.MethodName
    FROM Booking
    INNER JOIN Guest ON Booking.GuestID = Guest.GuestID
    INNER JOIN Room ON Booking.RoomID = Room.RoomID
    INNER JOIN RoomType ON Room.RoomTypeID = RoomType.RoomTypeID
    INNER JOIN Payment ON Booking.BookingID = Payment.BookingID
    INNER JOIN PayMethod ON Payment.PaymethodID = PayMethod.PaymethodID
    WHERE Booking.CheckinDate = in_CheckinDate;
END$$

DELIMITER ;
/*
Anropa proceduren ankomstlista
*/
CALL GetBookingsByDate('2025-10-07');
/*
Skapar index för ankomstlista
*/
CREATE INDEX idx_checkin_date ON Booking(CheckinDate);
/*
/* Visar Indexet
*/
SHOW INDEX FROM Booking;
/*
Skapa användare och tilldela rättigheter
Skapar användaren Anna som bara kan logga in från den lokala datorn. Lösenordet är 'carlson'
Ger Anna rätt att: Läsa (SELECT), Lägga till (INSERT), Ändra (UPDATE), Ta bort (DELETE) i
alla tabeller i databasen CarlsonHotel
(EXECUTE) Ger Anna rätt att köra procedurer och funktioner i databasen.
*/
CREATE USER 'Anna'@'localhost' IDENTIFIED BY 'carlson'; 
GRANT SELECT, INSERT, UPDATE, DELETE ON CarlsonHotel.* TO 'Anna'@'localhost';
GRANT EXECUTE ON CarlsonHotel.* TO 'Anna'@'localhost';
FLUSH PRIVILEGES;

