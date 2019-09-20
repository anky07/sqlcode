-----生产任务执行明细----
SET NOCOUNT ON;
---先建立临时表，把需要查询的字段做到表中，因为设计到多张表的连接查询，先做主要的表连接，把其他表链接的字段空置，合成表后去链接修改--
CREATE TABLE #Data
    (
      FOrderType VARCHAR(255) NULL ,
      FInterId INT NULL ,
      FItemId INT NULL ,
      FTranType INT NULL ,
      FBillNo VARCHAR(255) NULL ,
      FShortNumber VARCHAR(255) NULL ,
      FNumber VARCHAR(255) NULL ,
      FName VARCHAR(255) NULL ,
      FModel VARCHAR(255) NULL ,
      FUnitName VARCHAR(255) NULL ,
      FUnitNameCu VARCHAR(255) NULL ,
      FQtyDecimal DECIMAL(28, 10) DEFAULT ( 4 )
                                  NULL ,
      FPlanCommitDate DATETIME NULL ,
      FPlanFinishDate DATETIME NULL ,
      FCommitDate DATETIME NULL ,
      FStartDate DATETIME NULL ,
      FFinishDate DATETIME NULL ,
      FPlanQty DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FPlanQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                 NULL ,
      FFinishQty DECIMAL(28, 10) DEFAULT ( 0 )
                                 NULL ,
      FFinishQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                   NULL ,
      FDiffQty DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FDiffQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                 NULL ,
      FPassQty DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FPassQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                 NULL ,
      FInStockQty DECIMAL(28, 10) DEFAULT ( 0 )
                                  NULL ,
      FInstockQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                    NULL ,
      FLostQty DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FLostQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                 NULL ,
      FScrapQty DECIMAL(28, 10) DEFAULT ( 0 )
                                NULL ,
      FScrapQtyCu DECIMAL(28, 10) DEFAULT ( 0 )
                                  NULL ,
      FPlanPer DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FInStockPer DECIMAL(28, 10) DEFAULT ( 0 )
                                  NULL ,
      FPassPer DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FScrapPer DECIMAL(28, 10) DEFAULT ( 0 )
                                NULL ,
      FLostPer DECIMAL(28, 10) DEFAULT ( 0 )
                               NULL ,
      FSumSort INT NULL ,
      FOrderBillNo VARCHAR(80) NULL ,
      FWorkShop VARCHAR(80) NULL
    ); 

----主要涉及到两个表链接直接查询的数据插入的临时表中=---ICMO t1 和t_department a
INSERT  INTO #Data
        SELECT  ' ' ,
                t1.FInterID ,
                t1.FItemID ,
                t1.FTranType ,
                t1.FBillNo ,
                '' ,
                '' ,
                '' ,
                '' ,
                '' ,
                '' ,
                4 ,
                t1.FPlanCommitDate ,
                t1.FPlanFinishDate ,
                t1.FCommitDate ,
                t1.FStartDate ,
                t1.FFinishDate ,
                t1.FQty ,
                0 ,
                t1.FQtyFinish ,
                0 ,
                ISNULL(t1.FQty, 0) - ISNULL(t1.FQtyFinish, 0) ,
                0 ,
                t1.FQtyPass ,
                0 ,
                t1.FStockQty ,
                0 ,
                t1.FQtyLost ,
                0 ,
                ISNULL(t1.FQtyScrap, 0) + ISNULL(t1.FQtyForItem, 0) ,
                0 ,
                ( CASE WHEN ISNULL(t1.FQty, 0) = 0 THEN 0
                       ELSE ROUND(( ISNULL(t1.FQtyFinish, 0) * 100 / t1.FQty ),
                                  2)
                  END ) ,
                ( CASE WHEN ISNULL(t1.FQtyFinish, 0) = 0 THEN 0
                       ELSE ( ISNULL(t1.FStockQty, 0) * 100 / t1.FQtyFinish )
                  END ) ,
                ( CASE WHEN ISNULL(t1.FQtyFinish, 0) = 0 THEN 0
                       ELSE ( ISNULL(t1.FQtyPass, 0) * 100 / t1.FQtyFinish )
                  END ) ,
                ( CASE WHEN ISNULL(t1.FQtyFinish, 0) = 0 THEN 0
                       ELSE ( ( ISNULL(t1.FQtyScrap, 0)
                                + ISNULL(t1.FQtyForItem, 0) ) * 100
                              / t1.FQtyFinish )
                  END ) ,
                ( CASE WHEN ISNULL(t1.FQtyFinish, 0) = 0 THEN 0
                       ELSE ( ISNULL(t1.FQtyLost, 0) * 100 / t1.FQtyFinish )
                  END ) ,
                0 ,
                '' ,
                a.FName
        FROM    ICMO t1 ,
                t_Department a
        WHERE   t1.FStatus > 0
                AND t1.FCancellation = 0
                AND t1.FTranType = 85
                AND t1.FWorkShop = a.FItemID
                AND a.FDProperty = 1070
                AND DATEDIFF(DAY, t1.FCommitDate, '2018-01-01') <= 0
                AND DATEDIFF(DAY, t1.FCommitDate, '2018-06-19') >= 0
                AND DATEDIFF(DAY, t1.FPlanCommitDate, '2018-01-01') <= 0
                AND DATEDIFF(DAY, t1.FPlanCommitDate, '2018-06-19') >= 0
                AND DATEDIFF(DAY, t1.FPlanFinishDate, '2018-01-01') <= 0
                AND DATEDIFF(DAY, t1.FPlanFinishDate, '2018-06-16') >= 0; 


--------------刷新物料代码、规格型号等 
UPDATE  t1
SET     t1.FName = t2.FName ,
        t1.FNumber = t2.FNumber ,
        t1.FShortNumber = t2.FShortNumber ,
        t1.FModel = ISNULL(t2.FModel, '') ,
        t1.FUnitName = t3.FName ,
        t1.FQtyDecimal = t2.FQtyDecimal
FROM    #Data t1 ,
        t_ICItem t2 ,
        t_MeasureUnit t3
WHERE   t1.FItemId = t2.FItemID
        AND t2.FUnitGroupID = t3.FUnitGroupID
        AND t3.FMeasureUnitID = t2.FUnitID;  


UPDATE  t1
SET     t1.FUnitNameCu = t3.FName ,
        t1.FPlanQty = ROUND(t1.FPlanQty, t1.FQtyDecimal) ,
        t1.FPlanQtyCu = ROUND(t1.FPlanQty / ISNULL(t3.FCoefficient, 1),
                              t1.FQtyDecimal) ,
        t1.FFinishQty = ROUND(t1.FFinishQty, t1.FQtyDecimal) ,
        t1.FFinishQtyCu = ROUND(t1.FFinishQty / ISNULL(t3.FCoefficient, 1),
                                t1.FQtyDecimal) ,
        t1.FDiffQty = ROUND(t1.FDiffQty, t1.FQtyDecimal) ,
        t1.FDiffQtyCu = ROUND(t1.FDiffQty / ISNULL(t3.FCoefficient, 1),
                              t1.FQtyDecimal) ,
        t1.FPassQty = ROUND(t1.FPassQty, t1.FQtyDecimal) ,
        t1.FPassQtyCu = ROUND(t1.FPassQty / ISNULL(t3.FCoefficient, 1),
                              t1.FQtyDecimal) ,
        t1.FInStockQty = ROUND(t1.FInStockQty, t1.FQtyDecimal) ,
        t1.FInstockQtyCu = ROUND(t1.FInStockQty / ISNULL(t3.FCoefficient, 1),
                                 t1.FQtyDecimal) ,
        t1.FLostQty = ROUND(t1.FLostQty, t1.FQtyDecimal) ,
        t1.FLostQtyCu = ROUND(t1.FLostQty / ISNULL(t3.FCoefficient, 1),
                              t1.FQtyDecimal) ,
        t1.FScrapQty = ROUND(t1.FScrapQty, t1.FQtyDecimal) ,
        t1.FScrapQtyCu = ROUND(t1.FScrapQty / ISNULL(t3.FCoefficient, 1),
                               t1.FQtyDecimal) ,
        t1.FPlanPer = ROUND(t1.FPlanPer, 2) ,
        t1.FInStockPer = ROUND(t1.FInStockPer, 2) ,
        t1.FPassPer = ROUND(t1.FPassPer, 2) ,
        t1.FScrapPer = ROUND(t1.FScrapPer, 2) ,
        t1.FLostPer = ROUND(t1.FLostPer, 2)
FROM    #Data t1 ,
        t_ICItem t2 ,
        t_MeasureUnit t3
WHERE   t1.FNumber = t2.FNumber
        AND t2.FUnitGroupID = t3.FUnitGroupID
        AND t2.FProductUnitID = t3.FMeasureUnitID;   

UPDATE  t1
SET     t1.FUnitNameCu = t3.FName
FROM    #Data t1 ,
        t_ICItem t2 ,
        t_MeasureUnit t3
WHERE   t1.FNumber = t2.FNumber
        AND t2.FUnitGroupID = t3.FUnitGroupID
        AND t2.FProductUnitID = t3.FMeasureUnitID;   

UPDATE  t1
SET     t1.FOrderBillNo = t2.FBillNo
FROM    #Data t1 ,
        SEOrder t2 ,
        ICMO t3
WHERE   t1.FInterId = t3.FInterID
        AND t2.FInterID = t3.FOrderInterID; 

UPDATE  t1
SET     t1.FOrderType = t2.FName
FROM    #Data t1 ,
        t_WorkType t2 ,
        ICMO t3
WHERE   t3.FBillNo = t1.FBillNo
        AND t2.FInterID = t3.FWorkTypeID
        AND t1.FOrderType = ''; 
SELECT  *
FROM    #Data
ORDER BY FBillNo; 
DROP TABLE #Data; 


SELECT * FROM icmo
SELECT * FROM dbo.t_Department
SELECT * FROM  SEOrder
