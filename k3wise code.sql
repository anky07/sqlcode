--�޸Ĺ���ƻ�ί�⳧��

SELECT * FROM dbo.SHWorkBill WHERE FInterID=136357
--����ƻ�����Ӧ��
SELECT  FSupplyID FROM dbo.SHWorkBillEntry WHERE FWorkBillNO='WB026504'

--�޸Ĺ�Ӧ��
UPDATE SHWorkBillEntry SET FSupplyID=6252 WHERE FWorkBillNO='WB026504'

---ģ����ѯ
SELECT * FROM dbo.t_Supplier WHERE FName LIKE '%�ɺ�%'


--�й���㱨�����ֹ�����Ҫɾ������һ������û�н������������޷������㱨�����޸����ݿ�
--ɾ������󣬽����������ԣ��޸�
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
 
 ---�޸Ľ�����������
-- update SHWorkBillEntry set FQtyRecive=0,FAuxQtyRecive=0 where FWorkBillNO = 'WB012261' 
---�޸�ʵ������
-- update SHWorkBillEntry set FQtyfinish=0,FAuxQtyfinish=0 where FWorkBillNO = 'WB012238' 
---�޸ĺϸ�����
-- update SHWorkBillEntry set FQtyPass=0,FAuxQtypass=0 where FWorkBillNO = 'WB012261' 
  
---ɾ��ί��ת��
SELECT  * from ICShop_SubcOut  where  FBillNo='WWZC1625'

SELECT * FROM dbo.ICShop_SubcOutEntry WHERE FInterID=2624

---DELETE ICShop_SubcOut   WHERE FBillNo='WWZC1625'

 --DELETE dbo.ICShop_SubcOutEntry WHERE FInterID=2624


SELECT DB_ID()

GO
--���񵥺���ʷ��Ʒ�����ϵ� �����޷����´�ͱ��  ��Ҫ�޸���ʷ�Ĺ���finterid
SELECT * FROM dbo.vwICBill_11 WHERE FBillNo='SOUT001243'

UPDATE  vwICBill_11 SET FInterID=29001  WHERE FBillNo='SOUT001243'




--���񵥺���ʷ��Ʒ������ �����޷����´�ͱ��  ��Ҫ�޸���ʷ�Ĺ���finterid
select * from vwICBill_2 
 where FBillNo='CIN001672'

go
update vwICBill_2 set FInterID=22061 where FInterID=2206
---���������޸Ļ�ԭ����id
go 
update vwICBill_2 set FInterID=22311 where FInterID=2231


---update ί�⹤�������˺��ϴ����˸������� ����Ҫί����˺���ƻ��ر��ˣ��޸� SHWorkBillEntry   FStatus=1 Ȼ������ϴ���������˼���


select * from SHWorkBillEntry where  FWorkBillNO='WB003465'

--update SHWorkBillEntry set FStatus=1 where  FWorkBillNO='WB003465'

GO
---�޸�ί����յ� �۸�
select * from ICShop_SubcInEntry where FEntryID=330
UPDATE ICShop_SubcInEntry SET FUnitPrice=20,FAmount=1000,FAuxTaxPrice=23.4,FTaxAmount=170,FAmountIncludeTax=1170,FBaseUnitPrice=20 WHERE FEntryID=330

GO

---����������Ʊѡ���۸����޸�

select FTemplateID,* from ictransactiontype where FName='������Ʊ(ר��)'--���ݲɹ��������Ƽ���ģ������  
  
SELECT * FROM ictemplateentry WHERE FID='I02' order  by FCtlOrder-- �������ϲ�����Ĳɹ���������ģ����������ɹ����������������ֶΣ���ѯ����˰���ֶε�ֵΪ9  
  
update ictemplateentry set FEnable=0  where FID='I02' AND  FCtlOrder=15--0����������48����ɶ�д 
--------------------- 
update ictemplateentry set 
--FNeedSave=1,---0��ʾ�����棬1��ʾ����
--FEnable=48,--0��ʾ���������޸ģ�48��ʾ�����޸�
--FCtlType=0,
FRelationID='FItemID',--��ʾ���ֶ�ֵ�������ϱ�������Ϊ����������
FAction='.,FApproveNo' --��ʾ��ȡ��Ӧ���ϱ���Ķ�Ӧ��ע��֤��
WHERE FID='B01' and FCtlOrder=77--��λ����Ҫ��������
--------------------- 
GO


--- û���ڹ��������Ϲ���㱨���滻�㱨ʱ��
--��ѯ�ǹ����ջ㱨��¼
SELECT  *
FROM    SHProcRpt
WHERE   CONVERT(VARCHAR(100),FEndWorkDate,112) ='20190506'

UPDATE

--��ѯ�滻���ʱ��
SELECT  FstartWorkDate,newtime=REPLACE(FstartWorkDate,'8','7') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190505'

SELECT  FstartWorkDate,newtime=REPLACE(FstartWorkDate,'5','6') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190505'
---�滻ָ�����ַ���
UPDATE SHProcRpt SET FEndWorkDate=REPLACE(FEndWorkDate,'8','7') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FEndWorkDate,112) ='20190428'


SELECT STUFF('abcdef',2,3,'1235')
---ָ���ַ��滻
SELECT  FstartWorkDate,newtime=stuff(FstartWorkDate,11,1,'6') FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190505'


SELECT GETDATE(),DATEADD(DAY,1,GETDATE())
---�޸����ڼӵ���һ��
UPDATE SHProcRpt SET FstartWorkDate=dateadd(DAY,-2,FstartWorkDate) FROM SHProcRpt WHERE   CONVERT(VARCHAR(100),FstartWorkDate,112) ='20190508'