---修改物料属性 FErpClsID=1 外购 3委外 2自制


SELECT * FROM dbo.t_ICItem WHERE FNumber='1.08245.0922'
GO

SELECT * FROM dbo.t_ICItem WHERE FNumber='1.05044.0003R'
GO

UPDATE t_ICItem SET FErpClsID=1 WHERE FNumber='1.05044.0003R'
GO