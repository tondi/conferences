CREATE OR ALTER PROCEDURE PayFor_CompanyConferenceDayReservation(@ReservationId int)
AS
BEGIN
DECLARE @count int;
SET @count = (SELECT COUNT(1) from CompanyConferenceDayReservation
WHERE Id = @ReservationId)

if @count > 0
UPDATE CompanyConferenceDayReservation
SET Paid = 1
WHERE Id = @ReservationId
ELSE RAISERROR('This is no reservation with this id!', 15, 15); 
END;
GO

CREATE OR ALTER PROCEDURE PayFor_PersonConferenceDayReservation(@ReservationId int)
AS
BEGIN
DECLARE @count int;
SET @count = (SELECT COUNT(1) from PersonConferenceDayReservation
WHERE Id = @ReservationId)

if @count > 0
UPDATE PersonConferenceDayReservation
SET Paid = 1
WHERE Id = @ReservationId
ELSE RAISERROR('This is no reservation with this id!', 15, 15); 
END;
GO

CREATE OR ALTER PROCEDURE PayFor_CompanyWorkshopReservation(@ReservationId int)
AS
BEGIN
DECLARE @count int;
SET @count = (SELECT COUNT(1) from CompanyWorkshopReservation
WHERE Id = @ReservationId)

if @count > 0
UPDATE CompanyWorkshopReservation
SET Paid = 1
WHERE Id = @ReservationId
ELSE RAISERROR('This is no reservation with this id!', 15, 15); 
END;
GO

CREATE OR ALTER PROCEDURE PayFor_PersonWorkshopReservation(@ReservationId int)
AS
BEGIN
DECLARE @count int;
SET @count = (SELECT COUNT(1) from PersonWorkshopReservation
WHERE Id = @ReservationId)

if @count > 0
UPDATE PersonWorkshopReservation
SET Paid = 1
WHERE Id = @ReservationId
ELSE RAISERROR('This is no reservation with this id!', 15, 15); 
END;
GO

CREATE OR ALTER FUNCTION Is_CompanyConferenceDayReservation_Paid(@ReservationId int)  
RETURNS bit   
AS  
BEGIN  
    RETURN (SELECT TOP 1 Paid FROM CompanyConferenceDayReservation 
									 WHERE Id = @ReservationId)
END 
GO

CREATE OR ALTER FUNCTION Is_PersonConferenceDayReservation_Paid(@ReservationId int)  
RETURNS bit   
AS  
BEGIN  
    RETURN (SELECT TOP 1 Paid FROM PersonConferenceDayReservation 
									 WHERE Id = @ReservationId)  
END 
GO

CREATE OR ALTER FUNCTION Is_CompanyWorkshopReservation_Paid(@ReservationId int)  
RETURNS bit   
AS  
BEGIN  
    RETURN (SELECT TOP 1 Paid FROM CompanyWorkshopReservation 
									 WHERE Id = @ReservationId)
END 
GO

CREATE OR ALTER FUNCTION Is_PersonWorkshopReservation_Paid(@ReservationId int)  
RETURNS bit   
AS  
BEGIN  
	RETURN (SELECT TOP 1 Paid FROM PersonWorkshopReservation 
									 WHERE Id = @ReservationId) 
END 
GO