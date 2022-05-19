SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [stage].[UpdateInvoicesItemNoCleaned]
AS

UPDATE i
SET ItemNoCleaned = 
	CASE	
			WHEN i.Company = 'Topix'	AND mat_cost_desc like 'FINISHED%'	AND i.Item_no LIKE '%COSTCO%' THEN REPLACE(i.Item_no, 'COSTCO','')
			WHEN i.Company = 'Topix'	AND mat_cost_desc like 'FINISHED%'	AND RIGHT(i.Item_no, 3) IN ('B B','MBC') THEN LEFT(i.Item_no, LEN(i.Item_no)-3)
			WHEN i.Company = 'Topix'	AND mat_cost_desc like 'FINISHED%'	AND RIGHT(i.Item_no, 2) IN ('BB','MB','DM','CN') THEN LEFT(i.Item_no, LEN(i.Item_no)-2)				
			WHEN i.Company = 'Topix'	AND mat_cost_desc like 'FINISHED%'	AND RIGHT(i.Item_no, 1) = 'B' THEN LEFT(i.Item_no, LEN(i.Item_no)-1)
			WHEN i.Company = 'DermaE'	AND mat_cost_desc like 'FINISHED%'	AND i.Item_no LIKE '%C.%' THEN LEFT(i.Item_no, CHARINDEX('C.', i.Item_no)-1)
			WHEN i.Company = 'DermaE'	AND mat_cost_desc like 'FINISHED%'	AND i.Item_no LIKE '%AR.%' THEN LEFT(i.Item_no, CHARINDEX('AR.', i.Item_no)-1)
			WHEN i.Company = 'DermaE'	AND mat_cost_desc like 'FINISHED%'	AND i.Item_no LIKE '%A.%' THEN LEFT(i.Item_no, CHARINDEX('A.', i.Item_no)-1)
			WHEN i.Company = 'DermaE'	AND mat_cost_desc like 'FINISHED%'	AND i.Item_no LIKE '%F.%' THEN LEFT(i.Item_no, CHARINDEX('F.', i.Item_no)-1)
			WHEN i.Company = 'DermaE'	AND mat_cost_desc like 'FINISHED%'	AND i.Item_no LIKE '%.%' THEN LEFT(i.Item_no, CHARINDEX('.', i.Item_no)-1) 	
			WHEN i.Company = 'DermaE'	AND mat_cost_desc like 'FINISHED%'	AND RIGHT(i.Item_no, 1) = 'C' AND ISNUMERIC(LEFT(i.Item_no, LEN(i.Item_no)-1)) = 1  THEN LEFT(i.Item_no, LEN(i.Item_no)-1)	
			WHEN i.Company = 'Replenix'	AND mat_cost_desc like 'FINISHED%'	AND LEFT(i.Item_no,1) = '8' THEN 
				(
					CASE WHEN LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(i.Item_no, 'CN', ''),'MB', ''),'BB', ''),'DM', ''),'C', ''),'K', ''),'PL',''),'TX','')) >= 4 
							THEN RIGHT(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(i.Item_no, 'CN', ''),'MB', ''),'BB', ''),'DM', ''),'C', ''),'K', ''),'PL',''),'TX',''), LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(i.Item_no, 'CN', ''),'MB', ''),'BB', ''),'DM', ''),'C', ''),'K', ''),'PL',''),'TX','')) - 1)
							ELSE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(i.Item_no, 'CN', ''),'MB', ''),'BB', ''),'DM', ''),'C', ''),'K', ''),'PL',''),'TX','')
					END
				)
			WHEN i.Company = 'Replenix'	AND mat_cost_desc like 'FINISHED%' AND RIGHT(i.Item_no,3) IN ('MBC','ALT','BBS') THEN LEFT(i.Item_no, LEN(i.Item_no)-3)
			WHEN i.Company = 'Replenix'	AND mat_cost_desc like 'FINISHED%' AND RIGHT(i.Item_no,2) IN ('CN', 'MB', 'PL', 'BB', 'DM', 'TX') THEN LEFT(i.Item_no, LEN(i.Item_no)-2)
			WHEN i.Company = 'Replenix'	AND mat_cost_desc like 'FINISHED%' AND RIGHT(i.Item_no,1) IN ('C', 'B') THEN LEFT(i.Item_no, LEN(i.Item_no)-2)
			ELSE i.Item_no
	END
from stage.Invoices i
join stage.Items p
on p.[ItemID] = i.ItemID
GO