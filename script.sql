CREATE OR REPLACE PROCEDURE sp_acha_maior
(OUT p_resultado INT, IN p_valor1 INT, IN p_valor2 INT)
LANGUAGE plpgsql
AS $$
BEGIN
	CASE
		WHEN p_valor1 > p_valor2 THEN
			$1 := p_valor1;
		ELSE
			p_resultado := p_valor2;
	END CASE;
END;
$$







DROP PROCEDURE IF EXISTS sp_acha_maior;
CREATE OR REPLACE PROCEDURE sp_acha_maior
(INOUT p_valor1 INT, p_valor2 INT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF p_valor2 > p_valor1 THEN
		p_valor1 := p_valor2;
	END IF;
END;
$$
DO $$
DECLARE
	valor1 INT := 2;
	valor2 INT := 3;
BEGIN
	CALL sp_acha_maior(2, 3);
	RAISE NOTICE 'Maior: %', valor1;
END;
$$


CREATE OR REPLACE PROCEDURE sp_acha_maior
(OUT p_resultado INT, IN p_valor1 INT, IN p_valor2 INT)
LANGUAGE plpgsql
AS $$
BEGIN
	CASE
		WHEN p_valor1 > p_valor2 THEN
			$1 := p_valor1;
		ELSE
			p_resultado := p_valor2;
	END CASE;
END;
$$


-- DO 
-- DECLARE
-- 	resultado INT;
-- BEGIN
-- 	CALL sp_acha_maior(resultado, 2, 3);
-- 	RAISE NOTICE '% é o maior', resultado;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_acha_maior
-- (IN p_valor1 INT, p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- 	IF p_valor1 > p_valor2 THEN
-- 		RAISE NOTICE '% é o maior', $1;
-- 	ELSE
-- 		RAISE NOTICE '% é o maior', $2;
-- 	END IF;
-- END;
-- $$

-- CALL sp_acha_maior(2, 3);

-- --criando
-- CREATE OR REPLACE PROCEDURE sp_ola_usuario
-- (nome VARCHAR(200))
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- 	--acessando o parâmetro pelo nome
-- 	RAISE NOTICE 'olá, %', nome;
-- 	--assim também dá
-- 	RAISE NOTICE 'olá, %', $1;
-- END;
-- $$

-- mensagem VARCHAR(200)
-- --colocando em execução
-- CALL sp_ola_usuario('Pedro', mensagem);
-- RAISE NOTICE ('%', mensagem);

-- a INT := 2;
-- b INT := 3;
-- resultado INT;

-- CALL sp_somar(a, b);

-- RAISE NOTICE 'Resultado: %', resultado;





-- criar o procedimento
-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- 	RAISE NOTICE 'Olá, procedures';
-- END;
-- $$
-- --chamar (colocar em execução)
-- CALL sp_ola_procedures();

