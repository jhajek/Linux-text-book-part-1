USE store; 

INSERT INTO items (id, email, phone, filename, s3rawurl, s3finishedurl, status, issubscribed) 
VALUES 
(0,"you@hawk.iit.edu","312-555-5678","bestfile.ever","http://raw.example.com","http://finished.example.com",0,0),
(0,"me@hawk.iit.edu","312-555-5677","bestestfile.ever","http://raw.company.com","http://finished.company.com",0,0),
(0,"bobbymcgee@hawk.iit.edu","312-555-5679","okfile.ever","http://raw.freedom.com","http://finished.freedom.com",0,0);
