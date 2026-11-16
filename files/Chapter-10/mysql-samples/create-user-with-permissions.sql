-- This file creates a user named worker and passes in the password declared in the environment variables
-- Depending on the user, you may not want CREATE and DELETE permissions

-- ACCESSFROMIP is defined in variables.pkr.hcl as a USER VARIABLE
-- USERPASS is defined in variables.pkr.hcl as a USER VARIABLE non-root-user-for-database-password 

-- GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON posts.* TO worker@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS'; flush privileges;

-- 10.110.%.% is essentially 10.110.0.0/16 the SQL wildcard is % not *
-- $USERNAME and $USERPASS will be passed in via variables file
GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO 'worker'@'127.0.0.1' IDENTIFIED BY 'Goose'; 

FLUSH PRIVILEGES;
