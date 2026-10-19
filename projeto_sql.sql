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

--------------------------------------- SQL Intermediário --------------------------------------
-------------------------------- União de Tabelas (INNER JOIN) ---------------------------------

-- 1. Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o id do cliente, o status do pedido, o id do produto e o preço do produto.

SELECT 
	o.order_id ,
	o.customer_id ,
	o.order_status ,
	oi.product_id, 
	oi.price 
FROM orders o INNER JOIN order_items oi ON ( oi.order_id = o.order_id )
LIMIT 10;

-- 2. Gerar uma tabela de dados com 20 linhas, contendo o id do pedido, o estado do cliente, a cidade do cliente, o status do pedido, o id do produto e o preço do produto, somente para clientes do estado de São Paulo

SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city,
	o.order_status ,
	oi.product_id, 
	oi.price 
FROM orders o INNER JOIN order_items oi ON ( oi.order_id = o.order_id )
              INNER JOIN customer c     ON ( c.customer_id = o.customer_id )
WHERE c.customer_state = 'SP'
LIMIT 20;

-- 3. Gerar uma tabela de dados com 50 linhas, contendo o id do pedido, o estado  e a cidade do cliente, o status do pedido, o nome da categoria do produto e o preço do produto, somente para pedidos com o status igual a cancelado.
-- Verificar todas as opções da coluna 'order_status'
SELECT
	DISTINCT o.order_status  
FROM orders o

-- Resposta da pergunta de negócio
SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city,
	o.order_status ,
	p.product_category_name ,
	oi.price 
FROM orders o INNER JOIN order_items oi ON ( oi.order_id = o.order_id )
              INNER JOIN customer c     ON ( c.customer_id = o.customer_id )
              INNER JOIN products p     ON ( p.product_id = oi.product_id )
WHERE o.order_status = 'canceled'
LIMIT 50;

-- 4. Gerar uma tabela de dados com 80 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a cidade e o estado do vendedor e a data de aprovação do pedido, somente para os pedidos aprovadas a partir do dia 16 de Setembro de 2016.

SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city,
	o.order_status ,
	p.product_category_name ,
	oi.price,
	s.seller_city,
	s.seller_state,
	o.order_approved_at 
FROM orders o INNER JOIN order_items oi ON ( oi.order_id = o.order_id )
              INNER JOIN customer c     ON ( c.customer_id = o.customer_id )
              INNER JOIN products p     ON ( p.product_id = oi.product_id )
              INNER JOIN sellers s       ON ( s.seller_id = oi.seller_id )
WHERE o.order_approved_at > '2016-09-16 00:00:00'
LIMIT 80;

-- 5. Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a cidade e o estado do vendedor, a data de aprovação do pedido e o tipo de pagamento, somente para o tipo de pagamento igual a boleto.
-- Valores único de pagamento

SELECT
	DISTINCT op.payment_type  
FROM order_payments op

-- Resposta da pergunta de negócio
SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city,
	o.order_status ,
	p.product_category_name ,
	oi.price,
	s.seller_city,
	s.seller_state,
	o.order_approved_at,
	op.payment_type 
FROM orders o INNER JOIN order_items oi 	ON ( oi.order_id = o.order_id )
              INNER JOIN customer c     	ON ( c.customer_id = o.customer_id )
              INNER JOIN products p     	ON ( p.product_id = oi.product_id )
              INNER JOIN sellers s      	ON ( s.seller_id = oi.seller_id )
              INNER JOIN order_payments op  ON ( op.order_id = o.order_id )
WHERE op.payment_type = 'boleto'
LIMIT 10;

-- 6. Gerar uma tabela de dados com 70 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a cidade e o estado do vendedor, a data de aprovação do pedido, tipo de pagamento e a nota de avaliação do produto, somente para os pedidos com a nota de avaliação do produto igual a 1.

SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city,
	o.order_status ,
	p.product_category_name ,
	oi.price,
	s.seller_city,
	s.seller_state,
	o.order_approved_at,
	op.payment_type ,
	or2.review_score 
FROM orders o INNER JOIN order_items oi 	ON ( oi.order_id = o.order_id )
              INNER JOIN customer c     	ON ( c.customer_id = o.customer_id )
              INNER JOIN products p     	ON ( p.product_id = oi.product_id )
              INNER JOIN sellers s      	ON ( s.seller_id = oi.seller_id )
              INNER JOIN order_payments op  ON ( op.order_id = o.order_id )
              INNER JOIN order_reviews or2  ON ( or2.order_id = o.order_id )
WHERE or2.review_score = 1
LIMIT 70;

-------------------------------- União de Tabelas (LEFT JOIN) ---------------------------------

-- 1. Gerar uma tabela de dados com 20 linhas e contendo as seguintes colunas:  1) Id do pedido, 2) status do pedido, 3) id do produto, 4) categoria do produto, 5) avaliação do pedido, 6) valor do pagamento, 7) tipo do pagamento, 8) cidade do vendedor, 9) latitude e longitude da cidade do vendedor.

SELECT 
	o.order_id,
	o.order_status,
	oi.product_id,
	p.product_category_name,
	or2.review_score,
	op.payment_value,
	op.payment_type,
	s.seller_city,
	g.geolocation_lat, 
	g.geolocation_lng 
FROM orders o LEFT JOIN order_items oi    ON ( oi.order_id = o.order_id )
			  LEFT JOIN order_reviews or2 ON ( or2.order_id = o.order_id )
			  LEFT JOIN order_payments op ON ( op.order_id = o.order_id )
			  LEFT JOIN products p        ON ( p.product_id = oi.product_id )
			  LEFT JOIN sellers s         ON ( s.seller_id = oi.seller_id )
			  LEFT JOIN geolocation g     ON ( g.geolocation_zip_code_prefix = s.seller_zip_code_prefix )
LIMIT 20;

-- 2. Quantos tipos de pagamentos foram usados pelo cliente para pagar o pedido 'e481f51cbdc54678b7cc49136f2d6af7’

SELECT 
	o.order_id,
	o.order_status,
	p.product_category_name,
	op.payment_type 
FROM orders o LEFT JOIN order_items oi    ON ( oi.order_id = o.order_id )
			  LEFT JOIN products p        ON ( p.product_id = oi.product_id )
			  LEFT JOIN order_payments op ON ( op.order_id = o.order_id )
WHERE o.order_id = 'e481f51cbdc54678b7cc49136f2d6af7'

# Reposta: 2

-- 3. Quantos pedidos tem mais de 5 items distintos?

SELECT 
	o.order_id,
	COUNT( DISTINCT oi.product_id ) as produt_id 
FROM orders o LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )
GROUP BY o.order_id 
HAVING COUNT( DISTINCT oi.product_id ) > 5

# Resposta: 14 pedidos com mais de 5 items

-- 4. Qual a cardinalidade entre a tabela Pedidos ( orders ) e Avaliações ( reviews )?

SELECT
	o.order_id,
	COUNT( or2.review_id ) AS review_id
FROM orders o LEFT JOIN order_reviews or2 ON ( or2.order_id = o.order_id )
GROUP BY o.order_id 
HAVING COUNT( or2.review_id ) > 1

# Resposta: A Cardinalidade é 1:N. Pois existe mais de uma avaliação para o mesmo pedido.

-- 5. Quantos pedidos (orders) não tem nenhuma avaliação (review) ?

SELECT
	o.order_id,
	or2.review_score 
FROM orders o LEFT JOIN order_reviews or2 ON ( or2.order_id = o.order_id )
WHERE or2.order_id IS NULL

# Resposta: Não há pedidos com nenhuma avaliação.

-- 6. Quais são os top 10 vendedores com mais clientes?

SELECT
	s.seller_id,
	COUNT( c.customer_id ) AS customer_id
FROM orders o  LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )
	 		   LEFT JOIN sellers s ON ( s.seller_id = oi.seller_id ) 
	 		   LEFT JOIN customer c ON ( c.customer_id = o.customer_id)
GROUP BY s.seller_id 
ORDER BY customer_id DESC
LIMIT 10;

-- 7. Quantos pedidos (orders) não possuem nenhum produto (products) ?

SELECT
	COUNT( o.order_id )
FROM orders o  LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )
			   LEFT JOIN products p     ON ( p.product_id = oi.product_id )
WHERE p.product_id IS NULL

# Resposta: 775 pedidos não possuem nenhum produto

-------------------------------- Sub querys ---------------------------------

-- 1. Qual o número de pedido com o tipo de pagamento igual a “boleto”?

SELECT 
	COUNT(o.order_id) AS "qtde pedidos"
FROM orders o 
WHERE o.order_id IN (SELECT op.order_id 
					 FROM order_payments op 
					 WHERE op.payment_type = "boleto"
					)

# Reposta: 19.784 pedidos do tipo boleto

-- 2. Refaça o exercício 01 usando união de tabelas.

SELECT
	COUNT(o.order_id) AS "qtde pedidos"
FROM orders o 
	LEFT JOIN order_payments op 
		ON (op.order_id = o.order_id)
WHERE op.payment_type = "boleto"

-- 3. Cria uma tabela que mostre a média de avaliações por dia, a média de preço por dia, a soma dos preços por dia, o preço mínimo por dia, o número de pedidos por dia e o número de clientes únicos que compraram no dia.

SELECT 



















```sql
# Reposta: 19.784 pedidos do tipo boleto
SELECT 
	COUNT( o.order_id ) AS order_id
FROM orders o
WHERE o.order_id IN ( SELECT DISTINCT op.order_id FROM order_payments 
op WHERE op.payment_type = 'boleto' )
```

### 2. Refaça o exercício 01 usando união de tabelas.

```sql
# Reposta: 19.784 pedidos do tipo boleto

SELECT 
	COUNT( o.order_id ) AS order_id 
FROM orders o LEFT JOIN order_payments op ON ( op.order_id = o.order_id )
WHERE op.payment_type = 'boleto'
```

### 3. Cria uma tabela que mostre a média de avaliações por dia, a média de preço por dia, a soma dos preços por dia, o preço mínimo por dia, o número de pedidos por dia e o número de clientes únicos que compraram no dia.

```sql
SELECT  t1.date_
       ,t1.avg_review
       ,t2.avg_price
       ,t2.sum_price
       ,t2.min_price
       ,t3.pedido_por_dia
       ,t3.clientes_unicos
FROM
(
	SELECT  DATE( review_creation_date ) AS date_
	       ,AVG( review_score )          AS avg_review
	FROM order_reviews or2
	GROUP BY  DATE( review_creation_date )
) AS t1
LEFT JOIN
(
	SELECT  DATE( oi.shipping_limit_date ) AS date_
	       ,AVG( price )                   AS avg_price
	       ,SUM( price )                   AS sum_price
	       ,MIN( price )                   AS min_price
	FROM order_items oi
	GROUP BY  DATE( oi.shipping_limit_date )
) AS t2
ON ( t2.date_ = t1.date_ )
LEFT JOIN
(
	SELECT  DATE( o.order_purchase_timestamp ) AS date_
	       ,COUNT( o.order_id )                AS pedido_por_dia
	       ,COUNT( DISTINCT o.customer_id )    AS clientes_unicos
	FROM orders o
	GROUP BY  DATE( o.order_purchase_timestamp )
) AS t3
ON ( t3.date_ = t1.date_ )
```

### 4. Eu gostaria de saber, por categoria, a quantidade  de produtos, o tamanho médio do produto, o tamanho médio da categoria alimentos e o tamanho médio geral.

```sql
SELECT  
    p.product_category_name,
    COUNT(p.product_id) AS produto,
    AVG(p.product_length_cm) AS avg_length,
    (
        SELECT AVG(p2.product_length_cm)
        FROM products p2
        WHERE p2.product_category_name = 'alimentos'
    ) AS avg_length_alimentos,
    (
        SELECT AVG(p2.product_length_cm)
        FROM products p2
    ) AS avg_length_all
FROM products p
GROUP BY p.product_category_name;

```

### 5. Qual o nome da categoria de produto com o maior preço de venda? Encontre a categoria do produto somente com Subqueries.

```sql
SELECT 
	p.product_category_name
FROM products p 
WHERE p.product_id = 
( SELECT product_id
	 FROM ( SELECT
		product_id,
		MAX( max_product ) AS max_all
  FROM ( SELECT
   				product_id,
	 	   		MAX( price ) as max_product 
				 FROM order_items oi 
			   GROUP BY product_id ) ) )
```
