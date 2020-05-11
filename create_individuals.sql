CREATE PROCEDURE Add_Company(@Name varchar(255), @ContactNumber varchar(255), @ContactPerson varchar(255))
AS
BEGIN
INSERT INTO dbo.Company (Name, ContactNumber, ContactPerson) VALUES(@Name, @ContactNumber, @ContactPerson);
END;
go

CREATE PROCEDURE Add_Person(@Name varchar(255), @CompanyId varchar(255), @StudentIdNumber varchar(255))
AS
BEGIN
INSERT INTO dbo.Person (Name, CompanyId, StudentIdNumber) VALUES(@Name, @CompanyId, @StudentIdNumber);
END;
go
