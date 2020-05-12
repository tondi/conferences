CREATE OR ALTER FUNCTION Get_Conference_Day_Attendees(@ConferenceDayId int)
RETURNS TABLE
AS
RETURN
    SELECT [PersonId], [Name], [ReservationDate], [ConferenceDayId], [CompanyId], [StudentIdNumber] FROM dbo.PersonConferenceDayReservation
    INNER JOIN Conferences.dbo.ConferenceDay ON dbo.PersonConferenceDayReservation.ConferenceDayId = ConferenceDay.Id
    INNER JOIN Conferences.dbo.Person ON dbo.PersonConferenceDayReservation.PersonId = Person.Id
    WHERE ConferenceDayId = @ConferenceDayId;

SELECT * FROM dbo.Get_Conference_Day_Attendees(1);
