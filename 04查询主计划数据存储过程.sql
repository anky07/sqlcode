---ȡ������ƻ���ʼʱ��@p1������ʱ��@p2 ���񵥺�@p3 
ALTER PROCEDURE ggaproc4 @p3 VARCHAR(20)
AS
BEGIN
DECLARE @p1 VARCHAR(10) ,
            @p2 VARCHAR(10),
           
            @pstartdate VARCHAR(10),
            @penddate VARCHAR(10);
      
      SET @pstartdate='';
      SET @penddate=''
 SELECT TOP 1 @p1 = CONVERT(VARCHAR(10), DATEADD(DAY,-1,b.FPlanStartDate), 120) --ȡ����ʼʱ��
            FROM    dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID WHERE   a.FICMONO = @p3; 
            SELECT TOP 1 @p2 = CONVERT(VARCHAR(10),DATEADD(DAY,35, b.FPlanEndDate), 120) --ȡ���������ʼʱ��
            FROM      dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID WHERE   a.FICMONO = @p3 ORDER BY b.FEndWorkDate DESC;
                    
           
             --SET @pstartdate=@pstartdate+ '['+ CAST(DATEPART(MONTH, @p1) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p1) AS VARCHAR)+']' 
             
             --SET @penddate=@penddate+ '['+ CAST(DATEPART(MONTH, @p2) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p2) AS VARCHAR)+']' 
             
              SET @pstartdate=@pstartdate+ CAST(DATEPART(MONTH, @p1) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p1) AS VARCHAR) --����������
             
             SET @penddate=@penddate+ CAST(DATEPART(MONTH, @p2) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p2) AS VARCHAR)     ---����������
              --SELECT @p1,@p2,@p3,@pstartdate,@penddate

---ȡ�仯�������ݣ���Ҫ������ʱ��
DECLARE @sql varchar(1000)
declare @m int,@n int




select @m=colid from syscolumns where object_id('ggaplantb')=id AND name=@pstartdate --���������ж�Ӧ����ʵcolid id

select @n=colid from syscolumns where object_id('ggaplantb')=id AND name=@penddate   ----���������ж�Ӧ����ʵcolid id


--SELECT @p1,@p2,@p3,@pstartdate,@penddate, @m,@n

select @sql = '���񵥺�,��Ʒ����,��Ʒ����,�����,��������,���,'
--��m��n
select @sql=@sql+'['+name+']'+',' from syscolumns where object_id('ggaplantb')=id and colid between @m and @n order by colid
 --SELECT @sql
select @sql=left(@sql,len(@sql)-1)
 
select @sql='select 
'+@sql+' from ggaplantb'
 --PRINT @sql
exec(@sql) 
END
--SELECT * FROM ggaplantb


--EXEC dbo.ggaproc4 @p3 = 'WORK19030955' -- varchar(20)
