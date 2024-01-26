CREATE PROCEDURE AddCategory
    @categoryName NVARCHAR(100)
AS
BEGIN  

    IF NOT EXISTS (SELECT * FROM Categories WHERE CategoryName = @categoryName)
    BEGIN
        INSERT INTO Categories (CategoryName) VALUES (@categoryName)
        PRINT 'Category added.'
    END
    ELSE
    BEGIN
        PRINT 'This Category Alreay exists'
    END
END
GO


