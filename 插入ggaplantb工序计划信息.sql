 
 DECLARE @p3 VARCHAR(20)
 SET @p3='WORK19071724'
 

 INSERT  INTO dbo.ggaplantb(���񵥺�,�����, ��������, ��Ʒ���� ,��Ʒ����, ���)
 SELECT    
           a.FICMONO AS rwno ,
          --  b.FOperID AS col2 ,
            b.FOperSN AS col1 ,
            LTRIM(RTRIM(d.FName)) AS gxname ,
            ---b.FItemID AS item ,
            ( SELECT    FNumber
              FROM      dbo.t_Item
              WHERE     FItemID = a.FItemID
            ) AS FNumber ,
            ( SELECT    FName
              FROM      dbo.t_Item
              WHERE     FItemID = a.FItemID
            ) AS Fname ,
            'P�ƻ�' AS clas 
           -- b.FWorkBillNO AS ���� ,
            --0 AS num ,
            --CONVERT(VARCHAR(10), b.FPlanStartDate, 120) AS date
           -- INTO dbo.ggaplantb(���񵥺�,�����, ��������, ��Ʒ���� ,��Ʒ����, ���)
  FROM      SHWorkBill a
            INNER JOIN dbo.SHWorkBillEntry b ON a.FInterID = b.FinterID
            --INNER JOIN dbo.SHWorkBillEntry c ON a.FWBNO = c.FWorkBillNO
            INNER JOIN t_SubMessage d ON d.FInterID = b.FOperID
                   ---INNER JOIN dbo.t_Item e ON e.FinterID=a.FItemID
  WHERE   NOT EXISTS(SELECT  * FROM ggaplantb WHERE ���񵥺�=@p3)  AND a.FICMONO = @p3 
  --OR a.FICMONO = @p4 OR a.FICMONO = @p5
  
  
  SELECT * FROM ggaplantb
  
  --DELETE ggaplantb