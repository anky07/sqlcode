
ALTER PROCEDURE ggaproc @p3 VARCHAR(20)
AS
begin

DECLARE 
@sqlhz VARCHAR(MAX) = '' 

BEGIN

 
        DECLARE @p1 VARCHAR(10) ,
                @p2 VARCHAR(10),
                @p4 DATETIME,
                @p5 DATETIME,
                @pstartdate VARCHAR(10),
                @penddate VARCHAR(10);
      
      SET @pstartdate='';
      SET @penddate='';
     
            SELECT TOP 1
                    @p4 =  b.FPlanStartDate --取工序汇报的最早开始日期
            FROM    dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3; 
            SELECT TOP 1
                    @p5 =  b.FPlanEndDate --取工序汇报的结束日期
            FROM      dbo.SHWorkBillEntry b
                    INNER JOIN dbo.SHWorkBill a ON a.FInterID = b.FinterID
            WHERE   a.FICMONO = @p3
            --OR a.FICMONO = @p4 OR a.FICMONO = @p5
            ORDER BY b.FEndWorkDate DESC;
            
             SET @p1=CONVERT(VARCHAR(10), DATEADD(DAY,-1,@p4), 120)
             SET @p2=CONVERT(VARCHAR(10), DATEADD(DAY,35,@p5), 120)
       ---获取时间列
       
             SET @pstartdate=@pstartdate+ CAST(DATEPART(MONTH, @p1) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p1) AS VARCHAR) --日期列数据
             
             SET @penddate=@penddate+ CAST(DATEPART(MONTH, @p2) AS VARCHAR) + '-'+ CAST(DATEPART(DAY, @p2) AS VARCHAR)     ---结束日期列 
            
            
            
 BEGIN
            SELECT  *
            INTO    #ggatemp3
            FROM    (  
            
   
            SELECT    'S自制' AS clas ,
                                a.FICMONO AS rwno ,
                                a.FOperID AS col2 ,
                                c.FOperSN AS col1 ,
                                LTRIM(RTRIM(d.FName)) AS gxname ,
                                a.FItemID AS item ,
                                ( SELECT    FNumber
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS FNumber ,
                                ( SELECT    FName
                                  FROM      dbo.t_Item
                                  WHERE     FItemID = a.FItemID
                                ) AS Fname ,
                                a.FWBNO AS 工序单 ,
                                b.FOperAuxQtyPass AS num ,
                                CONVERT(VARCHAR(10), b.FEndWorkDate, 120) AS date
                      FROM      SHProcRptMain a
                                INNER JOIN dbo.SHProcRpt b ON a.FInterID = b.FinterID
                                INNER JOIN dbo.SHWorkBillEntry c ON a.FWBNO = c.FWorkBillNO
                                INNER JOIN t_SubMessage d ON d.FInterID = a.FOperID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
                      WHERE     a.FICMONO = @p3 
                      --OR a.FICMONO = @p4 OR a.FICMONO = @p5
                      UNION ALL
                      SELECT    'Q转出' AS clas ,
                                a.FICMOBillNo AS rwno ,---委外转出
                                a.FOperID AS col2 ,
                                a.FOperSN AS col1 ,
                                ( SELECT   LTRIM(RTRIM(FName))  
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
                                b.FWorkBillNO AS 工序单 ,
                                a.FOperTranOutQty AS num ,
                                CONVERT(VARCHAR(10), a.FFactTranOutDate, 120) AS date
                      FROM      ICShop_SubcOutEntry a
                                INNER JOIN dbo.SHWorkBillEntry b ON b.FWBInterID = a.FWBInterID
                                INNER JOIN ICShop_SubcOut d ON d.FInterID = a.FInterID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
                      WHERE     a.FICMOBillNo = @p3 
                      --OR a.FICMOBillNo = @p4 OR a.FICMOBillNo = @p5
                      UNION ALL
                      SELECT    'R接收' AS clas ,
                                a.FICMOBillNo AS rwno ,
                                a.FOperID AS col2 ,
                                a.FOperSN AS col1 ,
                                ( SELECT LTRIM(RTRIM(FName))  
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
                                b.FWorkBillNO AS 工序单 ,
                                a.FBasePassQty AS num ,
                                CONVERT(VARCHAR(10), d.FBillDate, 120) AS date
                      FROM      ICShop_SubcInEntry a
                                INNER JOIN dbo.SHWorkBillEntry b ON b.FWBInterID = a.FWBInterID
                                INNER JOIN ICShop_SubcIn d ON d.FInterID = a.FInterID
              
                      WHERE     a.FICMOBillNo = @p3 
                  
                    ) t;
        END;

 
        DECLARE @date VARCHAR(10) ,
            @sql VARCHAR(MAX) = '' ,
            @sql1 VARCHAR(8000) ,
            @sql2 VARCHAR(8000);
 
        SET @date = @p1
 
        SET @sql1 = 'select case when rownum = 1 then rwno else '''' end as 任务单号,
                   
                   
                     case when rownum = 1 then FNumber else '''' end as 产品编码,
                     case when rownum = 1 then fname else '''' end as 产品名称,
                     case when rownum = 1 then col1 else '''' end as 工序号,
                    --case when rownum = 1 then col2 else '''' end as 工序id,
                    case when rownum = 1 then gxname else '''' end as 工序名称,
                     --case when rownum = 1 then clas else '''' end as 类别,
                     clas as 类别';
 
        SET @sql2 = 'select rwno, col1,col2,gxname,FNumber,fname,item,clas,row_number() over(partition by col1,col2,clas 
                                                         order by item,rwno,clas ) as rownum';
         
 
        WHILE @date <= @p2
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
                                 group by col1,col2,gxname,fnumber,fname,item,clas,rwno '
            + ') v';
  
--生产的动态sql语句                  
--PRINT  @sql
 
 
     --EXEC(@sql);

    -- DROP TABLE #ggatemp3;



-------工序计划表获取数据


DECLARE @sql3 varchar(1000)
declare @m int,@n int




select @m=colid from syscolumns where object_id('ggaplantb')=id AND name=@pstartdate --查找日期列对应的其实colid id

select @n=colid from syscolumns where object_id('ggaplantb')=id AND name=@penddate   ----查找日期列对应的其实colid id


--SELECT @p1,@p2,@p3,@pstartdate,@penddate, @m,@n

select @sql3 = '任务单号,产品编码,产品名称,工序号,工序名称,类别,'
--从m到n
select @sql3=@sql3+'['+name+']'+',' from syscolumns where object_id('ggaplantb')=id and colid between @m and @n order by colid
 --SELECT @sql
select @sql3=left(@sql3,len(@sql3)-1)
 
select @sql3='select '+@sql3+' from ggaplantb where 任务单号='+char(39)+@p3+char(39)+'ORDER BY 工序号,类别'
--SET @sql=@sql1;
PRINT @sql3
--exec(@sql) 

--SELECT * FROM ggaplantb


--EXEC dbo.ggaproc4 @p3 = 'WORK19030953' -- varchar(20)

--PRINT @sql;
--PRINT @sql3;
SET @sqlhz=@sql+' '+'union all' +' ' +@sql3

--PRINT @sqlhz;
EXEC(@sqlhz)
--EXEC(@sql);
--EXEC(@sql3);
--PRINT @pstartdate;
--PRINT @penddate;

--SELECT @p1,@p2,@penddate,@pstartdate
DROP TABLE #ggatemp3;

END
end

 --exec ggaproc @p3='WORK19030955'