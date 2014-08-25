/* Create user pg_reader using password tpinfint */
CREATE USER pg_reader WITH PASSWORD 'tpinfint';

/* Create user pg_admin using password moocbd */
CREATE USER pg_writer WITH PASSWORD 'tpinfint';

/* Create the vins DB. */
CREATE DATABASE vins;

/* Create the films DB. */
CREATE DATABASE films;

/* Grant USAGE to pg_reader and pg_admin */
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT USAGE ON SCHEMA public to pg_writer;

/* Grant connect rights to pg_reader and pg_admin */
GRANT CONNECT ON DATABASE vins TO pg_reader;
GRANT CONNECT ON DATABASE films TO pg_reader;

GRANT CONNECT ON DATABASE vins TO pg_writer;
GRANT CONNECT ON DATABASE films TO pg_writer;

/* Fill the vins DB using the provided sql script. */
\c vins
\i script-vins.sql;

/* Fill the films DB using the provided sql script. */
\c films
\i script-film.sql;

/* Grant read-only access to these DBs to user pg_reader. */
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO pg_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pg_reader;

GRANT USAGE ON SCHEMA public to pg_writer;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO pg_writer;

\c vins
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO pg_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pg_reader;

GRANT USAGE ON SCHEMA public to pg_writer;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO pg_writer;
