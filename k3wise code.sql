--修改工序计划委外厂家

SELECT * FROM dbo.SHWorkBill WHERE FInterID=136357
--工序计划单供应商
SELECT  FSupplyID FROM dbo.SHWorkBillEntry WHERE FWorkBillNO='WB026504'

--修改供应商
UPDATE SHWorkBillEntry SET FSupplyID=6252 WHERE FWorkBillNO='WB026504'

---模糊查询
SELECT * FROM dbo.t_Supplier WHERE FName LIKE '%晟和%'


--有工序汇报，发现工序需要删除，下一道工序没有接受数量，则无法继续汇报工序，修改数据库
--删除工序后，接收数量不对，修改
SELECT * FROM icmo WHERE FBillNo = 'WORK18110503';
/*
UPDATE  ICMO
SET     FStatus =1
        --FCheckerID = null ,
        --FCloseDate = null
WHERE   FBillNo = 'WORK18110503';
*/
---select * from SHWorkBillEntry where FWorkBillNO = 'WB009367 '

--UPDATE  SHWorkBillEntry SET FStatus=1 WHERE FWorkBillNO = 'WB012260 '



--DELETE SHWorkBillEntry  WHERE FWorkBillNO = 'WB004554 '
 
 ---修改接受数量即可
-- update SHWorkBillEntry set FQtyRecive=0,FAuxQtyRecive=0 where FWorkBillNO = 'WB012261' 
---修改实做数量
-- update SHWorkBillEntry set FQtyfinish=0,FAuxQtyfinish=0 where FWorkBillNO = 'WB012238' 
---修改合格数量
-- update SHWorkBillEntry set FQtyPass=0,FAuxQtypass=0 where FWorkBillNO = 'WB012261' 
  
---删除委外转出
SELECT  * from ICShop_SubcOut  where  FBillNo='WWZC1625'

SELECT * FROM dbo.ICShop_SubcOutEntry WHERE FInterID=2624

---DELETE ICShop_SubcOut   WHERE FBillNo='WWZC1625'

 --DELETE dbo.ICShop_SubcOutEntry WHERE FInterID=2624


SELECT DB_ID()

GO
--任务单和历史产品入领料单 导致无法反下达和变更  需要修改历史的关联finterid
SELECT * FROM dbo.vwICBill_11 WHERE FBillNo='SOUT001243'

UPDATE  vwICBill_11 SET FInterID=29001  WHERE FBillNo='SOUT001243'




--任务单和历史产品入库关联 导致无法反下达和变更  需要修改历史的关联finterid
select * from vwICBill_2 
 where FBillNo='CIN001672'

go
update vwICBill_2 set FInterID=22061 where FInterID=2206
---改正后再修改回原来的id
go 
update vwICBill_2 set FInterID=22311 where FInterID=2231


---update 委外工序接收审核后上传不了附件问题 ，主要委外审核后工序计划关闭了，修改 SHWorkBillEntry   FStatus=1 然后反审核上传附近后审核即可


select * from SHWorkBillEntry where  FWorkBillNO='WB003465'

--update SHWorkBillEntry set FStatus=1 where  FWorkBillNO='WB003465'

GO
---修改委外接收单 价格
select * from ICShop_SubcInEntry where FEntryID=330
UPDATE ICShop_SubcInEntry SET FUnitPrice=20,FAmount=1000,FAuxTaxPrice=23.4,FTaxAmount=170,FAmountIncludeTax=1170,FBaseUnitPrice=20 WHERE FEntryID=330

GO

---锁定购货发票选单价格不能修改

select FTemplateID,* from ictransactiontype where FName='购货发票(专用)'--根据采购订单名称检索模板内码  
  
SELECT * FROM ictemplateentry WHERE FID='I02' order  by FCtlOrder-- 根据以上查出来的采购订单订单模板内码检索采购订单单据体所有字段，查询到含税单字段的值为9  
  
update ictemplateentry set FEnable=0  where FID='I02' AND  FCtlOrder=15--0代表锁定，48代表可读写 
--------------------- 
update ictemplateentry set 
--FNeedSave=1,---0表示不保存，1表示保存
--FEnable=48,--0表示锁定不让修改，48表示可以修改
--FCtlType=0,
FRelationID='FItemID',--表示该字段值是以物料编码内码为关联条件的
FAction='.,FApproveNo' --表示获取对应物料编码的对应的注册证号
WHERE FID='B01' and FCtlOrder=77--定位到需要调整的列
--------------------- 
GO


--- 没有在工作日历上工序汇报，替换汇报时间
--查询非工作日汇报记录
SELECT  *
FROM    SHProcRpt
WHERE   CONVERT(VARCHAR(100),FEndWorkDate,112) ='20190506'

UPDATE

--查询替换后的时间
SELECT  FstartWorkDate,newtime=REPLACE(FstartWorkDate,'8','7') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190505'

SELECT  FstartWorkDate,newtime=REPLACE(FstartWorkDate,'5','6') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190505'
---替换指定的字符串
UPDATE SHProcRpt SET FEndWorkDate=REPLACE(FEndWorkDate,'8','7') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FEndWorkDate,112) ='20190428'


SELECT STUFF('abcdef',2,3,'1235')
---指定字符替换
SELECT  FstartWorkDate,newtime=stuff(FstartWorkDate,11,1,'6') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190505'


SELECT GETDATE(),DATEADD(DAY,1,GETDATE())
---修改日期加到后一天
UPDATE SHProcRpt SET FstartWorkDate=dateadd(DAY,-2,FstartWorkDate) FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190508'