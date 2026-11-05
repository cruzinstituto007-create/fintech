-- 1. Grupo de lectura analítica (NOLOGIN) y permisos base
CREATE ROLE grp_lectura_analitica NOLOGIN;
GRANT CONNECT ON DATABASE finanzas_db TO grp_lectura_analitica;
GRANT USAGE ON SCHEMA public TO grp_lectura_analitica;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO grp_lectura_analitica;

-- 2. Usuario analista_datos heredando permisos del grupo
CREATE USER analista_datos WITH LOGIN PASSWORD 'AnalistaPass123$' INHERIT;
GRANT grp_lectura_analitica TO analista_datos;

-- 3. Privilegios Futuros para tablas que se creen más adelante
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO grp_lectura_analitica;

-- 4. Cuenta temporal de auditoría con caducidad al 31 de diciembre de 2026
CREATE USER auditor_temporal_pg WITH LOGIN PASSWORD 'TemporalPass123$' INHERIT VALID UNTIL '2026-12-31 23:59:59';
GRANT grp_lectura_analitica TO auditor_temporal_pg;