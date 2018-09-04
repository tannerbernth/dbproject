
#custID INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT as ROWID
CREATE TABLE customer(
	name VARCHAR(255)
)

#----------------------------------------------------------------------------------------

#	invoiceNum integer PRIMARY KEY NOT NULL AUTO_INCREMENT as ROWID
CREATE TABLE invoice(
	custID varchar(20) NOT NULL,
	complete integer,
	modelName VARCHAR(255),
	currentCost decimal
);

#----------------------------------------------------------------------------------------

#constructionID PRIMARY KEY NOT NULL AUTO_INCREMENT, as ROWNUM
CREATE TABLE shipConstruction(
	invoiceNum varchar(20) NOT NULL,
	modelName varchar(255)
);

#----------------------------------------------------------------------------------------

#modelID integer PRIMARY KEY NOT NULL AUTO_INCREMENT, as ROWNUM
CREATE TABLE modelList(
	modelName varchar(255) NOT NULL,
	markupPrice decimal NOT NULL
);

#----------------------------------------------------------------------------------------
#deptID integer PRIMARY KEY NOT NULL AUTO_INCREMENT as ROWID

CREATE TABLE department(
	name varchar(255),
	modelName varchar(255)
);

#----------------------------------------------------------------------------------------

CREATE TABLE requiredParts(
	partID varchar2(10) PRIMARY KEY NOT NULL,
	name varchar2(255),
	price decimal NOT NULL
);

#----------------------------------------------------------------------------------------

CREATE TABLE luxuryParts(
	partID varchar2(10) NOT NULL,
	name varchar(255),
	modelName varchar(255) NOT NULL,
	price decimal NOT NULL,
	PRIMARY KEY (partID, modelName)
);

#----------------------------------------------------------------------------------------

CREATE TABLE listOfModelParts(
	partID varchar2(20) NOT NULL,
	name varchar2(255),
	modelName varchar2(255) NOT NULL,
	price decimal NOT NULL,
	constructionID varchar2(20) NOT NULL,
	added integer NOT NULL,
	PRIMARY KEY (partID, constructionID)
);