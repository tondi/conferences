CREATE OR ALTER PROCEDURE Add_Conference(@Name varchar(255), @StartDate date, @EndDate date,  @StudentDiscount int)
AS
BEGIN
INSERT INTO Conference (Name, StartDate, EndDate, StudentDiscount) VALUES(@Name, @StartDate, @EndDate, @StudentDiscount);
END;
GO

CREATE OR ALTER  PROCEDURE Add_ConferenceDay(@ConferenceId int, @Date date ,@Capacity int, @LocationId int ,@Price decimal )
AS
BEGIN

DECLARE @count int;
SET @count = (SELECT COUNT(1) from ConferenceDay
WHERE ConferenceDay.Date = @Date AND ConferenceDay.ConferenceId = @ConferenceId AND ConferenceDay.LocationId = @LocationId)

IF @count = 0 
INSERT INTO ConferenceDay (ConferenceId, Date, Capacity, LocationId, Price) VALUES(@ConferenceId, @Date, @Capacity, @LocationId, @Price);
ELSE RAISERROR('This conference day already exists!', 15, 15); 

END;
GO

CREATE OR ALTER PROCEDURE Add_Workshop(@Name varchar(255), @ConferenceDayId int , @Capacity int , @StartDateTime datetime , @EndDateTime datetime , @DurationMinutes int , @Price decimal , @AddressId int )
AS
BEGIN
INSERT INTO Workshop (Name, ConferenceDayId, Capacity, StartDateTime, DurationMinutes, Price, AddressId) VALUES(@Name, @ConferenceDayId, @Capacity, @StartDateTime, @DurationMinutes, @Price, @AddressId);
END;
GO

CREATE OR ALTER PROCEDURE Add_Location(@City varchar(255), @Country varchar(255))
AS
BEGIN

DECLARE @count int;
SET @count = (SELECT COUNT(1) from Location
WHERE Location.City = @City AND Location.Country = @Country);

if @count = 0
INSERT INTO Location(City, Country) VALUES(@City, @Country);
ELSE RAISERROR('This location already exists!', 15, 15); 

END;
GO

CREATE OR ALTER PROCEDURE Add_Address(@LocationId int, @Street varchar(255), @BuildingNumber varchar(255),  @Room varchar(255))
AS
BEGIN
INSERT INTO Address(LocationId, Street, BuildingNumber, Room) VALUES(@LocationId, @Street, @BuildingNumber, @Room);
END;
GO

CREATE OR ALTER PROCEDURE Add_Discount(@LocationId int, @Street varchar(255), @BuildingNumber varchar(255),  @Room varchar(255))
AS
BEGIN
INSERT INTO Address(LocationId, Street, BuildingNumber, Room) VALUES(@LocationId, @Street, @BuildingNumber, @Room);
END;
GO

CREATE OR ALTER PROCEDURE Add_Discount(@ConferenceId int, @DaysToConference int, @Percentage int)
AS
BEGIN

DECLARE @count int;
SET @count = (SELECT COUNT(1) from Discount
WHERE ConferenceId = @ConferenceId AND DaysToConference = @DaysToConference);

if @count = 0
INSERT INTO Discount(ConferenceId, DaysToConference, Percentage) VALUES(@ConferenceId, @DaysToConference, @Percentage);
ELSE RAISERROR('This discount already exists!', 15, 15); 

END;
GO


