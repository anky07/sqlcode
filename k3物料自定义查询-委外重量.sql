DECLARE @fnumber VARCHAR(20)
SET @fnumber='1.05044'
SELECT  a.FItemID  AS id,
        a.FNumber AS 物料代码,
        a.FName AS 物料名称 ,
        a.FModel AS 规格型号,
       -- b.F_101 ,
        b.F_102 AS 正火 ,
        b.F_103 AS 调质 ,
        b.F_104 AS 中频 ,
        b.F_105 AS 氧化 ,
        --b.F_106 AS 产地 ,
        b.F_107 AS 离子氮化
FROM    dbo.T_icitem a
        INNER JOIN dbo.t_ICItemCustom b ON a.FItemID = b.FItemID
        WHERE a.FErpClsID=2 AND
         a.Fname NOT LIKE  '%总成%' AND a.Fname NOT LIKE  '%毛坯%'
        AND a.FNumber LIKE '%'+@fnumber+'%'  
        
  go      


---给查询结果增加序号 使用   IDENTITY(INT,1,1)和临时表      
DECLARE @fnumber VARCHAR(20)
SET @fnumber='1.08245'
SELECT  IDENTITY(INT,1,1) AS 序号,
        --a.FItemID  AS id,
        a.FNumber AS 物料代码,
        a.FName AS 物料名称 ,
        a.FModel AS 规格型号,
       -- b.F_101 ,
        b.F_102 AS 正火 ,
        b.F_103 AS 调质 ,
        b.F_104 AS 中频 ,
        b.F_105 AS 氧化 
        --b.F_106 AS 产地,
        --b.F_107 AS 离子氮化 
        INTO #temp
FROM    dbo.t_icItem a
        INNER JOIN dbo.t_ICItemCustom b ON a.FItemID = b.FItemID
        WHERE a.FNumber LIKE '%'+@fnumber+'%'  
        AND
        a.FErpClsID=2 AND
      a.Fname NOT LIKE  '%总成%' AND a.Fname NOT LIKE  '%毛坯%'     
      
      
      SELECT * FROM #temp
      
      DROP TABLE  #temp
      
      
      
       GO
       
 dECLARE @fnumber VARCHAR(20)
SET @fnumber='1.05044'
SELECT RANK () OVER (ORDER BY a.FItemID ) AS 序号,

        a.FItemID  AS id,
        a.FNumber AS 物料代码,
        a.FName AS 物料名称 ,
        a.FModel AS 规格型号,
       -- b.F_101 ,
        b.F_102 AS 正火 ,
        ROUND(ISNULL(b.F_102,0)*1.2,2) AS 正火价格,
        b.F_103 AS 调质 ,
        b.F_104 AS 中频 ,
        b.F_105 AS 氧化 ,
        --b.F_106 AS 产地 ,
        b.F_107 AS 离子氮化
FROM    dbo.T_icitem a
        INNER JOIN dbo.t_ICItemCustom b ON a.FItemID = b.FItemID
        WHERE a.FErpClsID=2 AND
         a.Fname NOT LIKE  '%总成%' AND a.Fname NOT LIKE  '%毛坯%'
        AND a.FNumber LIKE '%'+@fnumber+'%'  
        
        