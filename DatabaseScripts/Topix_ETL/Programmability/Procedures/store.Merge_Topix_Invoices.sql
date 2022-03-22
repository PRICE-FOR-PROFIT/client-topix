SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [store].[Merge_Topix_Invoices]

AS

/* 
Code to handle for errored records during the data loads
When a record is errored - it is entered into the etl.Invoices_Errors before it gets removed.
*/
/*
INSERT INTO etl.Invoices_Errors
SELECT FileSource = CAST('raw.Topix_Invoices' as NVARCHAR(100))
,	Reason = CAST('Shifting of columns' as NVARCHAR(300))
,	LoadDate = GETDATE()
,   *
FROM raw.Topix_Invoices
WHERE  TRY_CAST(NULLIF(TRIM([request_dt]),'NULL') AS DATE) IS NULL and [request_dt] IS NOT NULL

DELETE FROM raw.Topix_Invoices
WHERE  TRY_CAST(NULLIF(TRIM([request_dt]),'NULL') AS DATE) IS NULL and [request_dt] IS NOT NULL
*/



INSERT INTO store.Topix_Invoices (
	   [InvoiceID]
      ,[CustomerID]
      ,[ItemID]
	  ,[orig_ord_type]
      ,[ord_type]
      ,[ord_no]
      ,[entered_dt]
      ,[ord_dt]
      ,[oe_po_no]
      ,[cus_no]
      ,[bill_to_name]
      ,[cus_alt_adr_cd]
      ,[ship_to_name]
      ,[ship_via_cd]
      ,[ar_terms_cd]
      ,[ship_instruction_1]
      ,[ship_instruction_2]
      ,[slspsn_no]
      ,[tot_sls_amt]
      ,[tot_sls_disc]
      ,[tot_tax_amt]
      ,[tot_cost]
      ,[misc_amt]
      ,[frt_amt]
      ,[sls_tax_amt_1]
      ,[sls_tax_amt_2]
      ,[sls_tax_amt_3]
      ,[inv_no]
      ,[inv_dt]
      ,[tot_dollars]
      ,[bill_to_no]
      ,[ship_to_city]
      ,[ship_to_state]
      ,[ship_to_zip]
      ,[bill_to_city]
      ,[bill_to_state]
      ,[bill_to_zip]
      ,[line_seq_no]
      ,[item_no]
      ,[loc]
      ,[item_desc_1]
      ,[item_desc_2]
      ,[qty_ordered]
      ,[qty_to_ship]
      ,[unit_price]
      ,[discount_pct]
      ,[request_dt]
      ,[qty_bkord]
      ,[qty_return_to_stk]
      ,[unit_cost]
      ,[prod_cat]
      ,[user_def_fld_1]
      ,[user_def_fld_2]
      ,[user_def_fld_3]
      ,[user_def_fld_4]
      ,[user_def_fld_5]
      ,[sls_amt]
      ,[cost_amt]
      ,Company			
)

SELECT
	    [InvoiceID]				= 'Topix_' + ISNULL(NULLIF(TRIM([ord_no]),'NULL'),'')		+ ' | ' 
										   + ISNULL(NULLIF(TRIM([inv_no]),'NULL'),'')		+ ' | '
										   + ISNULL(NULLIF(TRIM([line_seq_no]),'NULL'),'')	+ ' | '
										   + ISNULL(NULLIF(TRIM([cus_no]),'NULL'),'')		+ ' | ' 
										   + ISNULL(NULLIF(TRIM([item_no]),'NULL'),'')		+ ' | ' 
										 + CAST(ROW_NUMBER() OVER (PARTITION BY [ord_no], [inv_no], [cus_no], [item_no], [line_seq_no] ORDER BY CAST(TRIM(ord_dt) AS DATE), CAST(sls_amt AS MONEY)) AS VARCHAR(10)) 
	  ,[CustomerID]				= 'Topix_' + ISNULL(NULLIF(TRIM(cus_no),'NULL'),'')
	  ,[ItemID]					= 'Topix_' + ISNULL(NULLIF(TRIM([item_no]),'NULL'),'')
	  ,[orig_ord_type]			= ISNULL(NULLIF(TRIM([orig_ord_type]),'NULL'),'')
	  ,[ord_type]				= ISNULL(NULLIF(TRIM([ord_type]),'NULL'),'')
      ,[ord_no]					= ISNULL(NULLIF(TRIM([ord_no]),'NULL'),'')
      ,[entered_dt]				= CAST(NULLIF(TRIM([entered_dt]),'NULL') AS DATE)
      ,[ord_dt]					= CAST(NULLIF(TRIM([ord_dt]),'NULL') AS DATE)
      ,[oe_po_no]				= ISNULL(NULLIF(TRIM([oe_po_no]	),'NULL'),'')
      ,[cus_no]					= ISNULL(NULLIF(TRIM([cus_no]),'NULL'),'')
      ,[bill_to_name]			= ISNULL(NULLIF(TRIM([bill_to_name]),'NULL'),'')
      ,[cus_alt_adr_cd]			= ISNULL(NULLIF(TRIM([cus_alt_adr_cd]),'NULL'),'')
      ,[ship_to_name]			= ISNULL(NULLIF(TRIM([ship_to_name]),'NULL'),'')
      ,[ship_via_cd]			= ISNULL(NULLIF(TRIM([ship_via_cd]),'NULL'),'')
      ,[ar_terms_cd]			= ISNULL(NULLIF(TRIM([ar_terms_cd]),'NULL'),'')
      ,[ship_instruction_1]		= ISNULL(NULLIF(TRIM([ship_instruction_1]),'NULL'),'')
      ,[ship_instruction_2]		= ISNULL(NULLIF(TRIM([ship_instruction_2]),'NULL'),'')
      ,[slspsn_no]				= ISNULL(NULLIF(TRIM([slspsn_no]),'NULL'),'')
      ,[tot_sls_amt]			= CAST(NULLIF(TRIM([tot_sls_amt]),'') AS MONEY)
      ,[tot_sls_disc]			= CAST(NULLIF(TRIM([tot_sls_disc]),'') AS MONEY)
      ,[tot_tax_amt]			= CAST(NULLIF(TRIM([tot_tax_amt]),'') AS MONEY)
      ,[tot_cost]				= CAST(NULLIF(TRIM([tot_cost]),'') AS MONEY)
      ,[misc_amt]				= CAST(NULLIF(TRIM([misc_amt]),'') AS MONEY)
      ,[frt_amt]				= CAST(NULLIF(TRIM([frt_amt]),'') AS MONEY)
      ,[sls_tax_amt_1]			= CAST(NULLIF(TRIM([sls_tax_amt_1]),'') AS MONEY)
      ,[sls_tax_amt_2]			= CAST(NULLIF(TRIM([sls_tax_amt_2]),'') AS MONEY)
      ,[sls_tax_amt_3]			= CAST(NULLIF(TRIM([sls_tax_amt_3]),'') AS MONEY)
      ,[inv_no]					= ISNULL(NULLIF(TRIM([inv_no]),'NULL'),'')
      ,[inv_dt]					= CAST(NULLIF(NULLIF(TRIM([inv_dt]),'NULL'),'') AS DATE)
      ,[tot_dollars]			= CAST(NULLIF(TRIM([tot_dollars]),'NULL') AS MONEY)
      ,[bill_to_no]				= ISNULL(NULLIF(TRIM([bill_to_no]),'NULL'),'')
      ,[ship_to_city]			= ISNULL(NULLIF(TRIM([ship_to_city]),'NULL'),'')
      ,[ship_to_state]			= ISNULL(NULLIF(TRIM([ship_to_state]),'NULL'),'')
      ,[ship_to_zip]			= ISNULL(NULLIF(TRIM([ship_to_zip]),'NULL'),'')
      ,[bill_to_city]			= ISNULL(NULLIF(TRIM([bill_to_city]),'NULL'),'')
      ,[bill_to_state]			= ISNULL(NULLIF(TRIM([bill_to_state]),'NULL'),'')
      ,[bill_to_zip]			= ISNULL(NULLIF(TRIM([bill_to_zip]),'NULL'),'')
      ,[line_seq_no]			= ISNULL(NULLIF(TRIM([line_seq_no]),'NULL'),'')
      ,[item_no]				= ISNULL(NULLIF(TRIM([item_no]),'NULL'),'')
	  ,[loc]					= ISNULL(NULLIF(TRIM([loc]),'NULL'),'')
      ,[item_desc_1]			= ISNULL(NULLIF(TRIM([item_desc_1]),'NULL'),'')
      ,[item_desc_2]			= ISNULL(NULLIF(TRIM([item_desc_2]),'NULL'),'')
      ,[qty_ordered]			= CAST(NULLIF(TRIM([qty_ordered]),'') AS DECIMAL(18,9))
      ,[qty_to_ship]			= CAST(NULLIF(TRIM([qty_to_ship]),'') AS DECIMAL(18,9))
      ,[unit_price]				= CAST(NULLIF(TRIM([unit_price]),'') AS MONEY)
      ,[discount_pct]			= CAST(NULLIF(TRIM([discount_pct]),'') AS DECIMAL(18,9))
      ,[request_dt]				= CAST(NULLIF(TRIM([request_dt]),'NULL') AS DATE)
      ,[qty_bkord]				= CAST(NULLIF(TRIM([qty_bkord]),'') AS DECIMAL(18,9))
      ,[qty_return_to_stk]		= CAST(NULLIF(TRIM([qty_return_to_stk]),'') AS DECIMAL(18,9))
	  ,[unit_cost]				= CAST(NULLIF(TRIM([unit_cost]),'') AS MONEY)
      ,[prod_cat]				= ISNULL(NULLIF(TRIM([prod_cat]),'NULL'),'')
      ,[user_def_fld_1]			= ISNULL(NULLIF(TRIM([user_def_fld_1]),'NULL'),'')
      ,[user_def_fld_2]			= ISNULL(NULLIF(TRIM([user_def_fld_2]),'NULL'),'')
      ,[user_def_fld_3]			= ISNULL(NULLIF(TRIM([user_def_fld_3]),'NULL'),'')
      ,[user_def_fld_4]			= ISNULL(NULLIF(TRIM([user_def_fld_4]),'NULL'),'')
      ,[user_def_fld_5]			= ISNULL(NULLIF(TRIM([user_def_fld_5]),'NULL'),'')
      ,[sls_amt]				= CAST(NULLIF(TRIM([sls_amt]),'') AS MONEY)
      ,[cost_amt]				= CAST(NULLIF(TRIM([cost_amt]),'') AS MONEY)
	  ,Company					=  'Topix'
FROM raw.Topix_Invoices
WHERE TRY_CAST(inv_dt AS Date) > (SELECT MAX(inv_dt) FROM store.Topix_Invoices)


/* 
Code to store processed records for historical purposes and truncate the raw tables.
*/
/*
DECLARE @FromDate AS VARCHAR(10) = (SELECT CAST(MIN(CAST(inv_dt AS DATE)) AS VARCHAR(10)) from raw.Topix_Invoices)
DECLARE @ToDate AS VARCHAR(10) = (SELECT CAST(MAX(CAST(inv_dt AS DATE)) AS VARCHAR(10)) from raw.Topix_Invoices)
INSERT INTO etl.Invoices_Processed
SELECT FileSource = CAST('raw.Derma_Invoices' as NVARCHAR(100))
,	Reason = CAST('Processed records: '  as NVARCHAR(100)) + @FromDate + ' to ' + @ToDate
,	LoadDate = GETDATE()
,   *
FROM raw.Topix_Invoices

TRUNCATE TABLE raw.Topix_Invoices
*/






GO