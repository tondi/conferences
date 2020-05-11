CREATE OR ALTER PROCEDURE Add_Company(@Name varchar(255), @ContactNumber varchar(255), @ContactPerson varchar(255))
AS
BEGIN
INSERT INTO dbo.Company (Name, ContactNumber, ContactPerson) VALUES(@Name, @ContactNumber, @ContactPerson);
END;
go

CREATE OR ALTER PROCEDURE Add_Person(@Name varchar(255), @CompanyId int, @StudentIdNumber varchar(255))
AS
BEGIN
INSERT INTO dbo.Person (Name, CompanyId, StudentIdNumber) VALUES(@Name, @CompanyId, @StudentIdNumber);
END;
go

CREATE OR ALTER PROCEDURE Add_CompanyConferenceDayReservation(@ConferenceDayId int, @CompanyId int, @NumberOfPersons int)
AS
BEGIN
INSERT INTO CompanyConferenceDayReservation(ConferenceDayId, NumberOfPersons, CompanyId, Paid, ReservationDate) VALUES(@ConferenceDayId, @NumberOfPersons, @CompanyId, 0, GETDATE());
END;
GO

CREATE OR ALTER PROCEDURE Add_PersonConferenceDayReservation(@ConferenceDayId int, @PersonId int, @CompanyReservationId int)
AS
BEGIN
INSERT INTO PersonConferenceDayReservation(ConferenceDayId, PersonId, CompanyReservationId, Paid, ReservationDate) VALUES(@ConferenceDayId, @PersonId, @ConferenceDayId, 0, GETDATE());
END;
GO
