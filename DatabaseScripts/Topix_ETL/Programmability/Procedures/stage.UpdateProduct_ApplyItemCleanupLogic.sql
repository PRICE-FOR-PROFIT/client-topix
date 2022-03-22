SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [stage].[UpdateProduct_ApplyItemCleanupLogic]

AS


--TRUNCATE TABLE work.ItemCleanUp

--INSERT INTO work.ItemCleanUp (ItemID, Item, INSIGHTItem, Company)
--SELECT ItemID = CONCAT(Company, '_', Item), Item, INSIGHTItem, Company
--FROM  (
--		SELECT	Item = '843COSTCO',	INSIGHTItem =	'843',	Company = 'Topix'			UNION
--		SELECT			'1215MBC',					'1215',	Company = 'Topix'			UNION
--		SELECT			'1070CN30',					'1070',	Company = 'Topix'			UNION
--		SELECT			'1240MB',					'1240',	Company = 'Topix'			UNION
--		SELECT			'852COSTCO',				'852',	Company = 'Topix'			UNION
--		SELECT			'818CNS',					'818',	Company = 'Topix'			UNION
--		SELECT			'1230DM',					'1230',	Company = 'Topix'			UNION
--		SELECT			'873COSTCO',				'875',	Company = 'Topix'			UNION
--		SELECT			'857MB',					'857',	Company = 'Topix'			UNION
--		SELECT			'848COSTCO',				'848',	Company = 'Topix'			UNION
--		SELECT			'1012FOILB',				'1012',	Company = 'Topix'			UNION
--		SELECT			'1160TX',					'1160',	Company = 'Topix'			UNION
--		SELECT			'1020TX',					'1020',	Company = 'Topix'			UNION
--		SELECT			'1025TX',					'1025',	Company = 'Topix'			UNION
--		SELECT			'818COSTCO',				'818',	Company = 'Topix'			UNION
--		SELECT			'1030TX',					'1030',	Company = 'Topix'
--		) U


--INSERT INTO work.ItemCleanUp (ItemID, Item, INSIGHTItem, Company)
--select DISTINCT CONCAT('DermaE_',[Item No]), [Item No], [Item No Cleaned], Company ='DermaE'
--from [ref].[DermaE_ItemCleanUp]
--where [Item No] IS NOT NULL


--UPDATE i
--SET INSIGHT_Item  = COALESCE(w.INSIGHTItem, i.item_no)
--FROM stage.Items i
--LEFT JOIN work.ItemCleanUp w
--ON i.ItemID = w.ItemID 




UPDATE i
SET i.Brand = ISNULL(NULLIF(NULLIF(NULLIF(NULLIF(m.[UPDATED Company ],'N/A'), '#N/A'),''),'{NULL}'), 'Topiderm')
, i.ProdSegmentFromWHSPrices =  NULLIF(NULLIF(NULLIF(NULLIF(m.[UPDATED Product Segment ],'N/A'), '#N/A'),''),'{NULL}')
, i.ProdTypeFromWHSPrices = NULLIF(NULLIF(NULLIF(NULLIF(m.[UPDATED Product Type ],'N/A'), '#N/A'),''),'{NULL}')
, i.INSIGHT_Item =  NULLIF(NULLIF(NULLIF(NULLIF(m.[UPDATED Item Number],'N/A'), '#N/A'),''),'{NULL}')
FROM stage.Items i
JOIN ref.ItemMasterCleanup m
ON i.item_no = m.[DRIVE Item Number]



GO