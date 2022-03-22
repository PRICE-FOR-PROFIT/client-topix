SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [store].[Merge_DiscountDesc]

AS

TRUNCATE TABLE store.DiscountDesc

INSERT INTO store.DiscountDesc
SELECT ProjectNr = TRIM(ProjectNr)
, DiscountDesc = TRIM(Description)
FROM raw.DiscountDesc 
GO