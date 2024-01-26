CREATE DATABASE TestDb;
USE TestDb;


CREATE TABLE Countries (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName NVARCHAR(25)
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY IDENTITY(1,1),
    CityName NVARCHAR(25),
    CountryID INT FOREIGN KEY REFERENCES Countries(CountryID)
);

CREATE TABLE Districts (
    DistrictID INT PRIMARY KEY IDENTITY(1,1),
    DistrictName NVARCHAR(25),
    CityID INT FOREIGN KEY REFERENCES Cities(CityID)
);

CREATE TABLE Towns (
    TownID INT PRIMARY KEY IDENTITY(1,1),
    TownName NVARCHAR(25),
    DistrictID INT FOREIGN KEY REFERENCES Districts(DistrictID)
);




CREATE PROCEDURE AddLocationData
    @CountryName NVARCHAR(25),
    @CityName NVARCHAR(25),
    @DistrictName NVARCHAR(25),
    @TownName NVARCHAR(25)
AS
BEGIN
    DECLARE @CountryID INT, @CityID INT, @DistrictID INT
    IF NOT EXISTS (SELECT * FROM Countries WHERE CountryName = @CountryName)
    BEGIN
        INSERT INTO Countries (CountryName) VALUES (@CountryName);
        SET @CountryID = SCOPE_IDENTITY();
        PRINT 'Added Country';
    END
    ELSE
    BEGIN
        SELECT @CountryID = CountryID FROM Countries WHERE CountryName = @CountryName;
        PRINT 'Country already exists';
    END


    IF NOT EXISTS (SELECT * FROM Cities WHERE CityName = @CityName)
    BEGIN
        INSERT INTO Cities (CityName, CountryID) VALUES (@CityName, @CountryID);
        SET @CityID = SCOPE_IDENTITY();
        PRINT 'Added City.';
    END
    ELSE
    BEGIN
        SELECT @CityID = CityID FROM Cities WHERE CityName = @CityName;
        PRINT 'City already exists.';
    END


    IF NOT EXISTS (SELECT * FROM Districts WHERE DistrictName = @DistrictName)
    BEGIN
        INSERT INTO Districts (DistrictName, CityID) VALUES (@DistrictName, @CityID);
        SET @DistrictID = SCOPE_IDENTITY();
        PRINT 'Districts added.';
    END
    ELSE
    BEGIN
        SELECT @DistrictID = DistrictID FROM Districts WHERE DistrictName = @DistrictName;
        PRINT 'Districts already exists.';
    END


    IF NOT EXISTS (SELECT * FROM Towns WHERE TownName = @TownName)
    BEGIN
        INSERT INTO Towns (TownName, DistrictID) VALUES (@TownName, @DistrictID);
        PRINT 'Town added.';
    END
    ELSE
    BEGIN
        PRINT 'Town already exists.';
    END
END

EXEC [dbo].[AddLocationData] 'Turkiye','Antalya','tesy','test'

SELECT CountryName , CityName ,DistrictName , TownName FROM Countries co
FULL JOIN Cities ci
ON co.CountryID = ci.CountryID
FULL JOIN Districts d
ON ci.CityID = d.CityID
FULL JOIN Towns t
ON d.DistrictID = t.DistrictID


