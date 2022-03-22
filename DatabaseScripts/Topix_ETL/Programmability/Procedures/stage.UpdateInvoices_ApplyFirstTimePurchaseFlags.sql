SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [stage].[UpdateInvoices_ApplyFirstTimePurchaseFlags]

AS

TRUNCATE TABLE [work].[FirstOrderForCustomer]
INSERT INTO [work].[FirstOrderForCustomer]
(	Company
,	inv_no
,	CustomerID
)
SELECT
	Company
,	inv_no
,	CustomerID
FROM (
		SELECT Company 
		, InvoiceID
		, inv_no
		, CustomerID
		, inv_dt
		, R = ROW_NUMBER() OVER (PARTITION BY Company, CustomerID ORDER BY inv_dt ASC)
		FROM stage.Invoices
	) a
WHERE R = 1

UPDATE i
SET FirstOrderForCustomer = 'Yes'
FROM stage.Invoices i
JOIN [work].[FirstOrderForCustomer] f
ON i.Company = f.Company AND i.inv_no = f.inv_no

UPDATE stage.Invoices
SET FirstTimeItemPurchasedByCustomer = 'Yes'
WHERE InvoiceID IN
		(
			SELECT InvoiceID
			FROM (
					SELECT InvoiceID
					, ItemID
					, CustomerID
					, inv_dt
					, R = ROW_NUMBER() OVER (PARTITION BY ItemID, CustomerID ORDER BY inv_dt ASC)
					FROM stage.Invoices
				) a
			WHERE R = 1
		)

UPDATE stage.Invoices 
SET FirstOrderForCustomer = 'No'
WHERE FirstOrderForCustomer IS NULL

UPDATE stage.Invoices 
SET FirstTimeItemPurchasedByCustomer = 'No'
WHERE FirstTimeItemPurchasedByCustomer IS NULL
GO