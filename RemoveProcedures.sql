--For Company Type = 0, For Person Type = 1
CREATE OR ALTER PROCEDURE Remove_ConferenceDayReservation(@Id int, @Type bit)
AS
BEGIN
if @Type = 0
	DELETE FROM CompanyConferenceDayReservation WHERE Id = @id
ELSE
	DELETE FROM PersonConferenceDayReservation WHERE Id = @id
END;
GO

--For Company Type = 0, For Person Type = 1
CREATE OR ALTER PROCEDURE Remove_WorkshopReservation(@Id int, @Type bit)
AS
BEGIN
if @Type = 0
	DELETE FROM CompanyWorkshopReservation WHERE Id = @id
ELSE
	DELETE FROM PersonWorkshopReservation WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Conference(@Id int)
AS
BEGIN
DELETE FROM Conference WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_ConferenceDay(@Id int)
AS
BEGIN
DELETE FROM ConferenceDay WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Workshop(@Id int)
AS
BEGIN
DELETE FROM Workshop WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Company(@Id int)
AS
BEGIN
DELETE FROM Company WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Person(@Id int)
AS
BEGIN
DELETE FROM Person WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Location(@Id int)
AS
BEGIN
DELETE FROM Location WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Address(@Id int)
AS
BEGIN
DELETE FROM Address WHERE Id = @id
END;
GO

CREATE OR ALTER PROCEDURE Remove_Discount(@Id int)
AS
BEGIN
DELETE FROM Discount WHERE Id = @id
END;
GO