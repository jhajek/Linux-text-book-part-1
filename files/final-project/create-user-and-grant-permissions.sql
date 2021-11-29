GRANT CREATE,SELECT, INSERT, UPDATE, DELETE ON wp.* TO worker@'localhost' IDENTIFIED BY 'cluster';
flush privileges;
