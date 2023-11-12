--Задание 1

CREATE TABLE products_plan (
  product_id INT,   -- идентификатор продукта
  shop_name VARCHAR(100),   -- название магазина
  plan_cnt INT,   -- количество планируемых продаж
  plan_date DATE,   -- дата планирования
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--Задание 2

SELECT p.shop_name, p.product_name, 
       SUM(sales_cnt) AS sales_fact, 
       SUM(pp.plan_cnt) AS sales_plan, 
       SUM(sales_cnt)/SUM(pp.plan_cnt) AS sales_fact_to_plan, 
       SUM(sales_cnt * pr.price) AS income_fact, 
       SUM(pp.plan_cnt * pr.price) AS income_plan, 
       SUM(sales_cnt * pr.price) / SUM(pp.plan_cnt * pr.price) AS income_fact_to_plan
FROM shop_dns s
JOIN products p ON s.product_id = p.product_id
JOIN plan pp ON p.product_id = pp.product_id
JOIN products pr ON p.product_id = pr.product_id
GROUP BY p.shop_name, p.product_name;