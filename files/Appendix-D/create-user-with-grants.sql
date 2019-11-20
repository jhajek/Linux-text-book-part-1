CREATE USER 'yourname'@'IPGOESHERE' IDENTIFIED BY 'yourpasswordhere';
GRANT ALL ON *.* TO 'yourname'@'IPGOESHERE';

# My example would be
# CREATE USER 'worker'@'192.168.1.239' IDENTIFIED BY 'ilovebunnies';
# GRANT ALL ON *.* TO 'worker'@'192.168.1.239';

