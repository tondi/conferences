CREATE TABLE [Company] (
	Id int NOT NULL IDENTITY,
	Name varchar(255) NOT NULL,
	ContactNumber varchar(255) NOT NULL,
	ContactPerson varchar(255) NOT NULL,
  CONSTRAINT [PK_COMPANY] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Workshop] (
	Id int NOT NULL IDENTITY,
	Name varchar(255) NOT NULL,
	ConferenceDayId int NOT NULL,
	Capacity int NOT NULL,
	StartDateTime datetime NOT NULL,
	DurationMinutes int NOT NULL,
	Price decimal NOT NULL,
	AddressId int NOT NULL,
  CONSTRAINT [PK_WORKSHOP] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Conference] (
	Id int NOT NULL IDENTITY,
	Name varchar(255) NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	StudentDiscount int NOT NULL,
  CONSTRAINT [PK_CONFERENCE] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [ConferenceDay] (
	Id int NOT NULL IDENTITY,
	ConferenceId int NOT NULL,
	Date date NOT NULL,
	Capacity int NOT NULL,
	LocationId int NOT NULL,
	Price decimal NOT NULL,
  CONSTRAINT [PK_CONFERENCEDAY] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Person] (
	Id int NOT NULL IDENTITY,
	Name varchar(255) NOT NULL,
	CompanyId int,
	StudentIdNumber varchar(255),
  CONSTRAINT [PK_PERSON] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [CompanyConferenceDayReservation] (
	Id int NOT NULL IDENTITY,
	ConferenceDayId int NOT NULL,
	NumberOfPersons int NOT NULL,
	CompanyId int NOT NULL,
	Paid bit NOT NULL,
	ReservationDate date NOT NULL,
  CONSTRAINT [PK_COMPANYCONFERENCEDAYRESERVATION] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PersonConferenceDayReservation] (
	Id int NOT NULL IDENTITY,
	CompanyReservationId int,
	PersonId int NOT NULL,
	ConferenceDayId int NOT NULL,
	Paid bit NOT NULL,
	ReservationDate date NOT NULL,
  CONSTRAINT [PK_PERSONCONFERENCEDAYRESERVATION] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [CompanyWorkshopReservation] (
	Id int NOT NULL IDENTITY,
	WorkshopId int NOT NULL,
	CompanyId int NOT NULL,
	NumberOfPersons int NOT NULL,
	Paid bit NOT NULL,
	ReservationDate date NOT NULL,
  CONSTRAINT [PK_COMPANYWORKSHOPRESERVATION] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PersonWorkshopReservation] (
	Id int NOT NULL IDENTITY,
	WorkshopId int NOT NULL,
	PersonId int NOT NULL,
	CompanyReservationId int NOT NULL,
	Paid bit NOT NULL,
	ReservationDate date NOT NULL,
  CONSTRAINT [PK_PERSONWORKSHOPRESERVATION] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Location] (
	Id int NOT NULL IDENTITY,
	City varchar(255) NOT NULL,
	Country varchar(255) NOT NULL,
  CONSTRAINT [PK_LOCATION] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Address] (
	Id int NOT NULL IDENTITY,
	LocationId int NOT NULL,
	Street varchar(255) NOT NULL,
	BuildingNumber varchar(255) NOT NULL,
	Room varchar(255) NOT NULL,
  CONSTRAINT [PK_ADDRESS] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Discount] (
	Id int NOT NULL IDENTITY,
	ConferenceId int NOT NULL,
	DaysToConference int NOT NULL,
	Percentage int NOT NULL
)
GO
CREATE TABLE [EventHistory] (
	Id int NOT NULL IDENTITY,
	TableName varchar(255) NOT NULL,
	Description varchar(255) NOT NULL,
	EventType varchar(255) NOT NULL,
	EventTime dateTime NOT NULL,
  CONSTRAINT [PK_EVENTHISTORY] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

ALTER TABLE [Workshop] WITH CHECK ADD CONSTRAINT [Workshop_fk0] FOREIGN KEY ([ConferenceDayId]) REFERENCES [ConferenceDay]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [Workshop] CHECK CONSTRAINT [Workshop_fk0]
GO
ALTER TABLE [Workshop] WITH CHECK ADD CONSTRAINT [Workshop_fk1] FOREIGN KEY ([AddressId]) REFERENCES [Address]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [Workshop] CHECK CONSTRAINT [Workshop_fk1]
GO


ALTER TABLE [ConferenceDay] WITH CHECK ADD CONSTRAINT [ConferenceDay_fk0] FOREIGN KEY ([ConferenceId]) REFERENCES [Conference]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [ConferenceDay] CHECK CONSTRAINT [ConferenceDay_fk0]
GO
ALTER TABLE [ConferenceDay] WITH CHECK ADD CONSTRAINT [ConferenceDay_fk1] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [ConferenceDay] CHECK CONSTRAINT [ConferenceDay_fk1]
GO

ALTER TABLE [Person] WITH CHECK ADD CONSTRAINT [Person_fk0] FOREIGN KEY ([CompanyId]) REFERENCES [Company]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [Person] CHECK CONSTRAINT [Person_fk0]
GO

ALTER TABLE [CompanyConferenceDayReservation] WITH CHECK ADD CONSTRAINT [CompanyConferenceDayReservation_fk0] FOREIGN KEY ([ConferenceDayId]) REFERENCES [ConferenceDay]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [CompanyConferenceDayReservation] CHECK CONSTRAINT [CompanyConferenceDayReservation_fk0]
GO
ALTER TABLE [CompanyConferenceDayReservation] WITH CHECK ADD CONSTRAINT [CompanyConferenceDayReservation_fk1] FOREIGN KEY ([CompanyId]) REFERENCES [Company]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [CompanyConferenceDayReservation] CHECK CONSTRAINT [CompanyConferenceDayReservation_fk1]
GO

ALTER TABLE [PersonConferenceDayReservation] WITH CHECK ADD CONSTRAINT [PersonConferenceDayReservation_fk0] FOREIGN KEY ([CompanyReservationId]) REFERENCES [CompanyConferenceDayReservation]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [PersonConferenceDayReservation] CHECK CONSTRAINT [PersonConferenceDayReservation_fk0]
GO
ALTER TABLE [PersonConferenceDayReservation] WITH CHECK ADD CONSTRAINT [PersonConferenceDayReservation_fk1] FOREIGN KEY ([PersonId]) REFERENCES [Person]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [PersonConferenceDayReservation] CHECK CONSTRAINT [PersonConferenceDayReservation_fk1]
GO
ALTER TABLE [PersonConferenceDayReservation] WITH CHECK ADD CONSTRAINT [PersonConferenceDayReservation_fk2] FOREIGN KEY ([ConferenceDayId]) REFERENCES [ConferenceDay]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [PersonConferenceDayReservation] CHECK CONSTRAINT [PersonConferenceDayReservation_fk2]
GO

ALTER TABLE [CompanyWorkshopReservation] WITH CHECK ADD CONSTRAINT [CompanyWorkshopReservation_fk0] FOREIGN KEY ([WorkshopId]) REFERENCES [Workshop]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [CompanyWorkshopReservation] CHECK CONSTRAINT [CompanyWorkshopReservation_fk0]
GO
ALTER TABLE [CompanyWorkshopReservation] WITH CHECK ADD CONSTRAINT [CompanyWorkshopReservation_fk1] FOREIGN KEY ([CompanyId]) REFERENCES [Company]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [CompanyWorkshopReservation] CHECK CONSTRAINT [CompanyWorkshopReservation_fk1]
GO

ALTER TABLE [PersonWorkshopReservation] WITH CHECK ADD CONSTRAINT [PersonWorkshopReservation_fk0] FOREIGN KEY ([WorkshopId]) REFERENCES [Workshop]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [PersonWorkshopReservation] CHECK CONSTRAINT [PersonWorkshopReservation_fk0]
GO
ALTER TABLE [PersonWorkshopReservation] WITH CHECK ADD CONSTRAINT [PersonWorkshopReservation_fk1] FOREIGN KEY ([PersonId]) REFERENCES [Person]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [PersonWorkshopReservation] CHECK CONSTRAINT [PersonWorkshopReservation_fk1]
GO
ALTER TABLE [PersonWorkshopReservation] WITH CHECK ADD CONSTRAINT [PersonWorkshopReservation_fk2] FOREIGN KEY ([CompanyReservationId]) REFERENCES [CompanyWorkshopReservation]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [PersonWorkshopReservation] CHECK CONSTRAINT [PersonWorkshopReservation_fk2]
GO


ALTER TABLE [Address] WITH CHECK ADD CONSTRAINT [Address_fk0] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [Address] CHECK CONSTRAINT [Address_fk0]
GO

ALTER TABLE [Discount] WITH CHECK ADD CONSTRAINT [Discount_fk0] FOREIGN KEY ([ConferenceId]) REFERENCES [Conference]([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [Discount] CHECK CONSTRAINT [Discount_fk0]
GO

