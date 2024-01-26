CREATE TRIGGER Shippers_Trigger
ON Shippers
AFTER INSERT, UPDATE, DELETE
AS
BEGIN    
    DECLARE @ActionType NVARCHAR(50);
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
        BEGIN
            SET @ActionType = 'Updated';
        END
        ELSE
        BEGIN
            SET @ActionType = 'Inserted';
        END
    END
    ELSE
    BEGIN
        SET @ActionType = 'Deleted';
    END

    PRINT 'Performed ' + @ActionType + ' operation on Shippers table.';
END




