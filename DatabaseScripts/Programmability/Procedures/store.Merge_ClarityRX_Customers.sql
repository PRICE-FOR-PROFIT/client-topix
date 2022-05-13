SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [store].[Merge_ClarityRX_Customers]

AS

TRUNCATE TABLE store.ClarityRx_Customers

INSERT INTO store.ClarityRx_Customers (
 [CustomerID]				
,[cus_no]					
,[cus_name]				
,[addr_1]					
,[addr_2]					
,[addr_3]					
,[city]					
,[state]					
,[zip]					
,[country]				
,[start_dt]				
,[slspsn_no]				
,[fullname]				
,[cus_type_cd]			
,[cus_type_desc]			
,[par_cus_no]				
,[Parent_Customer_Name]	
,[ar_terms_cd]			
,[Terms_cd_Desc]			
,[dsc_pct]				
,[user_def_fld_1]			
,[user_def_fld_2]			
,[user_def_fld_3]			
,[user_def_fld_4]			
,[user_def_fld_5]			
,[cus_note_1]				
,[cus_note_2]				
,[cus_note_3]				
,[cus_note_4]				
,[cus_note_5]				
,[terr]					
,[Company]					
)

SELECT [CustomerID]						= 'ClarityRx_' + CAST(NULLIF(TRIM([cus_no]),'NULL')	AS VARCHAR(100))
	  ,[cus_no]							= CAST(NULLIF(TRIM([cus_no]),'NULL')					AS VARCHAR(100))
      ,[cus_name]						= CAST(NULLIF(TRIM([cus_name]),'NULL')				AS VARCHAR(100))
      ,[addr_1]							= CAST(NULLIF(TRIM([addr_1]),'NULL')					AS VARCHAR(100))
      ,[addr_2]							= CAST(NULLIF(TRIM([addr_2]),'NULL')					AS VARCHAR(100))
      ,[addr_3]							= CAST(NULLIF(TRIM([addr_3]),'NULL')					AS VARCHAR(100))
      ,[city]							= CAST(NULLIF(TRIM([city]),'NULL')					AS VARCHAR(100))
      ,[state]							= CAST(NULLIF(TRIM([state]),'NULL')					AS VARCHAR(100))
      ,[zip]							= CAST(NULLIF(TRIM([zip]),'NULL')						AS VARCHAR(100))
      ,[country]						= CAST(NULLIF(TRIM([country]),'NULL')					AS VARCHAR(100))
      ,[start_dt]						= CAST(NULLIF(TRIM([start_dt]),'NULL')				AS DATE)
      ,[slspsn_no]						= CAST(NULLIF(TRIM([slspsn_no]),'NULL')				AS VARCHAR(100))
      ,[fullname]						= CAST(NULLIF(TRIM([fullname]),'NULL')				AS VARCHAR(100))
      ,[cus_type_cd]					= CAST(NULLIF(TRIM([cus_type_cd]),'NULL')				AS VARCHAR(100))
      ,[cus_type_desc]					= CAST(NULLIF(TRIM([cus_type_desc]),'NULL')			AS VARCHAR(100))
      ,[par_cus_no]						= CAST(NULLIF(TRIM([par_cus_no]),'NULL')				AS VARCHAR(100))
      ,[Parent_Customer_Name]			= CAST(NULLIF(TRIM([Parent_Customer_Name]),'NULL')	AS VARCHAR(100))
      ,[ar_terms_cd]					= CAST(NULLIF(TRIM([ar_terms_cd]),'NULL')				AS VARCHAR(100))
      ,[Terms_cd_Desc]					= CAST(NULLIF(TRIM([Terms_cd_Desc]),'NULL')			AS VARCHAR(100))
      ,[dsc_pct]						= CAST(NULLIF(TRIM([dsc_pct]),'NULL')					AS VARCHAR(100))
      ,[user_def_fld_1]					= CAST(NULLIF(TRIM([user_def_fld_1]),'NULL')			AS VARCHAR(100))
      ,[user_def_fld_2]					= CAST(NULLIF(TRIM([user_def_fld_2]),'NULL')			AS VARCHAR(100))
      ,[user_def_fld_3]					= CAST(NULLIF(TRIM([user_def_fld_3]),'NULL')			AS VARCHAR(100))
      ,[user_def_fld_4]					= CAST(NULLIF(TRIM([user_def_fld_4]),'NULL')			AS VARCHAR(100))
      ,[user_def_fld_5]					= CAST(NULLIF(TRIM([user_def_fld_5]),'NULL')			AS VARCHAR(100))
      ,[cus_note_1]						= CAST(NULLIF(TRIM([cus_note_1]),'NULL')				AS VARCHAR(100))
      ,[cus_note_2]						= CAST(NULLIF(TRIM([cus_note_2]),'NULL')				AS VARCHAR(100))
      ,[cus_note_3]						= CAST(NULLIF(TRIM([cus_note_3]),'NULL')				AS VARCHAR(100))
      ,[cus_note_4]						= CAST(NULLIF(TRIM([cus_note_4]),'NULL')				AS VARCHAR(100))
      ,[cus_note_5]						= CAST(NULLIF(TRIM([cus_note_5]),'NULL')				AS VARCHAR(100))
      ,[terr]							= CAST(NULLIF(TRIM([terr]),'NULL')					AS VARCHAR(100))
	  ,[Company]						='ClarityRx'
FROM raw.ClarityRx_Customers
GO