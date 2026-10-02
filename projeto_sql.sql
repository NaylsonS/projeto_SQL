----------------------------------------------- SQL Básico -----------------------------------------------

-- 1. Qual o número de clientes únicos do estado de Minas Gerais?

SELECT 
	COUNT( DISTINCT customer_id ) 
FROM customer c 
WHERE customer_state = 'MG'

-- Resposta: 11.635

-- 2. Qual a quantidade de cidades únicas dos vendedores do estado de Santa Catarina?

SELECT 
	COUNT (DISTINCT seller_city )
FROM sellers s
WHERE seller_state = 'SC'

-- Resposta: 65 cidades

-- 3. Qual a quantidade de cidades únicas de todos os vendedores da base?

SELECT 
	COUNT (DISTINCT seller_city )
FROM sellers s

-- Resposta: 611 cidades

-- 4. Qual o número total de pedidos únicos acima de R$ 3.500

SELECT 
	COUNT( DISTINCT order_id )  
FROM order_items oi
WHERE price > 3500

-- Resposta: 18 pedidos únicos

-- 5. Qual o valor médio do preço de todos os pedidos?

SELECT 
	AVG( price )  
FROM order_items oi

-- Resposta: R$ 120.65

-- 6. Qual o maior valor de preço entre todos os pedidos?

SELECT 
	MAX( price )  
FROM order_items oi

-- Resposta: R$ 6.735

-- 7. Qual o menor valor de preço entre todos os pedidos?

SELECT 
	MIN( price )  
FROM order_items oi

-- Resposta: R$ 0.85

-- 8. Qual a quantidade de produtos distintos vendidos abaixo do preço de R$ 100.00?

SELECT 
	COUNT( DISTINCT product_id )  
FROM order_items oi
WHERE price < 100

-- Resposta: 20.112

-- 9. Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de 2016?

SELECT
	COUNT( DISTINCT seller_id )
FROM order_items oi
WHERE shipping_limit_date < '2016-09-23 00:00:00'

-- Resposta: 2 vendedores

-- 10. Quais os tipos de pagamentos existentes?

SELECT 
	DISTINCT payment_type 
FROM order_payments op

-- Resposta: credit_card, boleto, voucher, debit_card, not_defined

-- 11. Qual o maior número de parcelas realizado?

SELECT 
	MAX( payment_installments )  
FROM order_payments op

-- Resposta: 24 parcelas

-- 12. Qual o menor número de parcelas realizado?

SELECT 
	MIN( payment_installments )  
FROM order_payments op

-- Resposta: 0 parcelas

-- 13. Qual a média do valor pago no cartão de crédito?

SELECT 
	AVG( payment_value )  
FROM order_payments op 
WHERE payment_type = 'credit_card'

-- Resposta: R$ 163.32

-- 14. Quantos tipos de status para um pedido existem?

SELECT 
	COUNT( DISTINCT order_status )
FROM orders o

-- Resposta: 8 status de pedidos

-- 15. Quais os tipos de status para um pedido?

SELECT 
	DISTINCT order_status 
FROM orders o

-- Resposta: delivered, invoiced,shipped,processing,unavailable,canceled,created,approved

-- 16. Quantos clientes distintos fizeram um pedido?

SELECT 
	COUNT( DISTINCT customer_id  )
FROM orders o

-- Resposta: 99.441 clientes distintos

-- 17. Quantos produtos estão cadastrados na empresa?

SELECT 
	COUNT( DISTINCT product_id  )
FROM products p

-- Resposta: 32.951 produtos distintos

-- 18. Qual a quantidade máxima de fotos de um produto?

SELECT 
	MAX( product_photos_qty  )
FROM products p

-- Resposta: 20 fotos 

-- 19. Qual  o maior valor do peso entre todos os produtos?

SELECT 
	MAX( DISTINCT product_weight_g  )
FROM products p

-- Resposta: 40.425g

-- 20. Qual a altura média dos produtos?

SELECT 
	AVG( product_height_cm  )
FROM products p

-- Resposta: 16.93 cm

----------------------------------------------- SQL Básico -----------------------------------------------
----------------------------------- Funções Agregadoras e Agrupamentos -----------------------------------

-- 1. Qual o número de clientes únicos de todos os estados?

SELECT 
	c.customer_state ,
	COUNT( DISTINCT c.customer_id ) AS numero_clientes
FROM customer c 
GROUP BY c.customer_state

-- 2. Qual o número de cidades únicas dos clientes de todos os estados?

SELECT 
	customer_state ,
	COUNT( DISTINCT customer_city ) AS numero_cidades
FROM customer c 
GROUP BY customer_state

-- 3. Qual o número de clientes únicos por estado e por cidade?

SELECT 
	c.customer_state,
	c.customer_city ,
	COUNT( DISTINCT c.customer_id  ) AS clientes
FROM customer c 
GROUP BY c.customer_state , c.customer_city

-- 4. Qual o número de clientes únicos por cidade e por estado?

SELECT 
	c.customer_city ,
	c.customer_state,
	COUNT( DISTINCT c.customer_id  ) AS clientes
FROM customer c 
GROUP BY c.customer_city, c.customer_state

-- 5. Qual o número total de pedidos únicos por cada vendedor?

SELECT 
	seller_id,
	COUNT( DISTINCT order_id )  
FROM order_items oi
GROUP BY seller_id

-- 6. Qual o número total de pedidos únicos, a data mínima e máxima de  limite envio, o valor máximo, mínimo e médio do frete dos pedidos por cada vendedor?

SELECT
	seller_id,
	COUNT( DISTINCT order_id ) AS pedidos_unicos,
	MIN( shipping_limit_date ) AS data_minima_envio,
	MAX( shipping_limit_date ) AS data_maxima_envio,
	AVG( freight_value ) AS valor_medio_frete_medio,
	MIN( freight_value) AS valor_minimo_frete,
	MAX( freight_value) AS valor_maximo_frete
FROM order_items oi
GROUP BY seller_id

-- 7. Qual o valor médio, máximo e mínimo do preço de todos os pedidos de cada produto?

SELECT 
	oi.product_id,
	AVG( oi.price ) AS preco_medio,
	MIN( oi.price ) AS preco_minimo,
	MAX( oi.price ) AS preco_maximo
FROM order_items oi
GROUP BY oi.product_id

-- 8. Qual a quantidade de vendedores distintos que receberam algum pedido e o preço médio das vendas?

SELECT  
  COUNT( DISTINCT seller_id ) AS vendedores, 
  AVG( oi.price ) AS preco_medio 
FROM order_items oi
-- Vendedores 3.095 , preco médio 120,65

-- 9. Qual a quantidade de pedidos por tipo de pagamentos?

SELECT 
	payment_type,
	COUNT( op.order_id ) as pedidos 
FROM order_payments op
GROUP BY op.payment_type

-- 10. Qual a quantidade de pedidos, a média do valor do pagamento e o número máximo de parcelas por tipo de pagamentos?

SELECT 
	payment_type,
	COUNT( op.order_id )           AS pedidos,
	AVG( op.payment_value )        AS pagamento_medio,
	MAX( op.payment_installments ) AS maior_numero_parcelas
FROM order_payments op
GROUP BY op.payment_type

-- 11. Qual a valor mínimo, máximo, médio e as soma total paga por cada tipo de pagamento e número de parcelas disponíveis?

SELECT 
	payment_type,
	payment_installments,
	MIN( payment_value ) AS pagamento_minimo,
	MAX( payment_value ) AS pagamento_maximo,
	AVG( payment_value ) AS pagamento_medio,
	SUM( payment_value ) AS pagamento_total
FROM order_payments op 
GROUP BY payment_type, payment_installments

-- 12. Qual a média de preços de produtos?

SELECT 
    product_id,
    AVG(price) AS avg_price
FROM 
    order_items
GROUP BY 
    product_id

-- 13. Qual a quantidade de pedidos por status?

SELECT 
    count(order_id) as qtd_produtos,
    order_status
from orders
GROUP by order_status

-- 14. Qual a quantidade de pedidos realizados por dia? ** OBS: Use o comando DATE( ) para converter de timestamp (data com hora) para apenas data!


SELECT 
	DATE( order_approved_at ) AS data_ ,
	COUNT( order_id  )        AS pedidos
FROM orders o
GROUP BY DATE( order_approved_at )


-- 15. Quantos produtos estão cadastrados na empresa por categoria?

SELECT 
	product_category_name  ,
	COUNT( DISTINCT product_id  ) AS produtos
FROM products p
GROUP BY product_category_name
