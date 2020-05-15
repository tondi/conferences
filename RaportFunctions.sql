CREATE OR ALTER FUNCTION Get_Conference_Day_Attendees(@ConferenceDayId int)
RETURNS TABLE
AS
RETURN
    SELECT PersonId, Name, CompanyId, ReservationDate, ConferenceDayId, StudentIdNumber FROM dbo.PersonConferenceDayReservation
    INNER JOIN Conferences.dbo.ConferenceDay ON dbo.PersonConferenceDayReservation.ConferenceDayId = ConferenceDay.Id
    INNER JOIN Conferences.dbo.Person ON dbo.PersonConferenceDayReservation.PersonId = Person.Id
    WHERE ConferenceDayId = @ConferenceDayId;
GO

-- SELECT * FROM dbo.Get_Conference_Day_Attendees(1);


CREATE OR ALTER FUNCTION Get_Attendees_For_Workshop(@WorkshopId int)
RETURNS TABLE
AS
RETURN
    SELECT PersonId, Person.Name, CompanyId, ReservationDate, WorkshopId, ConferenceDayId, StudentIdNumber FROM dbo.PersonWorkshopReservation
    INNER JOIN Conferences.dbo.Workshop ON dbo.PersonWorkshopReservation.WorkshopId = Workshop.Id
    INNER JOIN Conferences.dbo.Person ON dbo.PersonWorkshopReservation.PersonId = Person.Id
    WHERE WorkshopId = @WorkshopId;
GO

-- SELECT * FROM dbo.Get_Attendees_For_Workshop(1);

CREATE OR ALTER FUNCTION Get_Recurring_Attendees_Desc()
RETURNS TABLE
AS
RETURN
    SELECT TOP 3 Person.Name, Count(*) AS AttendedToConferences FROM Conferences.dbo.Person
    INNER JOIN dbo.PersonConferenceDayReservation ON Person.Id = PersonConferenceDayReservation.PersonId
    GROUP BY PersonId, Name
    ORDER BY COUNT(ConferenceDayId) DESC;
GO

-- SELECT * FROM Get_Recurring_Attendees_Desc();

CREATE OR ALTER FUNCTION Get_Discounts_For_Conference(@ConferenceId int)
RETURNS TABLE
AS
RETURN
    SELECT * FROM Discount WHERE Discount.ConferenceId = @ConferenceId
GO

-- SELECT * FROM Get_Discounts_For_Conference();

CREATE OR ALTER FUNCTION Get_EventHistory_For_Table(@TableName varchar(255))
RETURNS TABLE
AS
RETURN
    SELECT * FROM EventHistory WHERE TableName = @TableName
GO

-- SELECT * FROM Get_EventHistory_For_Table('Conference');

CREATE OR ALTER FUNCTION Get_CompanyConferenceDayReservations_Not_Registered_Attendees_Desc ()
RETURNS @resultTable TABLE
(
CompanyName varchar(255),
ContactNumber varchar(255),
ContactPerson varchar(255),
NumbersOfReservations int,
DaysToConference int
) 
AS  
BEGIN  

INSERT  @resultTable SELECT Company.Name, Company.ContactNumber, Company.ContactPerson, CompanyConferenceDayReservation.NumberOfPersons, DATEDIFF(DAY,GETDATE(), ConferenceDay.Date) FROM Company 
INNER JOIN CompanyConferenceDayReservation ON Company.Id = CompanyConferenceDayReservation.CompanyId
INNER JOIN ConferenceDay ON CompanyConferenceDayReservation.ConferenceDayId = ConferenceDay.Id
WHERE DATEDIFF(DAY,GETDATE(), ConferenceDay.Date) < 14 AND DATEDIFF(DAY,GETDATE(), ConferenceDay.Date) >=0
AND (SELECT COUNT(*) FROM PersonConferenceDayReservation INNER JOIN CompanyConferenceDayReservation ON PersonConferenceDayReservation.CompanyReservationId = CompanyConferenceDayReservation.Id 
	AND PersonConferenceDayReservation.ConferenceDayId = ConferenceDay.Id) < CompanyConferenceDayReservation.NumberOfPersons
ORDER BY ConferenceDay.Date;

RETURN
END  
GO

CREATE OR ALTER FUNCTION Get_Capacity_Left_For_ConferenceDay(@ConferenceDayId int)  
RETURNS int   
AS  
BEGIN  
    DECLARE @ret int;  

	SET @ret = (SELECT TOP 1 Capacity FROM ConferenceDay WHERE ConferenceDay.Id = @ConferenceDayId) 
	- (SELECT SUM(CompanyConferenceDayReservation.NumberOfPersons) FROM CompanyConferenceDayReservation)
	- (SELECT COUNT(*) FROM PersonConferenceDayReservation WHERE PersonConferenceDayReservation.CompanyReservationId = NULL);

    RETURN @ret;  
END 
GO

CREATE OR ALTER FUNCTION Get_Capacity_Left_For_Workshop(@WorkshopId int)  
RETURNS int   
AS  
BEGIN  
    DECLARE @ret int;  

	SET @ret = (SELECT TOP 1 Capacity FROM Workshop WHERE Workshop.Id = @WorkshopId) 
	- (SELECT SUM(CompanyWorkshopReservation.NumberOfPersons) FROM CompanyWorkshopReservation)
	- (SELECT COUNT(*) FROM PersonWorkshopReservation WHERE PersonWorkshopReservation.CompanyReservationId = NULL);

    RETURN @ret;  
END 
GO

CREATE OR ALTER FUNCTION Get_ConferenceDay_Price(@ConferenceDayId int, @IsStuden bit, @RequestedDate date)  
RETURNS int   
AS  
BEGIN  
    DECLARE @conferenceId int;
	SET @conferenceId = (SELECT TOP 1 ConferenceId FROM ConferenceDay WHERE ConferenceDay.Id = @ConferenceDayId) 
	
    DECLARE @conferenceStartDate date;
	SET @conferenceStartDate = (SELECT TOP 1 StartDate FROM Conference WHERE Conference.Id = @conferenceId) 

    DECLARE @price int;
	SET @price = (SELECT TOP 1 Price FROM ConferenceDay WHERE ConferenceDay.Id = @ConferenceDayId) 

    DECLARE @studentDiscount int;
	SET @studentDiscount = (SELECT TOP 1 StudentDiscount FROM Conference WHERE Conference.Id = @conferenceId) 

	DECLARE @discount int;
	SET @discount = (SELECT TOP 1 Percentage FROM Discount WHERE Discount.ConferenceId = @conferenceId AND Discount.DaysToConference >= DATEDIFF(DAY,@RequestedDate, @conferenceStartDate)
															ORDER BY DaysToConference)


	DECLARE @result int;
	SET @result = @price

	if @IsStuden > 0
	SET @result -= @price * @studentDiscount /100

	IF @discount IS NOT NULL
	SET @result -= @price * @discount /100

    RETURN @result;  
END 
GO
