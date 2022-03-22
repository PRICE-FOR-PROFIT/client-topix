SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROC [etl].[ProcessAll]

AS

-- Placeholders for Merging of the data.
-- Types are assigned
-- NULL Values are replaced with Real NULLs
-- PrimaryKeys are created
EXEC [store].[Merge_ClarityRx_Customers]
EXEC [store].[Merge_DermaE_Customers] 
EXEC [store].[Merge_Think_Customers]
EXEC [store].[Merge_Topiderm_Customers]
EXEC [store].[Merge_Topix_Customers]

EXEC [store].[Merge_ClarityRx_Items]
EXEC [store].[Merge_DermaE_Items]
EXEC [store].[Merge_Think_Items]
EXEC [store].[Merge_Topiderm_Items]
EXEC [store].[Merge_Topix_Items]

EXEC [store].[Merge_ClarityRx_Pricing]
EXEC [store].[Merge_DermaE_Pricing]
EXEC [store].[Merge_Topiderm_Pricing]
EXEC [store].[Merge_Topix_Pricing]


EXEC [store].[Merge_ClarityRx_Invoices] 
EXEC [store].[Merge_DermaE_Invoices]
EXEC [store].[Merge_Think_Invoices]
EXEC [store].[Merge_Topiderm_Invoices]
EXEC [store].[Merge_Topix_Invoices] 

EXEC [store].Merge_DiscountDesc


-- Single Customer and Item masters are created
-- 5 separate Companys are consolidated into 1 table
EXEC [stage].[Map_Invoices]
EXEC [stage].[Map_Customers]
EXEC [stage].[Map_Items]


--Populate missing Customers from Invoices into stage.Customers
INSERT INTO  stage.Customers (Company, CustomerID, cus_no)
SELECT DISTINCT 'Missing', CustomerID, Cus_no
FROM stage.Invoices
WHERE CustomerID NOT IN (SELECT CustomerID FROM stage.Customers)

--Populate missing items from Invoices into stage.Items
INSERT INTO  stage.Items (Company, ItemID, item_no)
SELECT DISTINCT 'Missing', ItemID, Item_no
FROM stage.Invoices
WHERE ItemID NOT IN (SELECT ItemID FROM stage.Items)

EXEC stage.UpdateInvoices_ApplyDiscounts
EXEC stage.UpdateInvoices_AddDiscountDesc
EXEC stage.UpdateInvoices_ApplyFirstTimePurchaseFlags

EXEC stage.UpdateProduct_ApplyItemCleanupLogic
EXEC stage.UpdateProduct_ReplenixDomesticInternationalLogic

EXEC stage.UpdateInvoicesAndItems_PriceIncrease 



/*
select a.Company AS CompanyFromInvoice
, b.Company AS SourceOfCustomerFile
, COUNT(DISTINCT a.CustomerID) as NumberOfUniqueCustomers
, SUM(sls_amt) as TotalRevenue
, MAX(a.CustomerID) as ExampleOfCustomer
from stage.Invoices a
join stage.Customers b
on a.CustomerID = b.CustomerID
GROUP BY a.Company, b.Company
order by 1, 2

select count(*)
from stage.Invoices
where [WHSPriceIncrease] IS NOT NULL

select *
from stage.Invoices
where [DiscountDEsc] IS NOT NULL

select FirstOrderForCustomer, COUNT(*)
from stage.Invoices
GROUP BY FirstOrderForCustomer


select FirstTimeItemPurchasedByCustomer, COUNT(*)
from stage.Invoices
GROUP BY FirstTimeItemPurchasedByCustomer

select *
from stage.Items
where Item_no <> INSIGHT_Item


select *
from stage.Items
WHERE Company = 'Topix' and [ProdCategoryFromWHSPrices] is not null

select *
from stage.Invoices 
where Company = 'Topix' and [WHSPriceIncrease] IS NOT NULL

select COUNT(*), ReplenixDomesticInternationalFlag
from stage.Items
group by ReplenixDomesticInternationalFlag

select [ProdCategoryFromWHSPrices] , COUNT(*)
FROM stage.Items i
 join [ref].[ProdCategoryFromWHSPrices_Cleanup_replenix] c
on i.Insight_Item = c.Item
group by  [ProdCategoryFromWHSPrices] 

select Company, Year(Inv_dt), Month(Inv_Dt), SUM(sls_amt) as TotalRevenue
from stage.Invoices 
group by Company , Year(Inv_dt), Month(Inv_Dt)
ORDER BY 1,2,3

*/



GO