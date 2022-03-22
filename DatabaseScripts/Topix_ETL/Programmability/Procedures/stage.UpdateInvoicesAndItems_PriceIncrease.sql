SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [stage].[UpdateInvoicesAndItems_PriceIncrease]

AS

-- This proc takes a number of reference 1 time lookup files that were collected during the interview process
-- to come up with a cleaner way to categorize products and establish list prices.

-- Inputs include: Individual Company list prices increases with their own product segmentations.
		-- [ref].[Topix_WholeSalesPriceIncrease2019_2021]
		-- [ref].[DermaE_WholeSalesPriceIncrease2020_2021]
		-- [ref].[Think_WholeSalesPriceIncrease2020_2021]
		
		-- [ref].[ProdCategoryFromWHSPrices_Cleanup]: This file is used to clean up ProdCategoryFromWHSPrices since this field is used for Prod classification 

-- Outputs: The prices from these files are applied to the Invoices based on the year
--			Additional segmentation is placed on the product master (stage.Items)
--				[ProdTypeFromWHSPrices] 
--				[ProdSegmentFromWHSPrices] 
--				[ProdCategoryFromWHSPrices]
--				[ProdLineFromWHSPrices]



TRUNCATE TABLE work.Topix_WholeSalesPriceIncreases
INSERT INTO work.Topix_WholeSalesPriceIncreases
( ItemID
, item_no
, WHSPrice2019
, WHSPrice2020 
, WHSPrice2021 
, [ProdCategoryFromWHSPrices]
)

SELECT DISTINCT 
  ItemID
, i.item_no
, WHSPrice2019 =  CAST(r1.[2019 List Price] AS DECIMAL(18,9))
, WHSPrice2020 =  CAST(r1.[2020 List Price] AS DECIMAL(18,9))
, WHSPrice2021 =  CAST(r1.[2021 List Price] AS DECIMAL(18,9))
, [ProdCategoryFromWHSPrices] = NULLIF(TRIM(r1.[ProdCategoryFromWHSPrices]),'')
FROM stage.Invoices i
JOIN   (SELECT	Item_no = TRIM(Item_no)
			, [2019 List Price]=  MAX([2019#00])
			, [2020 List Price]=  MAX([2020#00])
			, [2021 List Price] = MAX([2021#00])
			, [ProdCategoryFromWHSPrices] = MAX([Category])
		FROM [ref].[Topix_WholeSalesPriceIncrease2019_2021]
		GROUP BY TRIM(Item_no)
		) r1
ON i.ItemID  = CONCAT('Topix_',TRIM(r1.Item_no)) 
WHERE [2019 List Price] IS NOT NULL OR [2020 List Price] IS NOT NULL OR [2021 List Price] IS NOT NULL 


TRUNCATE TABLE work.DermaE_WholeSalesPriceIncreases
INSERT INTO work.DermaE_WholeSalesPriceIncreases
( ItemID
, item_no
, WHSPrice2020 
, WHSPrice2021 
, [ProdLineFromWHSPrices]
, [ProdCategoryFromWHSPrices]
)

SELECT DISTINCT 
  ItemID
, i.item_no
, WHSPrice2020 =  CAST(r1.[2020 List Price] AS DECIMAL(18,9))
, WHSPrice2021 =  CAST(r1.[2021 List Price] AS DECIMAL(18,9))
, [ProdLineFromWHSPrices] = NULLIF(TRIM(r1.Line), '')
, [ProdCategoryFromWHSPrices] = NULLIF(TRIM(r1.[Product Segment]),'')
FROM stage.Invoices i
JOIN   (SELECT	[Item No]
			, [2020 List Price]=  MAX([2020 List Price])
			, [2021 List Price] = MAX([2021 List Price])
			, [Line] = MAX([Line])
			, [Product Segment] = MAX([Product Segment])
		FROM [ref].[DermaE_WholeSalesPriceIncrease2020_2021]
		GROUP BY [Item No]
		) r1
ON i.ItemID  = CONCAT('DermaE_',TRIM(r1.[Item No])) 
WHERE [2020 List Price] IS NOT NULL OR [2021 List Price] IS NOT NULL

	

TRUNCATE TABLE work.Think_WholeSalesPriceIncreases
INSERT INTO work.Think_WholeSalesPriceIncreases
( ItemID
, item_no
, WHSPrice2020 
, WHSPrice2021 
, [ProdTypeFromWHSPrices] 
, [ProdSegmentFromWHSPrices] 
, [ProdCategoryFromWHSPrices]
)

SELECT DISTINCT 
  ItemID
, i.item_no
, WHSPrice2020 = CAST(NULLIF(r1.[2021 List Price],'') AS DECIMAL(18,9))
, WHSPrice2021 = CAST(NULLIF(r1.[2021 List Price],'') AS DECIMAL(18,9))
, [ProdTypeFromWHSPrices] = NULLIF(TRIM(r1.[Type]), '')
, [ProdSegmentFromWHSPrices] = NULLIF(TRIM(r1.[Product Segment]),'')
, [ProdCategotyFromWHSPrices] = NULLIF(TRIM(r1.[Product Category]),'')
FROM stage.Invoices i
JOIN   (SELECT	[Item No]
			, [2020 List Price]=  MAX([2020 List Price])
			, [2021 List Price] = MAX([2021 List Price])
			, [Type] = MAX([Type])
			, [Product Segment] = MAX([Segment])
			, [Product Category] = MAX([Category ])
		FROM [ref].[Think_WholeSalesPriceIncrease2020_2021]
		GROUP BY [Item No]
		) r1
ON i.ItemID  = CONCAT('Think_',TRIM(r1.[Item No])) 
WHERE [2020 List Price] IS NOT NULL OR [2021 List Price] IS NOT NULL


TRUNCATE TABLE [work].[Replenix_WholeSalesPriceIncreases]
INSERT INTO [work].[Replenix_WholeSalesPriceIncreases]
( ItemID
, item_no
, WHSPrice2021 
, [ProdSegmentFromWHSPrices] 
)

SELECT DISTINCT 
  ItemID
, i.item_no
, WHSPrice2021 = CAST(NULLIF(r1.[2021 List Price],'') AS DECIMAL(18,9))
, [ProdSegmentFromWHSPrices] = NULLIF(TRIM(r1.[Product Segment]),'')
FROM stage.Invoices i
JOIN   (
		SELECT	[Item No] = [DRIVE Item Number]
			, [2021 List Price] = MAX([2021 WHS Price])
			, [Product Segment] = MAX([UPDATED Product Segment ])
		FROM [ref].[Replenix_WholeSalesPriceIncrease2021]
		GROUP BY [DRIVE Item Number]
		) r1
ON i.ItemID  = CONCAT('Topix_',TRIM(r1.[Item No])) 
WHERE [2021 List Price] IS NOT NULL


UPDATE i
SET [PriceIncreaseFlag] = 'Yes'
, [ProdCategoryFromWHSPrices] = w.[ProdCategoryFromWHSPrices]
FROM stage.Items i
JOIN work.Topix_WholeSalesPriceIncreases w
on i.ItemID = w.itemID

UPDATE i
SET [PriceIncreaseFlag] = 'Yes'
, [ProdSegmentFromWHSPrices] = w.[ProdSegmentFromWHSPrices]
FROM stage.Items i
JOIN work.Replenix_WholeSalesPriceIncreases w
on i.ItemID = w.itemID

UPDATE i
SET [PriceIncreaseFlag] = 'Yes'
, [ProdLineFromWHSPrices] = w.ProdLineFromWHSPrices 
, [ProdCategoryFromWHSPrices] = w.ProdCategoryFromWHSPrices
FROM stage.Items i
JOIN work.DermaE_WholeSalesPriceIncreases w
on i.ItemID = w.itemID

UPDATE i
SET [PriceIncreaseFlag] = 'Yes'
--, [ProdTypeFromWHSPrices] = w.[ProdTypeFromWHSPrices] 
--, [ProdSegmentFromWHSPrices] = w.[ProdSegmentFromWHSPrices]
, [ProdCategoryFromWHSPrices] = w.[ProdCategoryFromWHSPrices]
FROM stage.Items i
JOIN work.Think_WholeSalesPriceIncreases w
on i.ItemID = w.itemID


UPDATE stage.Items
SET [PriceIncreaseFlag] = 'No'
WHERE [PriceIncreaseFlag] IS NULL

UPDATE  i  
SET [WHSPriceIncrease] = CASE YEAR(inv_dt)	WHEN 2019 THEN w.WHSPrice2019
											WHEN 2020 THEN w.WHSPrice2020	
											WHEN 2021 THEN w.WHSPrice2021
										END
FROM stage.Invoices i
JOIN work.Topix_WholeSalesPriceIncreases w
on i.ItemID = w.itemID

UPDATE  i  
SET [WHSPriceIncrease] = CASE YEAR(inv_dt)	--WHEN 2019 THEN w.WHSPrice2019
											--WHEN 2020 THEN w.WHSPrice2020	
											WHEN 2021 THEN w.WHSPrice2021
										END
FROM stage.Invoices i
JOIN work.Replenix_WholeSalesPriceIncreases w
on i.ItemID = w.itemID


UPDATE  i  
SET [WHSPriceIncrease] = CASE YEAR(inv_dt)	--WHEN 2019 THEN w.WHSPrice2019
											WHEN 2020 THEN w.WHSPrice2020	
											WHEN 2021 THEN w.WHSPrice2021
										END
FROM stage.Invoices i
JOIN work.DermaE_WholeSalesPriceIncreases w
on i.ItemID = w.itemID


UPDATE  i  
SET [WHSPriceIncrease] = CASE YEAR(inv_dt)	--WHEN 2019 THEN w.WHSPrice2019
											WHEN 2020 THEN w.WHSPrice2020	
											WHEN 2021 THEN w.WHSPrice2021
										END
FROM stage.Invoices i
JOIN work.Think_WholeSalesPriceIncreases w
on i.ItemID = w.itemID


UPDATE i
SET [ProdCategoryFromWHSPrices] = TRIM(p.[UPDATED CATEGORY])
FROM stage.Items i
JOIN ref.ProdCategoryFromWHSPrices_Cleanup p
ON i.INSIGHT_Item = p.Insight_Item

UPDATE i
SET [ProdCategoryFromWHSPrices] = 'Cleanser'
FROM stage.Items i
WHERE INSIGHT_Item = '690'

UPDATE i
SET [ProdCategoryFromWHSPrices] = r.[Product Category]
--, ProdSegmentFromWHSPrices = r.[Product Segment]
FROM stage.Items i
JOIN ref.ProdCategoryFromWHSPrices_Cleanup_Replenix r
ON r.Item = i.INSIGHT_Item
and i.ProdCategoryFromWHSPrices IS NULL
GO