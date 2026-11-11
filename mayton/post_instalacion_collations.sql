-- =====================================================================
-- Post-instalación Eneboo en MySQL (Conpro)
-- Sustituye a collatesindices.sql. Lanzar DESPUÉS de instalar y regenerar
-- la base de datos desde Eneboo, y ANTES del proceso creaVistas.
--
--  1. Convierte a utf8_unicode_ci todas las tablas que Eneboo ha dejado en
--     utf8_general_ci (las que crea/reconstruye en cada instalación).
--     No toca utf8_bin, latin1 ni vistas.
--  2. Si v_accesomodulos existe como TABLA (la crea Eneboo al regenerar a
--     partir de su .mtd) y está vacía, la borra para que creaVistas pueda
--     crear la vista.
--  3. No crea índices: ALTER ... CONVERT TO conserva los existentes.
--
-- Uso (MySQL Workbench, con la BD de la empresa seleccionada):
--   a) Ejecutar este fichero entero (rayo). Crea el procedimiento.
--   b) CALL yb_post_instalacion(0);   -- simulación: lista lo que haría
--   c) CALL yb_post_instalacion(1);   -- lo ejecuta (hacer copia antes)
--   d) Lanzar el proceso creaVistas desde Eneboo.
--
-- Cada ALTER bloquea su tabla mientras se reescribe: lanzar fuera de horario.
-- Si una tabla falla, se anota en el resultado y se sigue con las demás.
-- =====================================================================

DROP PROCEDURE IF EXISTS yb_post_instalacion;

DELIMITER $$

CREATE PROCEDURE yb_post_instalacion(IN p_ejecutar TINYINT)
BEGIN
	DECLARE v_fin INT DEFAULT 0;
	DECLARE v_tabla VARCHAR(64);
	DECLARE v_tipo VARCHAR(64) DEFAULT NULL;
	DECLARE cur CURSOR FOR SELECT tabla FROM tmp_yb_tablas ORDER BY tabla;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = 1;

	DROP TEMPORARY TABLE IF EXISTS tmp_yb_log;
	CREATE TEMPORARY TABLE tmp_yb_log (
		n INT AUTO_INCREMENT PRIMARY KEY,
		accion VARCHAR(20),
		tabla VARCHAR(64),
		resultado VARCHAR(15),
		mensaje TEXT
	);

	-- Foto de las tablas a convertir (no recorrer information_schema mientras se alteran)
	DROP TEMPORARY TABLE IF EXISTS tmp_yb_tablas;
	CREATE TEMPORARY TABLE tmp_yb_tablas (tabla VARCHAR(64) PRIMARY KEY);
	INSERT INTO tmp_yb_tablas (tabla)
		SELECT table_name
		FROM information_schema.tables
		WHERE table_schema = DATABASE()
		  AND table_type = 'BASE TABLE'
		  AND table_collation IN ('utf8_general_ci', 'utf8mb3_general_ci')
		  AND table_name NOT LIKE 'v\_%';

	-- 1. Conversión de collation
	OPEN cur;
	bucle: LOOP
		FETCH cur INTO v_tabla;
		IF v_fin = 1 THEN
			LEAVE bucle;
		END IF;

		SET @yb_sql = CONCAT('ALTER TABLE `', v_tabla, '` CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci');

		IF p_ejecutar = 1 THEN
			BEGIN
				DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
				BEGIN
					GET DIAGNOSTICS CONDITION 1 @yb_msg = MESSAGE_TEXT;
					IF @yb_err = 0 THEN
						INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
							VALUES ('CONVERT', v_tabla, 'ERROR', @yb_msg);
					END IF;
					SET @yb_err = 1;
				END;

				SET @yb_err = 0;
				PREPARE yb_st FROM @yb_sql;
				EXECUTE yb_st;
				DEALLOCATE PREPARE yb_st;
				IF @yb_err = 0 THEN
					INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
						VALUES ('CONVERT', v_tabla, 'OK', NULL);
				END IF;
			END;
		ELSE
			INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
				VALUES ('CONVERT', v_tabla, 'SIMULADO', @yb_sql);
		END IF;
	END LOOP;
	CLOSE cur;

	-- 2. v_accesomodulos creada como tabla por la regeneración
	SET v_fin = 0;
	SELECT table_type INTO v_tipo
	FROM information_schema.tables
	WHERE table_schema = DATABASE() AND table_name = 'v_accesomodulos';

	IF v_tipo = 'BASE TABLE' THEN
		SET @yb_n = NULL;
		SET @yb_sql = 'SELECT COUNT(*) INTO @yb_n FROM `v_accesomodulos`';
		PREPARE yb_st FROM @yb_sql;
		EXECUTE yb_st;
		DEALLOCATE PREPARE yb_st;

		IF @yb_n > 0 THEN
			INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
				VALUES ('DROP', 'v_accesomodulos', 'NO BORRADA', CONCAT('Es tabla y tiene ', @yb_n, ' filas: revisar a mano'));
		ELSEIF p_ejecutar = 1 THEN
			DROP TABLE `v_accesomodulos`;
			INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
				VALUES ('DROP', 'v_accesomodulos', 'OK', 'Era tabla vacía. Lanzar ahora creaVistas');
		ELSE
			INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
				VALUES ('DROP', 'v_accesomodulos', 'SIMULADO', 'Es tabla vacía: se borraría');
		END IF;
	ELSEIF v_tipo = 'VIEW' THEN
		INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
			VALUES ('DROP', 'v_accesomodulos', 'NADA', 'Ya es vista');
	ELSE
		INSERT INTO tmp_yb_log (accion, tabla, resultado, mensaje)
			VALUES ('DROP', 'v_accesomodulos', 'NADA', 'No existe: lanzar creaVistas');
	END IF;

	-- Resultado
	SELECT * FROM tmp_yb_log ORDER BY n;

	SELECT table_collation, COUNT(*) AS tablas
	FROM information_schema.tables
	WHERE table_schema = DATABASE() AND table_type = 'BASE TABLE'
	GROUP BY table_collation
	ORDER BY tablas DESC;

	DROP TEMPORARY TABLE IF EXISTS tmp_yb_tablas;
	DROP TEMPORARY TABLE IF EXISTS tmp_yb_log;
END$$

DELIMITER ;
