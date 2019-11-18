declare @date nvarchar(10) --定义日期变量
set @date = CONVERT(nvarchar(10),getdate(),112) --为日期变量赋当前日期，日期格式为 yyyymmdd 举例 20170830
declare @path nvarchar(250) -- 定义备份路径变量
set @path = 'D:\dbbak\' --赋值
declare @db_filename nvarchar(150) --定义文件名变量
set @db_filename = @path + 'db_'+@date+'.bak' --拼字符串，形成完整的备份文件路径
backup database AIS20190903112329 TO DISK=@db_filename --执行数据库备份操作，注意 DBNAME为你实际要备份的数据库名，记得改
