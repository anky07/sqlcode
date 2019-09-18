

select FTemplateID,* from ictransactiontype where FName='购货发票(专用)'--根据采购订单名称检索模板内码  
  
SELECT * FROM ictemplateentry WHERE FID='I02' order  by FCtlOrder-- 根据以上查出来的采购订单订单模板内码检索采购订单单据体所有字段，查询到需要锁定字段的值
 --修改锁定字段FEnable=0不可修改，FEnable=48 可修改 
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=15
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=16
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=19
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=23
update ictemplateentry set FEnable=0  where FID='I02' and FCtlOrder=24

--设置字段可以修改 

update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=15
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=16
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=19
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=23
update ictemplateentry set FEnable=48  where FID='I02' and FCtlOrder=24

GO

--附上常见单据的模板内码：

--外购入库 A01
--产品入库 A02
--盘点表 NULL
--委外加工入库单 A05
--虚仓入库 ZIN
--其他入库 A97
--销售出库 B01
--生产领料单 B04
--虚仓出库 ZOU
--委外加工出库单 B08
--其他出库单 B09
--盘盈入库 C01
--调拨单 D01
--盘亏毁损 C02
--质检方案 QCS
--BOM单 Z01
--工艺路线 Z02
--工序计划单 Z03
--客户BOM单 Z04
--重复生产计划单 z05
--生产物料报废/补料单 z06
--调价单 H01
--采购申请 P01
--采购订单 P02
--收料通知/请检单 P03
--退料通知单 P04
--虚仓调拨 P05
--购货发票(专用) I02
--购货发票(普通) I03
--费用发票 I06
--销售费用发票 I07
--销售发票(专用) I04
--销售订单 S01
--退货通知 S12
--发货通知 S02
--生产任务单 J01
--销售发票(普通) I05
--产品预测单 Y01
--生产投料单 Y02
--凭证 V01
--受托加工材料入库单 A06
--成本调整 T01
--外购入库暂估补差单 A01
--委外加工暂估补差单 A05
--受托加工领料 B37
--发运单 S03
--计划订单 J05
--派工单 Z10
--PDM数据BOM单 Z20
--PDM数据工艺路线 Z21
--任务单汇报/请检单 J11
--工序移转单 Y51
--工序汇报 Y52
--计时计件工资清单 R01
--退货检验申请单 T04
--发货检验申请单 T05
--库存检验申请单 t06
--其他检验申请单 T17



