CREATE TABLE [work].[Replenix_WholeSalesPriceIncreases] (
  [ItemID] [varchar](100) NOT NULL,
  [item_no] [varchar](100) NULL,
  [Company] [varchar](100) NULL,
  [WHSPrice2021] [decimal](18, 9) NULL,
  [ProdSegmentFromWHSPrices] [nvarchar](255) NULL,
  PRIMARY KEY CLUSTERED ([ItemID])
)
ON [PRIMARY]
GO