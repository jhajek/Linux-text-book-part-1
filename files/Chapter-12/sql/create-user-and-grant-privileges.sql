-- This code will create a user called 'worker' and allow them to only access 
-- the database via localhost (they have to be on the same system not a remote
-- connection).
CREATE USER 'worker'@'localhost' IDENTIFIED BY 'password';

-- https://wordpress.stackexchange.com/questions/6424/
-- Then we will grant the user the minimum permissions needed to do the job
GRANT CREATE, SELECT, INSERT, UPDATE, DELETE, DROP, ALTER ON  records.* TO 'worker'@'localhost';

-- These step grant privileges to our non-root user `worker`
-- We need to grant permission to the database and the specific tables 
-- Via the `records.*` text 
-- This means all tables under the `records` database
