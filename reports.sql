CREATE OR ALTER FUNCTION Get_Conference_Day_Attendees(@ConferenceDayId int)
RETURNS TABLE
AS
RETURN
    SELECT PersonId, Name, CompanyId, ReservationDate, ConferenceDayId, StudentIdNumber FROM dbo.PersonConferenceDayReservation
    INNER JOIN Conferences.dbo.ConferenceDay ON dbo.PersonConferenceDayReservation.ConferenceDayId = ConferenceDay.Id
    INNER JOIN Conferences.dbo.Person ON dbo.PersonConferenceDayReservation.PersonId = Person.Id
    WHERE ConferenceDayId = @ConferenceDayId;

-- SELECT * FROM dbo.Get_Conference_Day_Attendees(1);


CREATE OR ALTER FUNCTION Get_Attendees_For_Workshop(@WorkshopId int)
RETURNS TABLE
AS
RETURN
    SELECT PersonId, Person.Name, CompanyId, ReservationDate, WorkshopId, ConferenceDayId, StudentIdNumber FROM dbo.PersonWorkshopReservation
    INNER JOIN Conferences.dbo.Workshop ON dbo.PersonWorkshopReservation.WorkshopId = Workshop.Id
    INNER JOIN Conferences.dbo.Person ON dbo.PersonWorkshopReservation.PersonId = Person.Id
    WHERE WorkshopId = @WorkshopId;

-- SELECT * FROM dbo.Get_Attendees_For_Workshop(1);

CREATE OR ALTER FUNCTION Get_Recurring_Attendees_Desc()
RETURNS TABLE
AS
RETURN
    SELECT TOP 3 Person.Name, Count(*) AS AttendedToConferences FROM Conferences.dbo.Person
    INNER JOIN dbo.PersonConferenceDayReservation ON Person.Id = PersonConferenceDayReservation.PersonId
    GROUP BY PersonId, Name
    ORDER BY COUNT(ConferenceDayId) DESC;

-- SELECT * FROM Get_Recurring_Attendees_Desc();
