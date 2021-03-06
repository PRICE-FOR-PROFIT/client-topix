CREATE TABLE [store].[Topiderm_Customers] (
  [CustomerID] [varchar](110) NOT NULL,
  [cus_no] [varchar](100) NULL,
  [cus_name] [varchar](100) NULL,
  [addr_1] [varchar](100) NULL,
  [addr_2] [varchar](100) NULL,
  [addr_3] [varchar](100) NULL,
  [city] [varchar](100) NULL,
  [state] [varchar](100) NULL,
  [zip] [varchar](100) NULL,
  [country] [varchar](100) NULL,
  [start_dt] [date] NULL,
  [slspsn_no] [varchar](100) NULL,
  [fullname] [varchar](100) NULL,
  [cus_type_cd] [varchar](100) NULL,
  [cus_type_desc] [varchar](100) NULL,
  [par_cus_no] [varchar](100) NULL,
  [Parent_Customer_Name] [varchar](100) NULL,
  [ar_terms_cd] [varchar](100) NULL,
  [Terms_cd_Desc] [varchar](100) NULL,
  [dsc_pct] [varchar](100) NULL,
  [user_def_fld_1] [varchar](100) NULL,
  [user_def_fld_2] [varchar](100) NULL,
  [user_def_fld_3] [varchar](100) NULL,
  [user_def_fld_4] [varchar](100) NULL,
  [user_def_fld_5] [varchar](100) NULL,
  [cus_note_1] [varchar](100) NULL,
  [cus_note_2] [varchar](100) NULL,
  [cus_note_3] [varchar](100) NULL,
  [cus_note_4] [varchar](100) NULL,
  [cus_note_5] [varchar](100) NULL,
  [terr] [varchar](100) NULL,
  [Company] [varchar](9) NOT NULL,
  CONSTRAINT [PK_StoreTopiderm_Customers] PRIMARY KEY CLUSTERED ([CustomerID])
)
ON [PRIMARY]
GO