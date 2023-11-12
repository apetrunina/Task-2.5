-- Задание 1
CREATE TABLE shops (
  shop_id INT PRIMARY KEY,
  shop_name VARCHAR(100)
);

-- Задание 2
WITH all_sales AS (
  SELECT shop_id, product_id, sales_cnt
  FROM sales
  UNION ALL
  SELECT shop_id, product_id, plan_cnt
  FROM plan
)
SELECT sh.shop_name, pr.product_name, 
       SUM(s.sales_cnt) AS sales_fact, 
       SUM(p.plan_cnt) AS sales_plan, 
       SUM(s.sales_cnt)/SUM(p.plan_cnt) AS sales_fact_to_plan, 
       SUM(s.sales_cnt * pr.price) AS income_fact, 
       SUM(p.plan_cnt * pr.price) AS income_plan, 
       SUM(s.sales_cnt * pr.price) / SUM(p.plan_cnt * pr.price) AS income_fact_to_plan
FROM all_sales s
JOIN products pr ON s.product_id = pr.product_id
JOIN shops sh ON s.shop_id = sh.shop_id
GROUP BY sh.shop_name, pr.product_name;
