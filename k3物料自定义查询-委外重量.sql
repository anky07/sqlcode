DECLARE @fnumber VARCHAR(20)
SET @fnumber='1.05044'
SELECT  a.FItemID  AS id,
        a.FNumber AS ���ϴ���,
        a.FName AS �������� ,
        a.FModel AS ����ͺ�,
       -- b.F_101 ,
        b.F_102 AS ���� ,
        b.F_103 AS ���� ,
        b.F_104 AS ��Ƶ ,
        b.F_105 AS ���� ,
        --b.F_106 AS ���� ,
        b.F_107 AS ���ӵ���
FROM    dbo.T_icitem a
        INNER JOIN dbo.t_ICItemCustom b ON a.FItemID = b.FItemID
        WHERE a.FErpClsID=2 AND
         a.Fname NOT LIKE  '%�ܳ�%' AND a.Fname NOT LIKE  '%ë��%'
        AND a.FNumber LIKE '%'+@fnumber+'%'  
        
  go      


---����ѯ���������� ʹ��   IDENTITY(INT,1,1)����ʱ��      
DECLARE @fnumber VARCHAR(20)
SET @fnumber='1.08245'
SELECT  IDENTITY(INT,1,1) AS ���,
        --a.FItemID  AS id,
        a.FNumber AS ���ϴ���,
        a.FName AS �������� ,
        a.FModel AS ����ͺ�,
       -- b.F_101 ,
        b.F_102 AS ���� ,
        b.F_103 AS ���� ,
        b.F_104 AS ��Ƶ ,
        b.F_105 AS ���� 
        --b.F_106 AS ����,
        --b.F_107 AS ���ӵ��� 
        INTO #temp
FROM    dbo.t_icItem a
        INNER JOIN dbo.t_ICItemCustom b ON a.FItemID = b.FItemID
        WHERE a.FNumber LIKE '%'+@fnumber+'%'  
        AND
        a.FErpClsID=2 AND
      a.Fname NOT LIKE  '%�ܳ�%' AND a.Fname NOT LIKE  '%ë��%'     
      
      
      SELECT * FROM #temp
      
      DROP TABLE  #temp
      
      
      
       GO
       
 dECLARE @fnumber VARCHAR(20)
SET @fnumber='1.05044'
SELECT RANK () OVER (ORDER BY a.FItemID ) AS ���,

        a.FItemID  AS id,
        a.FNumber AS ���ϴ���,
        a.FName AS �������� ,
        a.FModel AS ����ͺ�,
       -- b.F_101 ,
        b.F_102 AS ���� ,
        ROUND(ISNULL(b.F_102,0)*1.2,2) AS ����۸�,
        b.F_103 AS ���� ,
        b.F_104 AS ��Ƶ ,
        b.F_105 AS ���� ,
        --b.F_106 AS ���� ,
        b.F_107 AS ���ӵ���
FROM    dbo.T_icitem a
        INNER JOIN dbo.t_ICItemCustom b ON a.FItemID = b.FItemID
        WHERE a.FErpClsID=2 AND
         a.Fname NOT LIKE  '%�ܳ�%' AND a.Fname NOT LIKE  '%ë��%'
        AND a.FNumber LIKE '%'+@fnumber+'%'  
        
        