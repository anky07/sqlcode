declare @date nvarchar(10) --�������ڱ���
set @date =  CONVERT(NVARCHAR(10),DATEADD(DAY,-2,GETDATE()),112) --Ϊ���ڱ�������ǰ����
declare @path nvarchar(250) -- ���屸��·������
set @path = 'D:\dbbak\' --��ֵ
declare @db_filename nvarchar(150) --�����ļ�������
set @db_filename = @path + 'db_'+@date+'.bak' --ƴ�ַ������γ������ı����ļ�·��
--restore database AIS20190903112329 from DISK=@db_filename --ִ�����ݿ⻹ԭ������ DBNAMEΪ��ʵ��Ҫ���ݵ����ݿ�����
--PRINT @date
--PRINT @PATH
--PRINT @db_filename