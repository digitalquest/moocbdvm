\c vins
DROP TABLE vins CASCADE;
DROP TABLE recoltes;
DROP TABLE producteurs;

\c films
DROP TABLE films CASCADE;
DROP TABLE acteurs CASCADE;
DROP TABLE realisateurs;
DROP TABLE distributions;

\c postgres
DROP DATABASE vins;
DROP DATABASE films;
CREATE DATABASE vins;
CREATE DATABASE films;

/* Grant USAGE to pg_reader and pg_writer */
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT USAGE ON SCHEMA public to pg_writer;

/* Grant connect rights to pg_reader and pg_writer */
GRANT CONNECT ON DATABASE vins TO pg_reader;
GRANT CONNECT ON DATABASE films TO pg_reader;

GRANT CONNECT ON DATABASE vins TO pg_writer;
GRANT CONNECT ON DATABASE films TO pg_writer;

\c vins
\i ../setup-debian/script-vins.sql;

\c films
\i ../setup-debian/script-film.sql

/* Grant read-only access to these DBs to user pg_reader. */
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pg_reader;

GRANT USAGE ON SCHEMA public to pg_writer;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO pg_writer;

/* Grant access to db vins to the users */
\c vins
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pg_reader;

GRANT USAGE ON SCHEMA public to pg_writer;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO pg_writer;



