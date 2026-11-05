USE fintech_db;

-- INSTALAR EL PLUGIN
INSTALL SONAME 'auth_ed25519';
-- 1. Cuentas con plugin ed25519 y restricciones de IP
CREATE USER 'dba_core'@'172.18.0.1' IDENTIFIED VIA ed25519 USING PASSWORD('ClaveSuperSegura123$');
GRANT ALL PRIVILEGES ON *.* TO 'dba_core'@'172.18.0.1' WITH GRANT OPTION;

CREATE USER 'auditor_externo'@'172.18.0.%' IDENTIFIED VIA ed25519 USING PASSWORD('ClaveAuditor456$');
FLUSH PRIVILEGES;

-- 2. Vista con Data Masking (PAN enmascarado, sin CVV)
CREATE OR REPLACE VIEW v_tarjetas_seguras AS
SELECT 
    c.dni,
    c.nombre_completo,
    c.nivel_riesgo,
    CONCAT('**** **** **** ', RIGHT(t.pan_tarjeta, 4)) AS pan_enmascarado
FROM tb_clientes c
JOIN tb_tarjetas t ON c.id_cliente = t.id_cliente;

-- 3. Ocultación mediante sinónimo (vista en MariaDB)
CREATE OR REPLACE VIEW panel_clientes AS
SELECT * FROM v_tarjetas_seguras;