
GO
/****** Object:  StoredProcedure [dbo].[ggatemp4]    Script Date: 07/26/2019 10:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ggaproc1] @p3 VARCHAR(30)

AS 



     BEGIN
        DECLARE @p1 VARCHAR(10) ,
            @p2 VARCHAR(10);
        BEGIN
        
         --SET @p1='2019-03-01'
         --  SET @p1='2019-12-31'
            SELECT TOP 1
                    @p1 = CONVERT(VARCHAR(10), b.FPlanStartDate, 120) --取工序汇报的最早开始日期
            FROM    dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3; 
            SELECT TOP 1
                    @p2 = CONVERT(VARCHAR(10), b.FPlanEndDate, 120) --取工序汇报的结束日期
            FROM      dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3
            --OR a.FICMONO = @p4 OR a.FICMONO = @p5
            ORDER BY b.FEndWorkDate DESC;
            SELECT  *
            INTO    #ggatemp3
            FROM    (  
            
            SELECT    'P计划' AS clas ,
            a.FICMONO AS rwno ,
            b.FOperID AS col2 ,
            b.FOperSN AS col1 ,
            LTRIM(RTRIM(d.FName)) AS gxname ,
            b.FItemID AS item ,
            ( SELECT    FNumber
              FROM      dbo.t_Item
              WHERE     FItemID = a.FItemID
            ) AS FNumber ,
            ( SELECT    FName
              FROM      dbo.t_Item
              WHERE     FItemID = a.FItemID
            ) AS Fname ,
            b.FWorkBillNO AS 工序单 ,
            0 AS num ,
            CONVERT(VARCHAR(10), b.FPlanStartDate, 120) AS date
  FROM      SHWorkBill a
            INNER JOIN dbo.SHWorkBillEntry b ON a.FInterID = b.FinterID
            --INNER JOIN dbo.SHWorkBillEntry c ON a.FWBNO = c.FWorkBillNO
            INNER JOIN t_SubMessage d ON d.FInterID = b.FOperID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
  WHERE     a.FICMONO = @p3 
  --OR a.FICMONO = @p4 OR a.FICMONO = @p5
            
            --UNION all
            
            
            --SELECT    'S自制' AS clas ,
            --                    a.FICMONO AS rwno ,
            --                    a.FOperID AS col2 ,
            --                    c.FOperSN AS col1 ,
            --                    LTRIM(RTRIM(d.FName)) AS gxname ,
            --                    a.FItemID AS item ,
            --                    ( SELECT    FNumber
            --                      FROM      dbo.t_Item
            --                      WHERE     FItemID = a.FItemID
            --                    ) AS FNumber ,
            --                    ( SELECT    FName
            --                      FROM      dbo.t_Item
            --                      WHERE     FItemID = a.FItemID
            --                    ) AS Fname ,
            --                    a.FWBNO AS 工序单 ,
            --                    b.FOperAuxQtyPass AS num ,
            --                    CONVERT(VARCHAR(10), b.FEndWorkDate, 120) AS date
            --          FROM      SHProcRptMain a
            --                    INNER JOIN dbo.SHProcRpt b ON a.FInterID = b.FinterID
            --                    INNER JOIN dbo.SHWorkBillEntry c ON a.FWBNO = c.FWorkBillNO
            --                    INNER JOIN t_SubMessage d ON d.FInterID = a.FOperID
            --       ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
            --          WHERE     a.FICMONO = @p3 
            --          --OR a.FICMONO = @p4 OR a.FICMONO = @p5
            --          UNION ALL
            --          SELECT    'Q转出' AS clas ,
            --                    a.FICMOBillNo AS rwno ,---委外转出
            --                    a.FOperID AS col2 ,
            --                    a.FOperSN AS col1 ,
            --                    ( SELECT   LTRIM(RTRIM(FName))  
            --                      FROM      t_SubMessage
            --                      WHERE     FInterID = a.FOperID
            --                    ) AS gxname ,
            --                    a.FItemID AS item ,
            --                    ( SELECT    FNumber
            --                      FROM      dbo.t_Item
            --                      WHERE     FItemID = a.FItemID
            --                    ) AS FNumber ,
            --                    ( SELECT    FName
            --                      FROM      dbo.t_Item
            --                      WHERE     FItemID = a.FItemID
            --                    ) AS Fname ,
            --                    b.FWorkBillNO AS 工序单 ,
            --                    a.FOperTranOutQty AS num ,
            --                    CONVERT(VARCHAR(10), a.FFactTranOutDate, 120) AS date
            --          FROM      ICShop_SubcOutEntry a
            --                    INNER JOIN dbo.SHWorkBillEntry b ON b.FWBInterID = a.FWBInterID
            --                    INNER JOIN ICShop_SubcOut d ON d.FInterID = a.FInterID
            --       ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
            --          WHERE     a.FICMOBillNo = @p3 
            --          --OR a.FICMOBillNo = @p4 OR a.FICMOBillNo = @p5
            --          UNION ALL
            --          SELECT    'R接收' AS clas ,
            --                    a.FICMOBillNo AS rwno ,
            --                    a.FOperID AS col2 ,
            --                    a.FOperSN AS col1 ,
            --                    ( SELECT LTRIM(RTRIM(FName))  
            --                      FROM      t_SubMessage
            --                      WHERE     FInterID = a.FOperID
            --                    ) AS gxname ,
            --                    a.FItemID AS item ,
            --                    ( SELECT    FNumber
            --                      FROM      dbo.t_Item
            --                      WHERE     FItemID = a.FItemID
            --                    ) AS FNumber ,
            --                    ( SELECT    FName
            --                      FROM      dbo.t_Item
            --                      WHERE     FItemID = a.FItemID
            --                    ) AS Fname ,
            --                    b.FWorkBillNO AS 工序单 ,
            --                    a.FBasePassQty AS num ,
            --                    CONVERT(VARCHAR(10), d.FBillDate, 120) AS date
            --          FROM      ICShop_SubcInEntry a
            --                    INNER JOIN dbo.SHWorkBillEntry b ON b.FWBInterID = a.FWBInterID
            --                    INNER JOIN ICShop_SubcIn d ON d.FInterID = a.FInterID
            --       ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
            --          WHERE     a.FICMOBillNo = @p3 
            --          --OR a.FICMOBillNo = @p4 OR a.FICMOBillNo = @p5
                    
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
 
        SET @sql1 = 'select case when rownum = 1 then rwno else '''' end as 任务单号,
                    
                     
                     case when rownum = 1 then FNumber else '''' end as 产品编码,
                     case when rownum = 1 then fname else '''' end as 产品名称,
                     case when rownum = 1 then col1 else '''' end as 工序号,
                    --case when rownum = 1 then col2 else '''' end as 工序id,
                    case when rownum = 1 then gxname else '''' end as 工序名称,
                     --case when rownum = 1 then clas else '''' end as 类别,
                    clas as 类别';
 
        SET @sql2 = 'select rwno, col1,col2,gxname,FNumber,fname,item,clas,row_number() over(partition by col1,col2,clas 
                                                         order by rwno,clas ,item) as rownum';
         
 
        WHILE @date <= convert(varchar(10),DATEADD(DAY,35,@p2),120)
            BEGIN
                SET @sql1 = @sql1 + ',v_' + REPLACE(RIGHT(@date, 5), '-', '')
                    + ' as ''' + CAST(DATEPART(MONTH, @date) AS VARCHAR) + '-'
                    + CAST(DATEPART(DAY, @date) AS VARCHAR) + '''';                              
                SET @sql2 = @sql2 + ',SUM(case when date =''' + @date
                    + ''' then num else 0 end) as v_' + REPLACE(RIGHT(@date, 5),
                                                              '-', '');
     
                SET @date = CONVERT(VARCHAR(10), DATEADD(DAY, 1, @date), 120);
            END;
 
 
        SET @sql = @sql1 + ' from (' + @sql2
            + ' from #ggatemp3
                                 group by col1,col2,gxname,fnumber,fname,item,clas,rwno'
            + ') v';
  
--生产的动态sql语句                  
--SELECT @sql
 
 
        EXEC(@sql);

     DROP TABLE #ggatemp3;
   
    END
    --SELECT @sql

--exec ggatemp4 @p3='WORK19041165'
--exec ggaproc1 @p3='WORK19030955'


