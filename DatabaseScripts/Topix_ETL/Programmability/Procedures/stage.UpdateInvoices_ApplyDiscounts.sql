SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [stage].[UpdateInvoices_ApplyDiscounts]

AS


update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join [store].[ClarityRx_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '1'
and a.cus_no = cp.cd_tp_1_cust_no
and a.item_no = cp.cd_tp_1_item_no
and a.inv_dt between COALESCE(start_dt,'2000-01-01') and COALESCE(end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp


update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join stage.Customers c
on a.CustomerID = c.CustomerID
join [store].[ClarityRx_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '3'
and c.cus_type_cd = cp.cd_tp_3_cust_type
and a.item_no = cp.cd_tp_1_item_no
and a.inv_dt between COALESCE(cp.start_dt,'2000-01-01') and COALESCE(cp.end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL

update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join [store].[ClarityRx_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '5'
and a.cus_no = cp.cd_tp_1_cust_no
and a.inv_dt between COALESCE(start_dt,'2000-01-01') and COALESCE(end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL




update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join stage.Customers c
on a.CustomerID = c.CustomerID
join [store].[ClarityRx_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '7'
and c.cus_type_cd = cp.cd_tp_3_cust_type
and a.inv_dt between COALESCE(cp.start_dt,'2000-01-01') and COALESCE(cp.end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL


update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join [store].[DermaE_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '1'
and a.cus_no = cp.cd_tp_1_cust_no
and a.item_no = cp.cd_tp_1_item_no
and a.inv_dt between COALESCE(start_dt,'2000-01-01') and COALESCE(end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL



update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join stage.Customers c
on a.CustomerID = c.CustomerID
join [store].[DermaE_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '3'
and c.cus_type_cd = cp.cd_tp_3_cust_type
and a.item_no = cp.cd_tp_1_item_no
and a.inv_dt between COALESCE(cp.start_dt,'2000-01-01') and COALESCE(cp.end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL




update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join stage.Customers c
on a.CustomerID = c.CustomerID
join [store].[DermaE_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '7'
and c.cus_type_cd = cp.cd_tp_3_cust_type
and a.inv_dt between COALESCE(cp.start_dt,'2000-01-01') and COALESCE(cp.end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL







update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join [store].[Topiderm_Pricing] cp
on a.Company = cp.Company
and cp.cd_tp = '5'
and a.cus_no = cp.cd_tp_1_cust_no
and a.inv_dt between COALESCE(start_dt,'2000-01-01') and COALESCE(end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL



-- In topix dataset there are overlapping dates - this we handle by creating our own Lag dates based on the prior end date
select *
, Corrected_start_dt = COALESCE( DATEADD(d, 1, LAG(end_dt, 1) over (PARTITION BY cd_tp, cd_tp_1_cust_no, cd_tp_1_item_no order by end_dt asc))
								,start_dt
								,'1900-01-01')
, Corrected_end_dt  = COALESCE(end_dt,'2099-12-31')
INTO #TopixPricing
from store.Topix_Pricing cp


UPDATE a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join #TopixPricing cp
on a.Company = cp.Company
and cp.cd_tp = '1'
and a.cus_no = cp.cd_tp_1_cust_no
and a.item_no = cp.cd_tp_1_item_no
and a.inv_dt between Corrected_start_dt and Corrected_end_dt
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL


update a
set [DiscountType] = l.discount_type
, ContractFlag = 'Yes'
from stage.Invoices a
join #TopixPricing cp
on a.Company = cp.Company
and cp.cd_tp = '5'
and a.cus_no = cp.cd_tp_1_cust_no
and a.inv_dt between COALESCE(start_dt,'2000-01-01') and COALESCE(end_dt,'2099-12-31')
join [ref].PricingLookup_cd_tp l
on cp.cd_tp = l.cd_tp
WHERE a.ContractFlag is NULL



/*
select ContractFlag, [DiscountType], count(*)
from stage.Invoices
group by ContractFlag
, [DiscountType]
*/
GO