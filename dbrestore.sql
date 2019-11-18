declare @date nvarchar(10) --定义日期变量
set @date =  CONVERT(NVARCHAR(10),DATEADD(DAY,-2,GETDATE()),112) --为日期变量赋当前日期
declare @path nvarchar(250) -- 定义备份路径变量
set @path = 'D:\dbbak\' --赋值
declare @db_filename nvarchar(150) --定义文件名变量
set @db_filename = @path + 'db_'+@date+'.bak' --拼字符串，形成完整的备份文件路径
--restore database AIS20190903112329 from DISK=@db_filename --执行数据库还原操作， DBNAME为你实际要备份的数据库名，
--PRINT @date
--PRINT @PATH
--PRINT @db_filename