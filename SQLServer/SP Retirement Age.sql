-- Stored Prodcedure in SQL Server used to calculate retirement age
CREATE function [dbo].[fn_GetAge]
(@in_DOB AS datetime,@now as datetime)

returns int
as

begin
DECLARE @age int
IF cast(datepart(m,@now) as int) > cast(datepart(m,@in_DOB) as int)
SET @age = cast(datediff(yyyy,@in_DOB,@now) as int)
else
IF cast(datepart(m,@now) as int) = cast(datepart(m,@in_DOB) as int)
IF datepart(d,@now) >= datepart(d,@in_DOB)
SET @age = cast(datediff(yyyy,@in_DOB,@now) as int)
ELSE
SET @age = cast(datediff(yyyy,@in_DOB,@now) as int) -1
ELSE
SET @age = cast(datediff(yyyy,@in_DOB,@now) as int) - 1
RETURN @age

end
