USE [AIS20171222145617]
GO
/****** Object:  StoredProcedure [dbo].[ggatemp4]    Script Date: 07/24/2019 14:34:10 ******/
---���ܹ���㱨�ͼƻ������ݽ�������ڷ���չʾ
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ggatemp4] @p3 VARCHAR(30)
AS --    SELECT TOP 1 @p1=CONVERT(VARCHAR(10), b.FEndWorkDate, 120)  FROM dbo.SHProcRpt b INNER JOIN SHProcRptMain a ON a.FInterID = b.FinterID WHERE a.FICMONO='WORK19041165' 
--    SELECT TOP 1 @p2=CONVERT(VARCHAR(10), b.FEndWorkDate, 120)  FROM dbo.SHProcRpt b INNER JOIN SHProcRptMain a ON a.FInterID = b.FinterID WHERE a.FICMONO='WORK19041165' ORDER BY b.FEndWorkDate desc
--select * FROM dbo.SHProcRpt b INNER JOIN SHProcRptMain a ON a.FInterID = b.FinterID WHERE a.FICMONO='WORK19041165'
--PRINT @p1 
--PRINT @p2


     BEGIN
        DECLARE @p1 VARCHAR(10) ,
            @p2 VARCHAR(10);
        BEGIN
            SELECT TOP 1
                    @p1 = CONVERT(VARCHAR(10), b.FPlanStartDate, 120) --ȡ����㱨�����翪ʼ����
            FROM    dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3; 
            SELECT TOP 1
                    @p2 = CONVERT(VARCHAR(10), b.FPlanEndDate, 120) --ȡ����㱨�Ľ�������
            FROM      dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3
            ORDER BY b.FEndWorkDate DESC;
            SELECT  *
            INTO    #ggatemp3
            FROM    (  SELECT    'P�ƻ�' AS clas ,
            a.FICMONO AS rwno ,
            b.FOperID AS col2 ,
            b.FOperSN AS col1 ,
            d.FName AS gxname ,
            b.FItemID AS item ,
            ( SELECT    FNumber
              FROM      dbo.t_Item
              WHERE     FItemID = a.FItemID
            ) AS FNumber ,
            ( SELECT    FName
              FROM      dbo.t_Item
              WHERE     FItemID = a.FItemID
            ) AS Fname ,
            b.FWorkBillNO AS ���� ,
            0 AS num ,
            CONVERT(VARCHAR(10), b.FPlanStartDate, 120) AS date
  FROM      SHWorkBill a
            INNER JOIN dbo.SHWorkBillEntry b ON a.FInterID = b.FinterID
            --INNER JOIN dbo.SHWorkBillEntry c ON a.FWBNO = c.FWorkBillNO
            INNER JOIN t_SubMessage d ON d.FInterID = b.FOperID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
  WHERE     a.FICMONO = @p3
            
            UNION all
            
            
            SELECT    'S����' AS clas ,
                                a.FICMONO AS rwno ,
                                a.FOperID AS col2 ,
                                c.FOperSN AS col1 ,
                                d.FName AS gxname ,
                                a.FItemID AS item ,
                                ( SELECT    FNumber
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS FNumber ,
                                ( SELECT    FName
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS Fname ,
                                a.FWBNO AS ���� ,
                                b.FOperAuxQtyPass AS num ,
                                CONVERT(VARCHAR(10), b.FEndWorkDate, 120) AS date
                      FROM      SHProcRptMain a
                                INNER JOIN dbo.SHProcRpt b ON a.FInterID = b.FinterID
                                INNER JOIN dbo.SHWorkBillEntry c ON a.FWBNO = c.FWorkBillNO
                                INNER JOIN t_SubMessage d ON d.FInterID = a.FOperID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
                      WHERE     a.FICMONO = @p3
                      UNION ALL
                      SELECT    'Qת��' AS clas ,
                                a.FICMOBillNo AS rwno ,---ί��ת��
                                a.FOperID AS col2 ,
                                a.FOperSN AS col1 ,
                                ( SELECT    FName
                                  FROM      t_SubMessage
                                  WHERE     FInterID = a.FOperID
                                ) AS gxname ,
                                a.FItemID AS item ,
                                ( SELECT    FNumber
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS FNumber ,
                                ( SELECT    FName
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS Fname ,
                                b.FWorkBillNO AS ���� ,
                                a.FOperTranOutQty AS num ,
                                CONVERT(VARCHAR(10), a.FFactTranOutDate, 120) AS date
                      FROM      ICShop_SubcOutEntry a
                                INNER JOIN dbo.SHWorkBillEntry b ON b.FWBInterID = a.FWBInterID
                                INNER JOIN ICShop_SubcOut d ON d.FInterID = a.FInterID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
                      WHERE     a.FICMOBillNo = @p3
                      UNION ALL
                      SELECT    'R����' AS clas ,
                                a.FICMOBillNo AS rwno ,
                                a.FOperID AS col2 ,
                                a.FOperSN AS col1 ,
                                ( SELECT    FName
                                  FROM      t_SubMessage
                                  WHERE     FInterID = a.FOperID
                                ) AS gxname ,
                                a.FItemID AS item ,
                                ( SELECT    FNumber
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS FNumber ,
                                ( SELECT    FName
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS Fname ,
                                b.FWorkBillNO AS ���� ,
                                a.FBasePassQty AS num ,
                                CONVERT(VARCHAR(10), d.FBillDate, 120) AS date
                      FROM      ICShop_SubcInEntry a
                                INNER JOIN dbo.SHWorkBillEntry b ON b.FWBInterID = a.FWBInterID
                                INNER JOIN ICShop_SubcIn d ON d.FInterID = a.FInterID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
                      WHERE     a.FICMOBillNo = @p3
                    
                   --SELECT  * from ICShop_SubcOut  where  FBillNo='WWZC1567'

                   --SELECT * FROM dbo.ICShop_SubcOutEntry WHERE FInterID=2566
                    ) t;
        END;

--DECLARE @start_date varchar(10) = @p1,
--        @end_date   varchar(10) = @p2;
 
        DECLARE @date VARCHAR(10) ,
            @sql VARCHAR(MAX) = '' ,
            @sql1 VARCHAR(8000) ,
            @sql2 VARCHAR(8000);
 
        SET @date = convert(varchar(10),DATEADD(DAY,-1,@p1),120)
 
        SET @sql1 = 'select case when rownum = 1 then rwno else '''' end as ���񵥺�,
                    case when rownum = 1 then col1 else '''' end as �����,
                    case when rownum = 1 then col2 else '''' end as ����id,
                    case when rownum = 1 then gxname else '''' end as ��������,
                     case when rownum = 1 then fname else '''' end as ��Ʒ����,
                     case when rownum = 1 then FNumber else '''' end as ��Ʒ����,
                     case when rownum = 1 then clas else '''' end as ���,
                    item as ����id';
 
        SET @sql2 = 'select rwno, col1,col2,gxname,FNumber,fname,item,clas,row_number() over(partition by col1,col2,clas 
                                                         order by clas ,item) as rownum';
         
 
        WHILE @date <= convert(varchar(10),DATEADD(DAY,35,@p2),120)
            BEGIN
                SET @sql1 = @sql1 + ',v_' + REPLACE(RIGHT(@date, 5), '-', '')
                    + ' as ''' +'['+ CAST(DATEPART(MONTH, @date) AS VARCHAR) + '/'
                    + CAST(DATEPART(DAY, @date) AS VARCHAR)+']' + '''';                              
                SET @sql2 = @sql2 + ',SUM(case when date =''' + @date
                    + ''' then num else 0 end) as v_' + REPLACE(RIGHT(@date, 5),
                                                              '-', '');
     
                SET @date = CONVERT(VARCHAR(10), DATEADD(DAY, 1, @date), 120);
            END;
 
 
        SET @sql = @sql1 + ' from (' + @sql2
            + ' from #ggatemp3
                                 group by col1,col2,gxname,fnumber,fname,item,clas,rwno'
            + ') v';
  
--�����Ķ�̬sql���                  
--SELECT @sql
 
 
        EXEC(@sql);

     --DROP TABLE #ggatemp3;
   
    END
    --SELECT @sql

--exec ggatemp4 @p3='WORK19041165'

GO

---������̬���������ݱ�ṹ ����tb
DECLARE @sql AS VARCHAR(1000);
DECLARE @date AS VARCHAR(10);
DECLARE @d1 AS DATETIME; 
DECLARE @d2 AS DATETIME; 
--SET @d2 = DATEADD(DAY, 120, GETDATE());

--SET @d1 = DATEADD(DAY, 1, GETDATE());
SET @d2 = '2019-07-19'

SET @d1 ='2019-05-23'

SET @date = CONVERT(VARCHAR(10), @d1, 120);
 
--SELECT  @d1 ,
--        @d2 ,
--        @date ,
--        CONVERT(VARCHAR(10), @d2, 120);
 
--CREATE TABLE #tb ( rwno  varchar(15),gxno int ,gxid int, gxname VARCHAR(10),fname VARCHAR(10),fnumber VARCHAR(10),clas VARCHAR(10),item int );
 CREATE TABLE tb( ���񵥺�  varchar(20),����� int ,����id int, �������� VARCHAR(20),��Ʒ���� VARCHAR(20),��Ʒ���� VARCHAR(30),��� VARCHAR(10),����id int );
WHILE @date <= CONVERT(VARCHAR(10), @d2, 120)
    BEGIN
 --SET @sql = 'ALTER TABLE #tb ADD ['+ convert(varchar(10),dateadd(day , @i , getdate()),120) +'] NVARCHAR(100) NULL'
 --execute (@sql)
 --set @i = @i + 1

        SET @sql = 'ALTER TABLE tb ADD ['
            + CAST(DATEPART(MONTH, @date) AS VARCHAR) + '-'
            + CAST(DATEPART(DAY, @date) AS VARCHAR) + '] int NULL';   
          EXECUTE (@sql);          

        SET @date = CONVERT(VARCHAR(10), DATEADD(DAY, 1, @date), 120); 
    END;

PRINT @date;
PRINT @d2;

SELECT  *
FROM    tb;
--DROP TABLE tb;

GO
----ִ�д洢���̵Ľ�����������ݿ����
INSERT INTO dbo.tb
           ([���񵥺�]
           ,[�����]
           ,[����id]
           ,[��������]
           ,[��Ʒ����]
           ,[��Ʒ����]
           ,[���]
           ,[����id]
           ,[5-23]
           ,[5-24]
           ,[5-25]
           ,[5-26]
           ,[5-27]
           ,[5-28]
           ,[5-29]
           ,[5-30]
           ,[5-31]
           ,[6-1]
           ,[6-2]
           ,[6-3]
           ,[6-4]
           ,[6-5]
           ,[6-6]
           ,[6-7]
           ,[6-8]
           ,[6-9]
           ,[6-10]
           ,[6-11]
           ,[6-12]
           ,[6-13]
           ,[6-14]
           ,[6-15]
           ,[6-16]
           ,[6-17]
           ,[6-18]
           ,[6-19]
           ,[6-20]
           ,[6-21]
           ,[6-22]
           ,[6-23]
           ,[6-24]
           ,[6-25]
           ,[6-26]
           ,[6-27]
           ,[6-28]
           ,[6-29]
           ,[6-30]
           ,[7-1]
           ,[7-2]
           ,[7-3]
           ,[7-4]
           ,[7-5]
           ,[7-6]
           ,[7-7]
           ,[7-8]
           ,[7-9]
           ,[7-10]
           ,[7-11]
           ,[7-12]
           ,[7-13]
           ,[7-14]
           ,[7-15]
           ,[7-16]
           ,[7-17]
           ,[7-18]
           ,[7-19])
    EXEC dbo.ggatemp4 @p3 = 'WORK19041165' -- varchar(30)
    --SELECT * FROM tb


GO
---���в�ѯ���̶���ʽ�кͶ�̬�������� �д�����ѡ��ָ�����У��о�


  -------------
  --��ѯn-m�е����� ���������
declare @sql varchar(8000)
declare @m int,@n int
select @m=16
select @n=30
select @sql = '���񵥺�,����id,��������,��Ʒ����,���,����id,'
--��m��n
select @sql=@sql+'['+name+']'+',' from syscolumns where object_id('tb')=id and colid between @m and @n order by colid
 
select @sql=left(@sql,len(@sql)-1)
 
select @sql='select 
'+@sql+' from tb'
 PRINT @sql
exec(@sql) 

PRINT @sql
 SELECT * FROM tb
 
 
 
select 
�����,����id,��������,��Ʒ����,��Ʒ����,���,����id,[5-23],5-24,5-25,5-26,5-27,5-28,[5-29],5-30,5-31,6-1,6-2,6-3,6-4,6-5,6-6,6-7,6-8,6-9,6-10,6-11,6-12,6-13 from tb