CREATE OR ALTER FUNCTION Get_CompanyConferenceDayReservations_Not_Registered_Attendees_Desc ()
-- Returns the stock level for the product.  
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
END;  
GO