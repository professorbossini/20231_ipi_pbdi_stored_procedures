DO $$
DECLARE
	valor_total INT;
BEGIN
	CALL sp_calcular_valor_de_um_pedido(1, valor_total);
	RAISE NOTICE 
		'Total do pedido %: R$%',
		1,
		valor_total;
END;
$$


-- CREATE OR REPLACE PROCEDURE sp_calcular_valor_de_um_pedido(
-- 	IN p_cod_pedido INT,
-- 	OUT p_valor_total INT
-- ) LANGUAGE plpgsql AS $$
-- BEGIN
-- 	SELECT 
-- 		--p.cod_pedido, i.cod_item, i.valor
-- 		SUM(i.valor)
-- 	FROM
-- 		tb_pedido p
-- 			INNER JOIN
-- 		tb_item_pedido ip
-- 			ON p.cod_pedido = ip.cod_pedido
-- 			INNER JOIN
-- 		tb_item i
-- 			ON ip.cod_item = i.cod_item
-- 	WHERE p.cod_pedido = p_cod_pedido
-- 	INTO $2;
-- END;
-- $$
		

--pedido
-- 1, 25/04 09h00, 25/04 09h20, aberto, 1
--item/pedido
--1, 1, 1
--2, 2, 1
--3, 1, 1
--item
--1, Refri, 7
--2, Suco, 8
--3, Hamburguer, 12
--4, Batata frita, 9

CALL sp_adicionar_item_a_pedido(2, 1);
SELECT * FROM tb_item_pedido;
SELECT * FROM tb_pedido;
SELECT * FROM tb_item;

-- adicionar um item a um pedido
CREATE OR REPLACE PROCEDURE sp_adicionar_item_a_pedido(
	IN p_cod_item INT,
	IN p_cod_pedido INT
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO tb_item_pedido
	(cod_item, cod_pedido) VALUES
	(p_cod_item, p_cod_pedido);
	UPDATE tb_pedido p SET data_modificacao = CURRENT_TIMESTAMP WHERE p.cod_pedido = $2;
END;
$$

-- SELECT * FROM tb_pedido;

-- DO $$
-- DECLARE
--  cod_pedido INT;
--  cod_cliente INT;
-- BEGIN
-- 	SELECT c.cod_cliente FROM tb_cliente c WHERE nome LIKE 'João da Silva' INTO cod_cliente;
-- 	CALL sp_criar_pedido(cod_pedido, cod_cliente);
-- 	RAISE NOTICE 'Código do pedido recém criado: %', cod_pedido;
-- END;
-- $$


-- CALL sp_cadastrar_cliente('João da Silva');
-- CALL sp_cadastrar_cliente('Maria Santos');
-- CALL sp_cadastrar_cliente('Maria Santos');

-- SELECT * FROM tb_cliente;


-- CREATE OR REPLACE PROCEDURE sp_criar_pedido(
-- 	OUT p_cod_pedido INT,
-- 	IN p_cod_cliente INT
-- ) LANGUAGE plpgsql AS $$

-- BEGIN
-- 	INSERT INTO tb_pedido (cod_cliente) VALUES (p_cod_cliente);
-- 	--LASTVAL é uma função do PostgreSQL que obtém o último valor gerado pelo mecanismo serial
-- 	SELECT LASTVAL() INTO p_cod_pedido;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente(
-- 	IN p_nome VARCHAR(200),
-- 	IN p_codigo INT DEFAULT NULL
-- ) LANGUAGE plpgsql AS $$
-- BEGIN
-- 	IF p_codigo IS NULL THEN
-- 		INSERT INTO tb_cliente(nome) VALUES(p_nome);
-- 	ELSE
-- 		INSERT INTO tb_cliente(cod_cliente, nome) VALUES (p_codigo, p_nome);
-- 	END IF;
-- END;
-- $$

-- CREATE TABLE tb_item_pedido(
-- 	--surrogate key
-- 	cod_item_pedido SERIAL PRIMARY KEY,
-- 	cod_item INT,
-- 	cod_pedido INT,
-- 	CONSTRAINT fk_item FOREIGN KEY (cod_item) REFERENCES tb_item(cod_item),
-- 	CONSTRAINT fk_pedido FOREIGN KEY (cod_pedido) REFERENCES tb_pedido(cod_pedido)
-- );

-- CREATE TABLE tb_item(
-- 	cod_item SERIAL PRIMARY KEY,
-- 	descricao VARCHAR(200) NOT NULL,
-- 	valor NUMERIC(10, 2) NOT NULL,
-- 	cod_tipo INT NOT NULL,
-- 	CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
-- );

-- INSERT INTO tb_item (descricao, valor, cod_tipo)
-- VALUES
-- ('Refrigerante', 7, 1),
-- ('Suco', 8, 1),
-- ('Hamburguer', 12, 2),
-- ('Batata frita', 9, 2);

-- CREATE TABLE tb_item(
-- 	cod_item SERIAL PRIMARY KEY,
-- 	descricao VARCHAR(200) NOT NULL,
-- 	valor NUMERIC(10, 2) NOT NULL,
-- 	cod_tipo INT NOT NULL,
-- 	CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
-- );

-- CREATE TABLE tb_tipo_item(
-- 	cod_tipo SERIAL PRIMARY KEY,
-- 	descricao VARCHAR(200) NOT NULL
-- );

-- INSERT INTO tb_tipo_item (descricao) VALUES ('Bebida'), ('Comida');
-- SELECT * FROM tb_tipo_item;

-- CREATE TABLE tb_pedido(
-- 	cod_pedido SERIAL PRIMARY KEY,
-- 	data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
-- 	data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
-- 	status VARCHAR(200) DEFAULT 'aberto',
-- 	cod_cliente INT NOT NULL,
-- 	CONSTRAINT fk_cliente FOREIGN KEY(cod_cliente) REFERENCES tb_cliente(cod_cliente)
-- );


-- CREATE TABLE tb_cliente(
-- 	cod_cliente SERIAL PRIMARY KEY,
-- 	nome VARCHAR(200) NOT NULL
-- );
