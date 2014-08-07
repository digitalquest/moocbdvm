/* Create user pg_reader using password tpinfint */
CREATE USER pg_reader WITH PASSWORD 'tpinfint';

/* Create the vins DB. */
CREATE DATABASE vins;

/* Create the films DB. */
CREATE DATABASE films;

/* Grant USAGE to pg_reader */
GRANT USAGE ON SCHEMA public to pg_reader;

/* Grant connect rights to pg_reader */
GRANT CONNECT ON DATABASE vins TO pg_reader;
GRANT CONNECT ON DATABASE films TO pg_reader;

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

\c vins
GRANT USAGE ON SCHEMA public to pg_reader;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO pg_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pg_reader;
