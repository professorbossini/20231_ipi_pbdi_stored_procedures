--criar um pedido, como se o cliente entrasse no restaurante e pegasse a comanda
CREATE OR REPLACE PROCEDURE sp_criar_pedido(
	OUT p_cod_pedido INT,
	IN p_cod_cliente INT
) LANGUAGE plpgsql AS $$

BEGIN
	INSERT INTO tb_pedido (cod_cliente) VALUES (p_cod_cliente);
	--LASTVAL é uma função do PostgreSQL que obtém o último valor gerado pelo mecanismo serial
	SELECT LASTVAL() INTO p_cod_pedido;
END;
$$






cadastro de cliente
CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente(
	IN p_nome VARCHAR(200),
	IN p_codigo INT DEFAULT NULL
) LANGUAGE plpgsql AS $$
BEGIN
	IF p_codigo IS NULL THEN
		INSERT INTO tb_cliente(nome) VALUES(p_nome);
	ELSE
		INSERT INTO tb_cliente(cod_cliente, nome) VALUES (p_codigo, p_nome);
	END IF;
END;
$$



CREATE TABLE tb_item_pedido(
	--surrogate key
	cod_item_pedido SERIAL PRIMARY KEY,
	cod_item INT,
	cod_pedido INT,
	CONSTRAINT fk_item FOREIGN KEY (cod_item) REFERENCES tb_item(cod_item),
	CONSTRAINT fk_pedido FOREIGN KEY (cod_pedido) REFERENCES tb_pedido(cod_pedido)
);

item_pedido
(100, 10)
(100, 11)
(101, 10)
(101, 10)

pedido
(100, hoje, hoje, aberto, 1)
(101, ontem, hoje, fechado, 2)

item
(10, 'Hamburguer', 9, 2)
(11, 'Refrigerante', 5, 1)



CREATE TABLE tb_item(
	cod_item SERIAL PRIMARY KEY,
	descricao VARCHAR(200) NOT NULL,
	valor NUMERIC(10, 2) NOT NULL,
	cod_tipo INT NOT NULL,
	CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
);

INSERT INTO tb_item (descricao, valor, cod_tipo)
VALUES
('Refrigerante', 7, 1),
('Suco', 8, 1),
('Hamburguer', 12, 2),
('Batata frita', 9, 2);


CREATE TABLE tb_tipo_item(
	cod_tipo SERIAL PRIMARY KEY,
	descricao VARCHAR(200) NOT NULL
);

INSERT INTO tb_tipo_item (descricao) VALUES ('Bebida'), ('Comida');
SELECT * FROM tb_tipo_item;


CREATE TABLE tb_pedido(
	cod_pedido SERIAL PRIMARY KEY,
	data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status VARCHAR(200) DEFAULT 'aberto',
	cod_cliente INT NOT NULL,
	CONSTRAINT fk_cliente FOREIGN KEY(cod_cliente) REFERENCES tb_cliente(cod_cliente)
);


CREATE TABLE tb_cliente(
	cod_cliente SERIAL PRIMARY KEY,
	nome VARCHAR(200) NOT NULL
);

CREATE OR REPLACE PROCEDURE sp_calcula_media (VARIADIC valores INT [])
LANGUAGE plpgsql
AS $$
DECLARE
	media NUMERIC(10, 2) := 0;
	valor INT;
BEGIN
	FOREACH	 valor IN ARRAY valores LOOP
		media := media + valor;
	END LOOP;
	RAISE NOTICE 'A média é: %', media / array_length(valores, 1);
END;
$$


