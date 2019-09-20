---取出工序计划开始时间@p1，结束时间@p2 任务单号@p3 
ALTER PROCEDURE ggaproc4 @p3 VARCHAR(20)
AS
BEGIN
DECLARE @p1 VARCHAR(10) ,
            @p2 VARCHAR(10),
           
            @pstartdate VARCHAR(10),
            @penddate VARCHAR(10);
      
      SET @pstartdate='';
      SET @penddate=''
 SELECT TOP 1 @p1 = CONVERT(VARCHAR(10), DATEADD(DAY,-1,b.FPlanStartDate), 120) --取工序开始时间
            FROM    dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID WHERE   a.FICMONO = @p3; 
            SELECT TOP 1 @p2 = CONVERT(VARCHAR(10),DATEADD(DAY,35, b.FPlanEndDate), 120) --取工序结束开始时间
            FROM      dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID WHERE   a.FICMONO = @p3 ORDER BY b.FEndWorkDate DESC;
                    
           
             --SET @pstartdate=@pstartdate+ '['+ CAST(DATEPART(MONTH, @p1) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p1) AS VARCHAR)+']' 
             
             --SET @penddate=@penddate+ '['+ CAST(DATEPART(MONTH, @p2) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p2) AS VARCHAR)+']' 
             
              SET @pstartdate=@pstartdate+ CAST(DATEPART(MONTH, @p1) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p1) AS VARCHAR) --日期列数据
             
             SET @penddate=@penddate+ CAST(DATEPART(MONTH, @p2) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p2) AS VARCHAR)     ---结束日期列
              --SELECT @p1,@p2,@p3,@pstartdate,@penddate

---取变化的列数据，主要是日期时间
DECLARE @sql varchar(1000)
declare @m int,@n int




select @m=colid from syscolumns where object_id('ggaplantb')=id AND name=@pstartdate --查找日期列对应的其实colid id

select @n=colid from syscolumns where object_id('ggaplantb')=id AND name=@penddate   ----查找日期列对应的其实colid id


--SELECT @p1,@p2,@p3,@pstartdate,@penddate, @m,@n

select @sql = '任务单号,产品编码,产品名称,工序号,工序名称,类别,'
--从m到n
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
