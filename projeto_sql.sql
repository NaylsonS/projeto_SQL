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