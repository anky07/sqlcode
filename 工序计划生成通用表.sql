use

---��������ƻ��ֹ��ƻ�����ggaplantb
DECLARE @sql AS VARCHAR(1000);
DECLARE @date AS VARCHAR(10);
DECLARE @d1 AS DATETIME; 
DECLARE @d2 AS DATETIME; 
--SET @d2 = DATEADD(DAY, 120, GETDATE());

--SET @d1 = DATEADD(DAY, 1, GETDATE());
SET @d1 ='2019-03-01'

SET @d2 = '2019-12-31'

SET @date = CONVERT(VARCHAR(10), @d1, 120);
 
--SELECT  @d1 ,
--        @d2 ,
--        @date ,
--        CONVERT(VARCHAR(10), @d2, 120);
 
--CREATE TABLE #tb ( rwno  varchar(15),gxno int ,gxid int, gxname VARCHAR(10),fname VARCHAR(10),fnumber VARCHAR(10),clas VARCHAR(10),item int );
 --CREATE TABLE #tb( ���񵥺�  varchar(15),����� int ,����id int, �������� VARCHAR(20),��Ʒ���� VARCHAR(20),��Ʒ���� VARCHAR(20),��� VARCHAR(10),����id int );
 
  CREATE TABLE #tb( ���񵥺�  varchar(20),����� int , �������� VARCHAR(20),��Ʒ���� VARCHAR(30),��Ʒ���� VARCHAR(20),��� VARCHAR(10) );
WHILE @date <= CONVERT(VARCHAR(10), @d2, 120)
    BEGIN
 --SET @sql = 'ALTER TABLE #tb ADD ['+ convert(varchar(10),dateadd(day , @i , getdate()),120) +'] NVARCHAR(100) NULL'
 --execute (@sql)
 --set @i = @i + 1

        SET @sql = 'ALTER TABLE #tb ADD ['
            + CAST(DATEPART(MONTH, @date) AS VARCHAR) + '-'
            + CAST(DATEPART(DAY, @date) AS VARCHAR) + '] varchar(10) NULL';   
          EXECUTE (@sql);          

        SET @date = CONVERT(VARCHAR(10), DATEADD(DAY, 1, @date), 120); 
    END;

PRINT @date;
PRINT @d2;

SELECT  *
FROM    #tb;
--DROP TABLE #tb;


---SELECT * FROM tb1

----------    





    