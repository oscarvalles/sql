-- This function removes all non-printable characters from a string.
CREATE function [dbo].[RemovNonPrintChar] (
 @strIn as varchar(1000)
)
returns varchar(1000)
as
begin
 declare @prnt as int
 set @prnt = patindex('%[^ -~0-9A-Z]%', @strIn COLLATE LATIN1_GENERAL_BIN)
 while @prnt > 0 begin
  set @strIn = replace(@strIn COLLATE LATIN1_GENERAL_BIN, substring(@strIn, @prnt, 1), '')
  set @prnt = patindex('%[^ -~0-9A-Z]%', @strIn COLLATE LATIN1_GENERAL_BIN)
 end
 return @strIn
end
