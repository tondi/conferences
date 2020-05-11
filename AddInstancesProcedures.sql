CREATE PROCEDURE Add_Conference(@Name varchar(255), @StartDate date, @EndDate date,  @StudentDiscount int)
AS
BEGIN
INSERT INTO Conference (Name, StartDate, EndDate, StudentDiscount) VALUES(@Name, @StartDate, @EndDate, @StudentDiscount);
END;