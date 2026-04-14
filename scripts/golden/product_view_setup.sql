CREATE VIEW gold.dim_products AS
SELECT 
      ROW_NUMBER() OVER(product_id,start_date) AS product_key
      ,[product_id]
      ,[product_number]
      ,[product_name]
      ,[product_line]
      ,[cost]
      ,[start_date]
      ,[category_id]
      ,[category]
      ,[subcategory]
      ,[maintenance]
  FROM [DataWarehouse].[gold].[dim_products]
