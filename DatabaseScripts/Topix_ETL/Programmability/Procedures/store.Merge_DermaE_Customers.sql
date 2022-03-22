SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [store].[Merge_DermaE_Customers]

AS

BEGIN TRANSACTION
DECLARE @archive TABLE
(
      ActionType VARCHAR(50)
	, ID	VARCHAR(50)
);

MERGE store.DermaE_Customers AS tar
USING raw.DermaE_Customers AS src
ON tar.[CustomerID] = 'DermaE_' + CAST(NULLIF(TRIM(src.[cus_no]),'NULL')	AS VARCHAR(100))
WHEN MATCHED THEN
   UPDATE SET
       tar.[CustomerID]				= tar.[CustomerID]				--= 'DermaE_' + CAST(NULLIF(TRIM(src.[cus_no]),'NULL')		AS VARCHAR(100))
	  ,tar.[cus_no]					= tar.[cus_no]					--= CAST(NULLIF(TRIM(src.[cus_no]),'NULL')					AS VARCHAR(100))
      ,tar.[cus_name]				= tar.[cus_name]				--= CAST(NULLIF(TRIM(src.[cus_name]),'NULL')					AS VARCHAR(100))
      ,tar.[addr_1]					= tar.[addr_1]					--= CAST(NULLIF(TRIM(src.[addr_1]),'NULL')					AS VARCHAR(100))
      ,tar.[addr_2]					= tar.[addr_2]					--= CAST(NULLIF(TRIM(src.[addr_2]),'NULL')					AS VARCHAR(100))
      ,tar.[addr_3]					= tar.[addr_3]					--= CAST(NULLIF(TRIM(src.[addr_3]),'NULL')					AS VARCHAR(100))
      ,tar.[city]					= tar.[city]					--= CAST(NULLIF(TRIM(src.[city]),'NULL')						AS VARCHAR(100))
      ,tar.[state]					= tar.[state]					--= CAST(NULLIF(TRIM(src.[state]),'NULL')						AS VARCHAR(100))
      ,tar.[zip]					= tar.[zip]					--= CAST(NULLIF(TRIM(src.[zip]),'NULL')						AS VARCHAR(100))
      ,tar.[country]				= tar.[country]				--= CAST(NULLIF(TRIM(src.[country]),'NULL')					AS VARCHAR(100))
      ,tar.[start_dt]				= tar.[start_dt]				--= CAST(NULLIF(TRIM(src.[start_dt]),'NULL')					AS DATE)
      ,tar.[slspsn_no]				= tar.[slspsn_no]				--= CAST(NULLIF(TRIM(src.[slspsn_no]),'NULL')					AS VARCHAR(100))
      ,tar.[fullname]				= tar.[fullname]				--= CAST(NULLIF(TRIM(src.[fullname]),'NULL')					AS VARCHAR(100))
      ,tar.[cus_type_cd]			= tar.[cus_type_cd]			--= CAST(NULLIF(TRIM(src.[cus_type_cd]),'NULL')				AS VARCHAR(100))
      ,tar.[cus_type_desc]			= tar.[cus_type_desc]			--= CAST(NULLIF(TRIM(src.[cus_type_desc]),'NULL')				AS VARCHAR(100))
      ,tar.[par_cus_no]				= tar.[par_cus_no]				--= CAST(NULLIF(TRIM(src.[par_cus_no]),'NULL')				AS VARCHAR(100))
      ,tar.[Parent_Customer_Name]	= tar.[Parent_Customer_Name]	--= CAST(NULLIF(TRIM(src.[Parent_Customer_Name]),'NULL')		AS VARCHAR(100))
      ,tar.[ar_terms_cd]			= tar.[ar_terms_cd]			--= CAST(NULLIF(TRIM(src.[ar_terms_cd]),'NULL')				AS VARCHAR(100))
      ,tar.[Terms_cd_Desc]			= tar.[Terms_cd_Desc]			--= CAST(NULLIF(TRIM(src.[Terms_cd_Desc]),'NULL')				AS VARCHAR(100))
      ,tar.[dsc_pct]				= tar.[dsc_pct]				--= CAST(NULLIF(TRIM(src.[dsc_pct]),'NULL')					AS VARCHAR(100))
      ,tar.[user_def_fld_1]			= tar.[user_def_fld_1]			--= CAST(NULLIF(TRIM(src.[user_def_fld_1]),'NULL')			AS VARCHAR(100))
      ,tar.[user_def_fld_2]			= tar.[user_def_fld_2]			--= CAST(NULLIF(TRIM(src.[user_def_fld_2]),'NULL')			AS VARCHAR(100))
      ,tar.[user_def_fld_3]			= tar.[user_def_fld_3]			--= CAST(NULLIF(TRIM(src.[user_def_fld_3]),'NULL')			AS VARCHAR(100))
      ,tar.[user_def_fld_4]			= tar.[user_def_fld_4]			--= CAST(NULLIF(TRIM(src.[user_def_fld_4]),'NULL')			AS VARCHAR(100))
      ,tar.[user_def_fld_5]			= tar.[user_def_fld_5]			--= CAST(NULLIF(TRIM(src.[user_def_fld_5]),'NULL')			AS VARCHAR(100))
      ,tar.[cus_note_1]				= tar.[cus_note_1]				--= CAST(NULLIF(TRIM(src.[cus_note_1]),'NULL')				AS VARCHAR(100))
      ,tar.[cus_note_2]				= tar.[cus_note_2]				--= CAST(NULLIF(TRIM(src.[cus_note_2]),'NULL')				AS VARCHAR(100))
      ,tar.[cus_note_3]				= tar.[cus_note_3]				--= CAST(NULLIF(TRIM(src.[cus_note_3]),'NULL')				AS VARCHAR(100))
      ,tar.[cus_note_4]				= tar.[cus_note_4]				--= CAST(NULLIF(TRIM(src.[cus_note_4]),'NULL')				AS VARCHAR(100))
      ,tar.[cus_note_5]				= tar.[cus_note_5]				--= CAST(NULLIF(TRIM(src.[cus_note_5]),'NULL')				AS VARCHAR(100))
      ,tar.[terr]					= tar.[terr]					--= CAST(NULLIF(TRIM(src.[terr]),'NULL')						AS VARCHAR(100))
	  ,tar.[Company]				= tar.[Company]				--='DermaE'
 
WHEN NOT MATCHED THEN
INSERT
(
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

   VALUES
   (
      /* [CustomerID]			=	*/		 'DermaE_' + CAST(NULLIF(TRIM([cus_no]),'NULL')	AS VARCHAR(100))
	  /*,[cus_no]				=	*/		, CAST(NULLIF(TRIM([cus_no]),'NULL')					AS VARCHAR(100))
      /*,[cus_name]				=	*/		, CAST(NULLIF(TRIM([cus_name]),'NULL')				AS VARCHAR(100))
      /*,[addr_1]				=	*/		, CAST(NULLIF(TRIM([addr_1]),'NULL')					AS VARCHAR(100))
      /*,[addr_2]				=	*/		, CAST(NULLIF(TRIM([addr_2]),'NULL')					AS VARCHAR(100))
      /*,[addr_3]				=	*/		, CAST(NULLIF(TRIM([addr_3]),'NULL')					AS VARCHAR(100))
      /*,[city]					=	*/		, CAST(NULLIF(TRIM([city]),'NULL')					AS VARCHAR(100))
      /*,[state]				=	*/		, CAST(NULLIF(TRIM([state]),'NULL')					AS VARCHAR(100))
      /*,[zip]					=	*/		, CAST(NULLIF(TRIM([zip]),'NULL')						AS VARCHAR(100))
      /*,[country]				=	*/		, CAST(NULLIF(TRIM([country]),'NULL')					AS VARCHAR(100))
      /*,[start_dt]				=	*/		, CAST(NULLIF(TRIM([start_dt]),'NULL')				AS DATE)
      /*,[slspsn_no]			=	*/		, CAST(NULLIF(TRIM([slspsn_no]),'NULL')				AS VARCHAR(100))
      /*,[fullname]				=	*/		, CAST(NULLIF(TRIM([fullname]),'NULL')				AS VARCHAR(100))
      /*,[cus_type_cd]			=	*/		, CAST(NULLIF(TRIM([cus_type_cd]),'NULL')				AS VARCHAR(100))
      /*,[cus_type_desc]		=	*/		, CAST(NULLIF(TRIM([cus_type_desc]),'NULL')			AS VARCHAR(100))
      /*,[par_cus_no]			=	*/		, CAST(NULLIF(TRIM([par_cus_no]),'NULL')				AS VARCHAR(100))
      /*,[Parent_Customer_Name]	=	*/		, CAST(NULLIF(TRIM([Parent_Customer_Name]),'NULL')	AS VARCHAR(100))
      /*,[ar_terms_cd]			=	*/		, CAST(NULLIF(TRIM([ar_terms_cd]),'NULL')				AS VARCHAR(100))
      /*,[Terms_cd_Desc]		=	*/		, CAST(NULLIF(TRIM([Terms_cd_Desc]),'NULL')			AS VARCHAR(100))
      /*,[dsc_pct]				=	*/		, CAST(NULLIF(TRIM([dsc_pct]),'NULL')					AS VARCHAR(100))
      /*,[user_def_fld_1]		=	*/		, CAST(NULLIF(TRIM([user_def_fld_1]),'NULL')			AS VARCHAR(100))
      /*,[user_def_fld_2]		=	*/		, CAST(NULLIF(TRIM([user_def_fld_2]),'NULL')			AS VARCHAR(100))
      /*,[user_def_fld_3]		=	*/		, CAST(NULLIF(TRIM([user_def_fld_3]),'NULL')			AS VARCHAR(100))
      /*,[user_def_fld_4]		=	*/		, CAST(NULLIF(TRIM([user_def_fld_4]),'NULL')			AS VARCHAR(100))
      /*,[user_def_fld_5]		=	*/		, CAST(NULLIF(TRIM([user_def_fld_5]),'NULL')			AS VARCHAR(100))
      /*,[cus_note_1]			=	*/		, CAST(NULLIF(TRIM([cus_note_1]),'NULL')				AS VARCHAR(100))
      /*,[cus_note_2]			=	*/		, CAST(NULLIF(TRIM([cus_note_2]),'NULL')				AS VARCHAR(100))
      /*,[cus_note_3]			=	*/		, CAST(NULLIF(TRIM([cus_note_3]),'NULL')				AS VARCHAR(100))
      /*,[cus_note_4]			=	*/		, CAST(NULLIF(TRIM([cus_note_4]),'NULL')				AS VARCHAR(100))
      /*,[cus_note_5]			=	*/		, CAST(NULLIF(TRIM([cus_note_5]),'NULL')				AS VARCHAR(100))
      /*,[terr]					=	*/		, CAST(NULLIF(TRIM([terr]),'NULL')					AS VARCHAR(100))
	  /*,[Company]				=	*/		,'DermaE'
	 	
   )
--WHEN NOT MATCHED BY SOURCE THEN
--   DELETE
OUTPUT
   $action  AS ActionType
,  'DermaE_' + CAST(NULLIF(TRIM(src.[cus_no]),'NULL')		AS VARCHAR(100))	AS ID
INTO @archive;

SELECT  ActionType
	, COUNT(*) AS ActionCount 
FROM  @archive 
GROUP BY ActionType

--ROLLBACK;
COMMIT;			

--select * from store.DermaE_Customers



--TRUNCATE TABLE store.DermaE_Customers

--INSERT INTO store.DermaE_Customers (
-- [CustomerID]				
--,[cus_no]					
--,[cus_name]				
--,[addr_1]					
--,[addr_2]					
--,[addr_3]					
--,[city]					
--,[state]					
--,[zip]					
--,[country]				
--,[start_dt]				
--,[slspsn_no]				
--,[fullname]				
--,[cus_type_cd]			
--,[cus_type_desc]			
--,[par_cus_no]				
--,[Parent_Customer_Name]	
--,[ar_terms_cd]			
--,[Terms_cd_Desc]			
--,[dsc_pct]				
--,[user_def_fld_1]			
--,[user_def_fld_2]			
--,[user_def_fld_3]			
--,[user_def_fld_4]			
--,[user_def_fld_5]			
--,[cus_note_1]				
--,[cus_note_2]				
--,[cus_note_3]				
--,[cus_note_4]				
--,[cus_note_5]				
--,[terr]					
--,[Company]					
--)

--SELECT [CustomerID]						= 'DermaE_' + CAST(NULLIF(TRIM([cus_no]),'NULL')	AS VARCHAR(100))
--	  ,[cus_no]							= CAST(NULLIF(TRIM([cus_no]),'NULL')					AS VARCHAR(100))
--      ,[cus_name]						= CAST(NULLIF(TRIM([cus_name]),'NULL')				AS VARCHAR(100))
--      ,[addr_1]							= CAST(NULLIF(TRIM([addr_1]),'NULL')					AS VARCHAR(100))
--      ,[addr_2]							= CAST(NULLIF(TRIM([addr_2]),'NULL')					AS VARCHAR(100))
--      ,[addr_3]							= CAST(NULLIF(TRIM([addr_3]),'NULL')					AS VARCHAR(100))
--      ,[city]							= CAST(NULLIF(TRIM([city]),'NULL')					AS VARCHAR(100))
--      ,[state]							= CAST(NULLIF(TRIM([state]),'NULL')					AS VARCHAR(100))
--      ,[zip]							= CAST(NULLIF(TRIM([zip]),'NULL')						AS VARCHAR(100))
--      ,[country]						= CAST(NULLIF(TRIM([country]),'NULL')					AS VARCHAR(100))
--      ,[start_dt]						= CAST(NULLIF(TRIM([start_dt]),'NULL')				AS DATE)
--      ,[slspsn_no]						= CAST(NULLIF(TRIM([slspsn_no]),'NULL')				AS VARCHAR(100))
--      ,[fullname]						= CAST(NULLIF(TRIM([fullname]),'NULL')				AS VARCHAR(100))
--      ,[cus_type_cd]					= CAST(NULLIF(TRIM([cus_type_cd]),'NULL')				AS VARCHAR(100))
--      ,[cus_type_desc]					= CAST(NULLIF(TRIM([cus_type_desc]),'NULL')			AS VARCHAR(100))
--      ,[par_cus_no]						= CAST(NULLIF(TRIM([par_cus_no]),'NULL')				AS VARCHAR(100))
--      ,[Parent_Customer_Name]			= CAST(NULLIF(TRIM([Parent_Customer_Name]),'NULL')	AS VARCHAR(100))
--      ,[ar_terms_cd]					= CAST(NULLIF(TRIM([ar_terms_cd]),'NULL')				AS VARCHAR(100))
--      ,[Terms_cd_Desc]					= CAST(NULLIF(TRIM([Terms_cd_Desc]),'NULL')			AS VARCHAR(100))
--      ,[dsc_pct]						= CAST(NULLIF(TRIM([dsc_pct]),'NULL')					AS VARCHAR(100))
--      ,[user_def_fld_1]					= CAST(NULLIF(TRIM([user_def_fld_1]),'NULL')			AS VARCHAR(100))
--      ,[user_def_fld_2]					= CAST(NULLIF(TRIM([user_def_fld_2]),'NULL')			AS VARCHAR(100))
--      ,[user_def_fld_3]					= CAST(NULLIF(TRIM([user_def_fld_3]),'NULL')			AS VARCHAR(100))
--      ,[user_def_fld_4]					= CAST(NULLIF(TRIM([user_def_fld_4]),'NULL')			AS VARCHAR(100))
--      ,[user_def_fld_5]					= CAST(NULLIF(TRIM([user_def_fld_5]),'NULL')			AS VARCHAR(100))
--      ,[cus_note_1]						= CAST(NULLIF(TRIM([cus_note_1]),'NULL')				AS VARCHAR(100))
--      ,[cus_note_2]						= CAST(NULLIF(TRIM([cus_note_2]),'NULL')				AS VARCHAR(100))
--      ,[cus_note_3]						= CAST(NULLIF(TRIM([cus_note_3]),'NULL')				AS VARCHAR(100))
--      ,[cus_note_4]						= CAST(NULLIF(TRIM([cus_note_4]),'NULL')				AS VARCHAR(100))
--      ,[cus_note_5]						= CAST(NULLIF(TRIM([cus_note_5]),'NULL')				AS VARCHAR(100))
--      ,[terr]							= CAST(NULLIF(TRIM([terr]),'NULL')					AS VARCHAR(100))
--	  ,[Company]							='DermaE'
--FROM raw.DermaE_Customers1
GO