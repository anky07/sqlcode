---建利动态日期列数据表结构创建#tb 汇总 计划主表和
DECLARE @sql AS VARCHAR(1000);
DECLARE @date AS VARCHAR(10);
DECLARE @d1 AS VARCHAR(10);
DECLARE @d2 AS VARCHAR(10);
DECLARE @p3 AS VARCHAR(20);
SET @p3='WORK19030955'


  SELECT TOP 1
                    @d1 = CONVERT(VARCHAR(10), DATEADD(DAY,-1,b.FPlanStartDate), 120) --取工序汇报的最早开始日期
            FROM    dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3; 
            SELECT TOP 1
                    @d2 = CONVERT(VARCHAR(10), DATEADD(DAY,35,b.FPlanEndDate), 120) --取工序汇报的结束日期
            FROM      dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3
            --OR a.FICMONO = @p4 OR a.FICMONO = @p5
            ORDER BY b.FEndWorkDate DESC;

SET @date = @d1;
 
--SELECT  @d1 ,
--        @d2 ,
--        @date ,
--        CONVERT(VARCHAR(10), @d2, 120);
 
--CREATE TABLE ##tb ( rwno  varchar(15),gxno int ,gxid int, gxname VARCHAR(10),fname VARCHAR(10),fnumber VARCHAR(10),clas VARCHAR(10),item int );
 CREATE TABLE #tb( 任务单号  varchar(20),产品编码 VARCHAR(30),产品名称 VARCHAR(20),工序号 int , 工序名称 VARCHAR(20),类别 VARCHAR(10) );
WHILE @date <= @d2
    BEGIN
 --SET @sql = 'ALTER TABLE ##tb ADD ['+ convert(varchar(10),dateadd(day , @i , getdate()),120) +'] NVARCHAR(100) NULL'
 --execute (@sql)
 --set @i = @i + 1

        SET @sql = 'ALTER TABLE #tb ADD ['
            + CAST(DATEPART(MONTH, @date) AS VARCHAR) + '-'
            + CAST(DATEPART(DAY, @date) AS VARCHAR) + '] int NULL';   
          EXECUTE (@sql);          

        SET @date = CONVERT(VARCHAR(10), DATEADD(DAY, 1, @date), 120); 
    END;

PRINT @date;
PRINT @d2;

--SELECT  * FROM    #tb;
--DROP TABLE #tb;


GO
--插入汇报和委外数据
INSERT INTO [#tb]
           ([任务单号]
           ,[产品编码]
           ,[产品名称]
           ,[工序号]
           ,[工序名称]
           ,[类别]
           ,[3-10]
           ,[3-11]
           ,[3-12]
           ,[3-13]
           ,[3-14]
           ,[3-15]
           ,[3-16]
           ,[3-17]
           ,[3-18]
           ,[3-19]
           ,[3-20]
           ,[3-21]
           ,[3-22]
           ,[3-23]
           ,[3-24]
           ,[3-25]
           ,[3-26]
           ,[3-27]
           ,[3-28]
           ,[3-29]
           ,[3-30]
           ,[3-31]
           ,[4-1]
           ,[4-2]
           ,[4-3]
           ,[4-4]
           ,[4-5]
           ,[4-6]
           ,[4-7]
           ,[4-8]
           ,[4-9]
           ,[4-10]
           ,[4-11]
           ,[4-12]
           ,[4-13]
           ,[4-14]
           ,[4-15]
           ,[4-16]
           ,[4-17]
           ,[4-18]
           ,[4-19]
           ,[4-20]
           ,[4-21]
           ,[4-22]
           ,[4-23]
           ,[4-24]
           ,[4-25]
           ,[4-26]
           ,[4-27]
           ,[4-28]
           ,[4-29]
           ,[4-30]
           ,[5-1]
           ,[5-2]
           ,[5-3]
           ,[5-4]
           ,[5-5]
           ,[5-6])
    
EXEC dbo.ggaproc3 @p3 = 'WORK19030955' -- varchar(30)


GO
---插入计划数据
INSERT INTO [#tb]
           ([任务单号]
           ,[产品编码]
           ,[产品名称]
           ,[工序号]
           ,[工序名称]
           ,[类别]
           ,[3-10]
           ,[3-11]
           ,[3-12]
           ,[3-13]
           ,[3-14]
           ,[3-15]
           ,[3-16]
           ,[3-17]
           ,[3-18]
           ,[3-19]
           ,[3-20]
           ,[3-21]
           ,[3-22]
           ,[3-23]
           ,[3-24]
           ,[3-25]
           ,[3-26]
           ,[3-27]
           ,[3-28]
           ,[3-29]
           ,[3-30]
           ,[3-31]
           ,[4-1]
           ,[4-2]
           ,[4-3]
           ,[4-4]
           ,[4-5]
           ,[4-6]
           ,[4-7]
           ,[4-8]
           ,[4-9]
           ,[4-10]
           ,[4-11]
           ,[4-12]
           ,[4-13]
           ,[4-14]
           ,[4-15]
           ,[4-16]
           ,[4-17]
           ,[4-18]
           ,[4-19]
           ,[4-20]
           ,[4-21]
           ,[4-22]
           ,[4-23]
           ,[4-24]
           ,[4-25]
           ,[4-26]
           ,[4-27]
           ,[4-28]
           ,[4-29]
           ,[4-30]
           ,[5-1]
           ,[5-2]
           ,[5-3]
           ,[5-4]
           ,[5-5]
           ,[5-6])
    
EXEC dbo.ggaproc4 @p3 = 'WORK19030955' -- varchar(30)
GO

SELECT * FROM dbo.#tb ORDER BY 工序号,类别
GO

DROP TABLE #tb

--EXEC ggaproc4 @p3='WORK19030955'