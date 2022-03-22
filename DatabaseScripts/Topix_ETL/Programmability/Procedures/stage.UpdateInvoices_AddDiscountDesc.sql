SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [stage].[UpdateInvoices_AddDiscountDesc]

AS

UPDATE i
SET DiscountDesc = d.DiscountDesc
--SELECT COUNT(*)
FROM stage.Invoices i
JOIN store.DiscountDesc d
on i.user_def_fld_3 = d.[ProjectNr]


GO