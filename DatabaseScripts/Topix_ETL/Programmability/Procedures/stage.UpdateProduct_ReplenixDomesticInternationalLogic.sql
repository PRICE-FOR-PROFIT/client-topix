SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE  PROC  [stage].[UpdateProduct_ReplenixDomesticInternationalLogic]
AS

UPDATE stage.Items
SET ReplenixDomesticInternationalFlag = NULL

UPDATE i
SET ReplenixDomesticInternationalFlag = r.Brand
FROM stage.Items i
JOIN ref.Replenix_InternationalUS r
ON i.item_no = TRIM(r.Item_No)

UPDATE stage.Items
SET ReplenixDomesticInternationalFlag = CASE WHEN item_no like '%CN' THEN 'Replenix - CN' ELSE 'Replenix - Domestic' END
FROM stage.Items
WHERE (item_desc_1 like '%REPLENIX%' or item_desc_2 like '%REPLENIX%')
AND ReplenixDomesticInternationalFlag IS NULL


GO