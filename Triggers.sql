CREATE OR ALTER TRIGGER Event_For_Conference 
ON Conference
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Conference', 
	CONCAT('id: ',i.id, ', Name: ', i.Name), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Conference', 
	CONCAT('id: ',d.id, ', Name: ', d.Name), 
	'Delete' ,
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_ConferenceDay  
ON ConferenceDay
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'ConferenceDay', 
	CONCAT('id: ',i.id, ', ConferenceId: ', i.ConferenceId), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'ConferenceDay', 
	CONCAT('id: ',d.id, ', ConferenceId: ', d.ConferenceId), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_Workshop   
ON Workshop
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Workshop', 
	CONCAT('id: ',i.id, ', Name: ', i.Name, ', ConferenceDayId: ', i.ConferenceDayId), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Workshop', 
	CONCAT('id: ',d.id, ', Name: ', d.Name, ', ConferenceDayId: ', d.ConferenceDayId), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_Company    
ON Company
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Company', 
	CONCAT('id: ',i.id, ', Name: ', i.Name), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Company', 
	CONCAT('id: ',d.id, ', Name: ', d.Name), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_Person     
ON Person
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Person', 
	CONCAT('id: ',i.id, ', Name: ', i.Name, ', CompanyId: ', i.CompanyId), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Person', 
	CONCAT('id: ',d.id, ', Name: ', d.Name, ', CompanyId: ', d.CompanyId), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_CompanyConferenceDayReservation      
ON CompanyConferenceDayReservation
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'CompanyConferenceDayReservation', 
	CONCAT('id: ',i.id, ', ConferenceDayId: ', i.ConferenceDayId, ', CompanyId: ', i.CompanyId, ', ReservationDate: ', i.ReservationDate), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'CompanyConferenceDayReservation', 
	CONCAT('id: ',d.id, ', ConferenceDayId: ', d.ConferenceDayId, ', CompanyId: ', d.CompanyId, ', ReservationDate: ', d.ReservationDate), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_PersonConferenceDayReservation       
ON PersonConferenceDayReservation
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'PersonConferenceDayReservation', 
	CONCAT('id: ',i.id, ', ConferenceDayId: ', i.ConferenceDayId, ', PersonId: ', i.PersonId, ', CompanyReservationId: ', i.CompanyReservationId, ', ReservationDate: ', i.ReservationDate), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'PersonConferenceDayReservation', 
	CONCAT('id: ',d.id, ', ConferenceDayId: ', d.ConferenceDayId, ', PersonId: ', d.PersonId, ', CompanyReservationId: ', d.CompanyReservationId, ', ReservationDate: ', d.ReservationDate), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_CompanyWorkshopReservation        
ON CompanyWorkshopReservation
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'CompanyWorkshopReservation', 
	CONCAT('id: ',i.id, ', WorkshopId: ', i.WorkshopId, ', CompanyId: ', i.CompanyId, ', ReservationDate: ', i.ReservationDate), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'CompanyWorkshopReservation', 
	CONCAT('id: ',d.id, ', WorkshopId: ', d.WorkshopId, ', CompanyId: ', d.CompanyId, ', ReservationDate: ', d.ReservationDate), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_PersonWorkshopReservation        
ON PersonWorkshopReservation
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'PersonWorkshopReservation', 
	CONCAT('id: ',i.id, ', WorkshopId: ', i.WorkshopId, ', PersonId: ', i.PersonId, ', CompanyReservationId: ', i.CompanyReservationId, ', ReservationDate: ', i.ReservationDate), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'PersonWorkshopReservation', 
	CONCAT('id: ',d.id, ', WorkshopId: ', d.WorkshopId, ', PersonId: ', d.PersonId, ', CompanyReservationId: ', d.CompanyReservationId, ', ReservationDate: ', d.ReservationDate), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_Location         
ON Location
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Location', 
	CONCAT('id: ',i.id, ', City: ', i.City, ', Country: ', i.Country), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Location', 
	CONCAT('id: ',d.id, ', City: ', d.City, ', Country: ', d.Country), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_Address          
ON Address
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Address', 
	CONCAT('id: ',i.id, ', LocationId: ', i.LocationId, ', Street: ', i.Street, ', BuildingNumber: ', i.BuildingNumber, ', Room: ', i.Room), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Address', 
	CONCAT('id: ',d.id, ', LocationId: ', d.LocationId, ', Street: ', d.Street, ', BuildingNumber: ', d.BuildingNumber, ', Room: ', d.Room), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO

CREATE OR ALTER TRIGGER Event_For_Discount           
ON Discount
AFTER INSERT, DELETE
AS
BEGIN
INSERT INTO EventHistory (TableName, Description, EventType, EventTime)
	SELECT 'Discount', 
	CONCAT('id: ',i.id, ', ConferenceId: ', i.ConferenceId, ', DaysToConference: ', i.DaysToConference, ', Percentage: ', i.Percentage), 
	'Insert',
	GETDATE()
	FROM inserted i
UNION ALL
    SELECT 'Discount', 
	CONCAT('id: ',d.id, ', ConferenceId: ', d.ConferenceId, ', DaysToConference: ', d.DaysToConference, ', Percentage: ', d.Percentage), 
	'Delete',
	GETDATE()
	FROM deleted d
END
GO