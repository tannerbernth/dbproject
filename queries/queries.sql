# Choosing one from a list of ship types, report the cost of all the parts.
SELECT partID, name, price FROM luxuryParts WHERE luxuryParts.modelName='Aakash' union SELECT * FROM requiredParts;

#List all ships that are partially built but incomplete.
Select ROWID as invoiceNum, custID, modelName, currentCost from invoice WHERE complete=0;

# Find the customer that has paid the most for ships from I4, and how much they have spent. This includes the markup applied to the cost of parts. Include both ships that have been completed for this customer and ships that are currently contracted by this customer.
SELECT customer.ROWID, customer.name FROM aakashrathore.customer,  
(SELECT tempNew.custID from
	(SELECT MAX(temp.markupPrice), temp.custID from 
		(SELECT custID, SUM(currentCost)*500 as markupPrice from aakashrathore.invoice GROUP BY custID) temp GROUP BY custID ORDER BY MAX(temp.markupPrice) desc) tempNew) tempFinal where tempFinal.custID = customer.ROWID and rownum<2;


select name, modelname, currentcost from aakashrathore.customer 
inner join aakashrathore.invoice on aakashrathore.invoice.custid=aakashrathore.customer.rowid;

#Add ships/departments/parts to the database.
# new request
#first check if he's in the database
SELECT * FROM customer where name='nameHERE';
INSERT INTO customer values('nameHere');
INSERT INTO Invoice values(1, 0, 'modelName', 0);
# get the modelName and invoiceNum of the latest entry if you don't know
(SELECT modelName from aakashrathore.invoice WHERE rowid IN (select max(rowid) from aakashrathore.INVOICE));
(SELECT ROWID as invoiceNum from aakashrathore.invoice WHERE rowid IN (select max(rowid) from aakashrathore.INVOICE));
# now we have the invoice number. Insert into shipConstruction now
INSERT INTO aakashrathore.shipConstruction values ((SELECT ROWID as invoiceNum from aakashrathore.invoice WHERE rowid IN (select max(rowid) from aakashrathore.INVOICE)), (SELECT modelName from aakashrathore.invoice WHERE rowid IN (select max(rowid) from aakashrathore.INVOICE)));
#get the last construction ID
(SELECT ROWID as constructionID from aakashrathore.shipConstruction WHERE rowid IN (select max(rowid) from aakashrathore.shipConstruction));
# NOW WE CONSTRUCT THE SHIP

INSERT INTO aakashrathore.listOfModelParts(partID, name, modelName, price, constructionID, added) 
(SELECT partID, name, modelName, price, 
	(SELECT ROWID as constructionID from aakashrathore.shipConstruction WHERE rowid IN 
		(select max(rowid) from aakashrathore.shipConstruction)) as constructionID, 0 as added 
	FROM aakashrathore.luxuryParts WHERE luxuryParts.modelName='Aakash' 
	union 
	SELECT partID, name, 'Aakash' as modelName, price, 
	(SELECT ROWID as constructionID from aakashrathore.shipConstruction WHERE rowid IN 
		(select max(rowid) from aakashrathore.shipConstruction)) as constructionID, 0 as added 
	FROM aakashrathore.requiredParts);



select * from aakashrathore.listofmodelparts where constructionid=(select rowid from aakashrathore.shipconstruction where invoicenum='AAB1BBAAGAAAGe3AAB');

#Scrap a ship under construction (parts cannot be salvaged), including the contract for that ship.
# first check if it is complete or not
SELECT complete from invoice WHERE ROWID='invoice number'
# if not complete, then:

# remove invoice
DELETE from invoice WHERE rowID='the invoiceId to be deleted';
DELETE from shipConstruction WHERE invoiceNum='the invoiceId to be deleted';
# if you don't have construction ID then execute this first:
SELECT ROWID AS constructionID FROM shipConstruction WHERE invoiceNum='the invoiceId to be deleted';

# now delete from listOfModelParts table
DELET from listOfModelParts where constructionID='the constructionID of the current one'


#Add to a ship’s progress by updating which parts of the ship have been built, and the current cost of construction.
#update listOfModelParts first
UPDATE listOfModelParts set added=1 where partID='0' and constructionID='someID';
#now get the price for that part
SELECT price from listofmodelparts where partID='0' and constructionID='someID';
#now update the cost
update invoice set currentCost=(currentCost+price) where rowID = 'invoiceNumberHere';
# if you need to get the invoice number.
SELECT invoiceNum from shipConstruction where rowID='constructionID here';
