#RequiredItems

INSERT INTO requiredParts VALUES('1L', 'brake', 130);
INSERT INTO requiredParts VALUES('2L', 'tire', 175);
INSERT INTO requiredParts VALUES('3L', 'left wing', 280);
INSERT INTO requiredParts VALUES('4L', 'right wing', 10);
INSERT INTO requiredParts VALUES('5L', 'steering wheel', 1);
INSERT INTO requiredParts VALUES('6L', 'engine', 300);

#luxuryItems

Soda Machine 				7			10
Swimming Pool				8			10000
Tennis Court				9			2000
Dance Floor					10			50
Sound System				11			100
Bowling Alley				12			100000000
Solar Panels				13			50000
Sonar						14			50000
Missile Defence System		15			100000000
Escape pods					16			1

Aakash
Briana
Cana
Dtanner
Elephant
Fail

INSERT INTO luxuryParts values('7R', 'Soda Machine', 'Aakash', 10);
INSERT INTO luxuryParts values('7R', 'Soda Machine', 'Cana', 10);


INSERT INTO luxuryParts values('8R', 'Swimming Pool', 'Aakash', 10000);
INSERT INTO luxuryParts values('8R', 'Swimming Pool', 'Briana', 10000);
INSERT INTO luxuryParts values('8R', 'Swimming Pool', 'Dtanner', 10000);
INSERT INTO luxuryParts values('8R', 'Swimming Pool', 'Elephant', 10000);

INSERT INTO luxuryParts values('9R', 'Tennis Court', 'Aakash', 2000);
INSERT INTO luxuryParts values('9R', 'Tennis Court', 'Elephant', 2000);
INSERT INTO luxuryParts values('9R', 'Tennis Court', 'Fail', 2000);


INSERT INTO luxuryParts values('10R', 'Dance Floor', 'Aakash', 50);
INSERT INTO luxuryParts values('10R', 'Dance Floor', 'Cana', 50);


INSERT INTO luxuryParts values('11R', 'Sound System', 'Aakash', 100);
INSERT INTO luxuryParts values('11R', 'Sound System', 'Briana', 100);
INSERT INTO luxuryParts values('11R', 'Sound System', 'Cana', 100);
INSERT INTO luxuryParts values('11R', 'Sound System', 'Dtanner', 100);
INSERT INTO luxuryParts values('11R', 'Sound System', 'Elephant', 100);
INSERT INTO luxuryParts values('11R', 'Sound System', 'Fail', 100);


INSERT INTO luxuryParts values('12R', 'Bowling Alley', 'Aakash', 100000000);
INSERT INTO luxuryParts values('12R', 'Bowling Alley', 'Briana', 100000000);


INSERT INTO luxuryParts values('13R', 'Solar Panels', 'Aakash', 50000);
INSERT INTO luxuryParts values('13R', 'Solar Panels', 'Dtanner', 50000);
INSERT INTO luxuryParts values('13R', 'Solar Panels', 'Fail', 50000);


INSERT INTO luxuryParts values('14R', 'Sonar', 'Aakash', 50000);
INSERT INTO luxuryParts values('14R', 'Sonar', 'Briana', 50000);
INSERT INTO luxuryParts values('14R', 'Sonar', 'Dtanner', 50000);


INSERT INTO luxuryParts values('15R', 'Missile Defence System', 'Aakash', 100000000);
INSERT INTO luxuryParts values('15R', 'Missile Defence System', 'Briana', 100000000);
INSERT INTO luxuryParts values('15R', 'Missile Defence System', 'Elephant', 100000000);


INSERT INTO luxuryParts values('16R', 'Escape pods', 'Aakash', 1);
INSERT INTO luxuryParts values('16R', 'Escape pods', 'Elephant', 1);


#modelList
INSERT INTO modelList (modelName, markupPrice) VALUES ('Aakash', 500);
INSERT INTO modelList (modelName, markupPrice) VALUES ('Briana', 500);
INSERT INTO modelList (modelName, markupPrice) VALUES ('Cana', 500);
INSERT INTO modelList (modelName, markupPrice) VALUES ('Dtanner', 500);
INSERT INTO modelList (modelName, markupPrice) VALUES ('Elephant', 500);
INSERT INTO modelList (modelName, markupPrice) VALUES ('Fail', 500);

#departments
INSERT INTO department (name, modelName) VALUES ('Darth', 'Aakash');
INSERT INTO department (name, modelName) VALUES ('Palpatine', 'Briana');
INSERT INTO department (name, modelName) VALUES ('Yoda', 'Cana');
INSERT INTO department (name, modelName) VALUES ('Han', 'Dtanner');
INSERT INTO department (name, modelName) VALUES ('Kylo', 'Elephant');
INSERT INTO department (name, modelName) VALUES ('Luke', 'Fail');


