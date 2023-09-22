{{ config(schema='transaction') }}

WITH 

  sales AS (SELECT * FROM {{ ref('stg_sales') }} )

  ,product AS (SELECT * FROM {{ ref('stg_product') }})

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id
  ###########
	-- qty --
	,s.qty
  -- revenue --
  ,s.turnover
  -- cost --
  ,purchase_price 
	,ROUND(s.qty*(p.purchase_price),2) AS purchase_cost
	-- margin --
	--,s.revenue - s.quantity*CAST(p.purchSE_PRICE AS FLOAT64) AS product_margin--
	--,ROUND(s.revenue-s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS margin--
    ,{{ margin('s.turnover', 's.qty*(p.purchase_price)')}} AS product_margin
    ,{{ margin_percent('s.turnover', 's.qty*(p.purchase_price)') }} AS product_margin_percent
FROM sales s
INNER JOIN product p ON s.products_id = p.products_id