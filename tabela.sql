Select
-- Upper(eis_v_estoque_por_pedido.[CD_Inventory]) 'Deposito' ,  --retirei para teste
Upper(eis_v_estoque_por_pedido.[cd_depos]) 'Deposito' ,
case when left(eis_v_estoque_por_pedido.[CD_Customer_Order],3) = 'Plan' then
'Sim' else 'Não' end as 'Plan' ,
eis_v_estoque_por_pedido.[TX_Representative] 'Representante' ,
cast(eis_v_estoque_por_pedido.[DT_Delivery] as date) 'Data Prev. Entreg' ,
cast(eis_v_estoque_por_pedido.[data_prev_Faturar] as date) 'Data Prev. Faturar' ,
eis_v_estoque_por_pedido.[tx_emitter] 'Cliente' ,
--eis_v_estoque_por_pedido.[cd_emitter] 'Cod Cliente' ,
--eis_v_estoque_por_pedido.[cd_company] 'Cod Company' ,
eis_v_estoque_por_pedido.[CD_Customer_Order] 'Num Pedido' ,
eis_v_estoque_por_pedido.[item_do_cli] 'Cod Item Cliente' ,
eis_v_estoque_por_pedido.[CD_item] 'Cod Item' ,
eis_v_estoque_por_pedido.[TX_Item] 'Item' ,
cast(eis_v_estoque_por_pedido.[NM_Pipeline_Quantity] as decimal (13,3)) 'Quant Carteira' ,
cast(eis_v_estoque_por_pedido.[qtd_estoque_total] as decimal (13,3)) 'Qtd Estoque Total' ,
cast(eis_v_estoque_por_pedido.[as_qtd_disp_fatura] as decimal (13,3)) 'Qtd Disp Fatura' ,
cast(round(eis_v_estoque_por_pedido.[SALES_UNIT],3) as decimal (13,3)) 'Preco Unit' ,
cast(eis_v_estoque_por_pedido.[NM_Sales_Pipeline] as decimal (13,3)) 'Valor Carteira' ,
cast(eis_v_estoque_por_pedido.[valor_disp_fatura] as decimal (13,3)) 'Valor Disp. Faturamento' ,
cast(NM_Pipeline_Quantity-as_qtd_disp_fatura as decimal (13,3)) 'Quant Produzir' ,
eis_v_estoque_por_pedido.[CD_Item_Sequence] 'Seq.' ,
cast(round((as_qtd_disp_fatura/NM_Pipeline_Quantity)*100,2) as decimal (7,2)) 'Dif %' ,
case
when round((as_qtd_disp_fatura/NM_Pipeline_Quantity)*100,2) > 99 Then 'Sim'
when round((as_qtd_disp_fatura/NM_Pipeline_Quantity)*100,2) between 50 and 99 Then 'Parcial'
else 'Não' end as Atende,
cast(eis_v_estoque_por_pedido.[ESTOQUE_DISP_ITEM] as decimal (13,3)) 'Estoque Disp. Item' ,
eis_v_estoque_por_pedido.[TX_Commercial_Family] 'Familia Comercial' ,
eis_v_estoque_por_pedido.[TX_Material_Family] 'familia Material' ,
--eis_v_estoque_por_pedido.[qtd_dias_pulmao] 'Qtde Dias Pulmão' ,
cast(as_qtd_disp_fatura*SALES_UNIT as decimal (13,3)) 'Valor Faturavel' ,
eis_v_estoque_por_pedido.[dias_entrega] 'Dias Entrega' ,'' CustomField1, '' CustomField2, '' CustomField3    

From eis_v_estoque_por_pedido eis_v_estoque_por_pedido

Inner  Join DW_DTS_Company on (eis_v_estoque_por_pedido.CD_Company=DW_DTS_Company.CD_Company )

Where eis_v_estoque_por_pedido.cd_company IN( 'CPK' )  and DW_DTS_Company.CD_Site = 10
-- 2024-07-10
-- condicao do Where para melhorar visualização no Excel - Planilha dinamica (filtros do excel)
and year(eis_v_estoque_por_pedido.[data_prev_Faturar]) >= year(getdate())
and year(eis_v_estoque_por_pedido.[DT_Delivery]) >= year(getdate())

--GROUP BY eis_v_estoque_por_pedido.TX_Commercial_Family,eis_v_estoque_por_pedido.TX_Representative,eis_v_estoque_por_pedido.tx_emitter,eis_v_estoque_por_pedido.CD_item,eis_v_estoque_por_pedido.qtd_estoque_total,eis_v_estoque_por_pedido.DT_Delivery,eis_v_estoque_por_pedido.CD_Customer_Order,eis_v_estoque_por_pedido.CD_Item_Sequence,eis_v_estoque_por_pedido.data_prev_Faturar  
--having SUM(eis_v_estoque_por_pedido.as_qtd_disp_fatura) NOT IN( 0.0 ) 
