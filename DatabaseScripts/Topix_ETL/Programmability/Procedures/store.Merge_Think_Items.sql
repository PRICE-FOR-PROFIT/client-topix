SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [store].[Merge_Think_Items]

AS

TRUNCATE TABLE store.Think_Items

INSERT INTO store.Think_Items (
 [ItemID]				
,[item_no]			
,[item_desc_1]	
,[item_desc_2]		
,[prod_cat]			
,[prod_cat_desc]		
,[mat_cost_type]	
,[mat_cost_desc]		
,[loc]			
,[uom]			
,[activity_cd]	
,[activity_dt]		
,[item_note_1]	
,[item_note_2]	
,[item_note_3]		
,[item_note_4]		
,[item_note_5]	
,[user_def_fld_1]	
,[user_def_fld_2]		
,[user_def_fld_3]	
,[user_def_fld_4]		
,[user_def_fld_5]		
,[price]				
,[avg_cost]			
,[last_cost]			
,[Company]				
)

SELECT [ItemID]							= 'Think_' + CAST(NULLIF([item_no],'NULL')	AS VARCHAR(255))
	  ,[itemno]							= CAST(NULLIF([item_no],'NULL')					AS VARCHAR(255))
      ,[item_desc_1]					= CAST(NULLIF([item_desc_1],'NULL')				AS VARCHAR(255))
      ,[item_desc_2]					= CAST(NULLIF([item_desc_2],'NULL')				AS VARCHAR(255))
      ,[prod_cat]						= CAST(NULLIF([prod_cat],'NULL')				AS VARCHAR(255))
      ,[prod_cat_desc]					= CAST(NULLIF([prod_cat_desc],'NULL')			AS VARCHAR(255))
      ,[mat_cost_type]					= CAST(NULLIF([mat_cost_type],'NULL')			AS VARCHAR(255))
      ,[mat_cost_desc]					= CAST(NULLIF([mat_cost_desc],'NULL')			AS VARCHAR(255))
      ,[loc]							= CAST(NULLIF([loc],'NULL')						AS VARCHAR(255))
      ,[uom]							= CAST(NULLIF([uom],'NULL')						AS VARCHAR(255))
      ,[activity_cd]					= CAST(NULLIF([activity_cd],'NULL')				AS VARCHAR(255))
      ,[activity_dt]					= CAST([activity_dt] AS DATE)
      ,[item_note_1]					= CAST(NULLIF([item_note_1],'NULL')				AS VARCHAR(255))
      ,[item_note_2]					= CAST(NULLIF([item_note_2],'NULL')				AS VARCHAR(255))
      ,[item_note_3]					= CAST(NULLIF([item_note_3],'NULL')				AS VARCHAR(255))
      ,[item_note_4]					= CAST(NULLIF([item_note_4],'NULL')				AS VARCHAR(255))
      ,[item_note_5]					= CAST(NULLIF([item_note_5],'NULL')				AS VARCHAR(255))
      ,[user_def_fld_1]					= CAST(NULLIF([user_def_fld_1],'NULL')			AS VARCHAR(255))
      ,[user_def_fld_2]					= CAST(NULLIF([user_def_fld_2],'NULL')			AS VARCHAR(255))
      ,[user_def_fld_3]					= CAST(NULLIF([user_def_fld_3],'NULL')			AS VARCHAR(255))
      ,[user_def_fld_4]					= CAST(NULLIF([user_def_fld_4],'NULL')			AS VARCHAR(255))
      ,[user_def_fld_5]					= CAST(NULLIF([user_def_fld_5],'NULL')			AS VARCHAR(255))
      ,[price]							= CAST(NULLIF(CASE WHEN [price] LIKE '%E%' THEN '0' ELSE [price] END,'NULL') AS DECIMAL(18,9))
      ,[avg_cost]						= CAST(NULLIF(CASE WHEN [avg_cost] LIKE '%E%' THEN '0' ELSE [avg_cost] END,'NULL') AS DECIMAL(18,9))
      ,[last_cost]						= CAST(NULLIF(CASE WHEN [last_cost] LIKE '%E%' THEN '0' ELSE [last_cost] END,'NULL') AS DECIMAL(18,9))
	  ,[Company]							='Think'
FROM raw.Think_Items
GO