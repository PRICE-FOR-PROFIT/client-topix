CREATE TABLE [work].[FirstOrderForCustomer] (
  [Company] [varchar](100) NOT NULL,
  [inv_no] [varchar](100) NOT NULL,
  [CustomerID] [varchar](100) NOT NULL,
  CONSTRAINT [PK_FirstOrderForCustomer] PRIMARY KEY CLUSTERED ([Company], [inv_no])
)
ON [PRIMARY]
GO