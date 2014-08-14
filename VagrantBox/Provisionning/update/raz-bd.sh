#!/bin/bash/

# Call the sql script to reset the databases
sudo -u postgres psql -f raz.sql
