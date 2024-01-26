CREATE PROCEDURE AddProductCategory
    @CategoryName NVARCHAR(100),
    @Description NVARCHAR(100),
    @ProductName NVARCHAR(100),
    @UnitPrice DECIMAL(18, 2),
    @UnitsInStock INT
AS
BEGIN    
    DECLARE @CategoryID INT;
    SELECT @CategoryID = CategoryID FROM Categories WHERE CategoryName = @CategoryName;
    IF @CategoryID IS NULL
    BEGIN
        INSERT INTO Categories (CategoryName) VALUES (@CategoryName);
        SET @CategoryID = SCOPE_IDENTITY(); 
    END

    INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock)
    VALUES (@ProductName, @CategoryID, @UnitPrice, @UnitsInStock);

    PRINT 'Product added' 
END





