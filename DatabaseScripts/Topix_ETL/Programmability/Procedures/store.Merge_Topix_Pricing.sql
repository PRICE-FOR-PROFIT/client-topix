SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [store].[Merge_Topix_Pricing]

AS

TRUNCATE TABLE store.Topix_Pricing

INSERT INTO store.Topix_Pricing (
 [cd_tp]				
,[cd_tp_1_cust_no]	
,[cus_name]			
,[cd_tp_3_cust_type]	
,[cus_type_desc]		
,[cd_tp_1_item_no]	
,[item_desc_1]		
,[item_desc_2]		
,[cd_tp_2_prod_cat]	
,[prod_cat_desc]		
,[start_dt]			
,[end_dt]				
,[cd_prc_basis]		
,[prc_or_disc_1]		
,[Company]	
)


SELECT [cd_tp]						= CAST(NULLIF(NULLIF(TRIM([cd_tp]),'NULL'),'')	AS VARCHAR(100))		
      ,[cd_tp_1_cust_no]		    = CAST(NULLIF(NULLIF(TRIM([cd_tp_1_cust_no]),'NULL'),'')	AS VARCHAR(100))
      ,[cus_name]					= CAST(NULLIF(NULLIF(TRIM([cus_name]),'NULL'),'')	AS VARCHAR(100))	
      ,[cd_tp_3_cust_type]			= CAST(NULLIF(NULLIF(TRIM([cd_tp_3_cust_type]),'NULL'),'')	AS VARCHAR(100))
      ,[cus_type_desc]				= CAST(NULLIF(NULLIF(TRIM([cus_type_desc]),'NULL'),'')	AS VARCHAR(100))	
      ,[cd_tp_1_item_no]			= CAST(NULLIF(NULLIF(TRIM([cd_tp_1_item_no]),'NULL'),'')	AS VARCHAR(100))	
      ,[item_desc_1]				= CAST(NULLIF(NULLIF(TRIM([item_desc_1]),'NULL'),'')	AS VARCHAR(100))	
      ,[item_desc_2]				= CAST(NULLIF(NULLIF(TRIM([item_desc_2]),'NULL'),'')	AS VARCHAR(100))	
      ,[cd_tp_2_prod_cat]			= CAST(NULLIF(NULLIF(TRIM([cd_tp_2_prod_cat]),'NULL'),'')	AS VARCHAR(100))	
      ,[prod_cat_desc]				= CAST(NULLIF(NULLIF(TRIM([prod_cat_desc]),'NULL'),'')	AS VARCHAR(100))	
      ,[start_dt]					= CAST(NULLIF(NULLIF(TRIM([start_dt]),'NULL'),'')	AS DATE)	
      ,[end_dt]						= CAST(NULLIF(NULLIF(TRIM([end_dt]),'NULL'),'')	AS DATE)	
      ,[cd_prc_basis]				= CAST(NULLIF(NULLIF(TRIM([cd_prc_basis]),'NULL'),'')	AS VARCHAR(100))	
      ,[prc_or_disc_1]				= CAST(NULLIF(NULLIF(TRIM([prc_or_disc_1]),'NULL'),'')	AS DECIMAL(18,9))	
	  ,[Company]					='Topix'
FROM raw.Topix_Pricing
GO