

select FTemplateID,* from ictransactiontype where FName='������Ʊ(ר��)'--���ݲɹ��������Ƽ���ģ������  
  
SELECT * FROM ictemplateentry WHERE FID='I02' order  by FCtlOrder-- �������ϲ�����Ĳɹ���������ģ����������ɹ����������������ֶΣ���ѯ����Ҫ�����ֶε�ֵ
 --�޸������ֶ�FEnable=0�����޸ģ�FEnable=48 ���޸� 
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=15
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=16
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=19
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=23
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=24

--�����ֶο����޸� 

update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=15
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=16
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=19
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=23
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=24

GO

--���ϳ������ݵ�ģ�����룺

--�⹺��� A01
--��Ʒ��� A02
--�̵�� NULL
--ί��ӹ���ⵥ A05
--������ ZIN
--������� A97
--���۳��� B01
--�������ϵ� B04
--��ֳ��� ZOU
--ί��ӹ����ⵥ B08
--�������ⵥ B09
--��ӯ��� C01
--������ D01
--�̿����� C02
--�ʼ췽�� QCS
--BOM�� Z01
--����·�� Z02
--����ƻ��� Z03
--�ͻ�BOM�� Z04
--�ظ������ƻ��� z05
--�������ϱ���/���ϵ� z06
--���۵� H01
--�ɹ����� P01
--�ɹ����� P02
--����֪ͨ/��쵥 P03
--����֪ͨ�� P04
--��ֵ��� P05
--������Ʊ(ר��) I02
--������Ʊ(��ͨ) I03
--���÷�Ʊ I06
--���۷��÷�Ʊ I07
--���۷�Ʊ(ר��) I04
--���۶��� S01
--�˻�֪ͨ S12
--����֪ͨ S02
--�������� J01
--���۷�Ʊ(��ͨ) I05
--��ƷԤ�ⵥ Y01
--����Ͷ�ϵ� Y02
--ƾ֤ V01
--���мӹ�������ⵥ A06
--�ɱ����� T01
--�⹺����ݹ���� A01
--ί��ӹ��ݹ���� A05
--���мӹ����� B37
--���˵� S03
--�ƻ����� J05
--�ɹ��� Z10
--PDM����BOM�� Z20
--PDM���ݹ���·�� Z21
--���񵥻㱨/��쵥 J11
--������ת�� Y51
--����㱨 Y52
--��ʱ�Ƽ������嵥 R01
--�˻��������뵥 T04
--�����������뵥 T05
--���������뵥 t06
--�����������뵥 T17



