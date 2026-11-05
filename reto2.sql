USE fintech_db;

-- 1. Creación de Roles
CREATE ROLE rol_gestor_fraude;
GRANT SELECT, INSERT, UPDATE, DELETE ON tb_clientes TO rol_gestor_fraude;
GRANT SELECT, INSERT, UPDATE, DELETE ON tb_tarjetas TO rol_gestor_fraude;

CREATE ROLE rol_atencion_cliente;
GRANT SELECT ON panel_clientes TO rol_atencion_cliente;

-- 2. Usuarios de Negocio con conexión global ('%')
CREATE USER 'jefe_seguridad'@'%' IDENTIFIED BY 'JefePass789$';
CREATE USER 'agente_sara'@'%' IDENTIFIED BY 'SaraPass789$';

-- 3. Asignación de Roles y Activación por Defecto
GRANT rol_gestor_fraude TO 'jefe_seguridad'@'%';
SET DEFAULT ROLE rol_gestor_fraude FOR 'jefe_seguridad'@'%';

GRANT rol_atencion_cliente TO 'agente_sara'@'%';
SET DEFAULT ROLE rol_atencion_cliente FOR 'agente_sara'@'%';

-- 4. Prevención DoS (Usuario bot_extraccion con límite de 3 conexiones)
CREATE USER 'bot_extraccion'@'%' IDENTIFIED BY 'BotPass999$' WITH MAX_USER_CONNECTIONS 3;
GRANT rol_atencion_cliente TO 'bot_extraccion'@'%';
SET DEFAULT ROLE rol_atencion_cliente FOR 'bot_extraccion'@'%';

FLUSH PRIVILEGES;