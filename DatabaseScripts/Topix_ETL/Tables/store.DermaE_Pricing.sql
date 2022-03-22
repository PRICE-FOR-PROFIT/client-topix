CREATE TABLE [store].[DermaE_Pricing] (
  [cd_tp] [varchar](100) NULL,
  [cd_tp_1_cust_no] [varchar](100) NULL,
  [cus_name] [varchar](100) NULL,
  [cd_tp_3_cust_type] [varchar](100) NULL,
  [cus_type_desc] [varchar](100) NULL,
  [cd_tp_1_item_no] [varchar](100) NULL,
  [item_desc_1] [varchar](100) NULL,
  [item_desc_2] [varchar](100) NULL,
  [cd_tp_2_prod_cat] [varchar](100) NULL,
  [prod_cat_desc] [varchar](100) NULL,
  [start_dt] [date] NULL,
  [end_dt] [date] NULL,
  [cd_prc_basis] [varchar](100) NULL,
  [prc_or_disc_1] [decimal](18, 9) NULL,
  [Company] [varchar](6) NOT NULL
)
ON [PRIMARY]
GO