CSc 460 ReadMe
Aakash Rathore
Ana Huff
Briana Liosatos
Tanner Bernth

How to operate the website to see the required functionalities:

Start the tomcat server on lectura and then go to Address to see the website. The website has tabs that will allow the user to execute queries, order a ship, and make changes to the database (adding to tables, changing values, etc.). Depending on the page, the user’s input is required. A text box or a drop down menu is displayed for the user to make his or her selections. 

The user can order a ship either as a new or returning user by navigating to the “Order” tab. First select whether the user is a new or returning customer and then select the ship model desired for construction. 

Adding to a ship’s progress can be done under the “Build” tab. The user can enter their name to view all of their current invoices. Then the user can use the id from that to display all of the parts for that ship. The part can be built using the invoice id, part id, and the construction id. Once all of the parts of a ship are built, the ship is marked as complete.

New ships/departments/parts can be added to the database by navigating to the “Insert” tab. Adding departments requires selecting department then entering the desired department name and the corresponding ship model that the department will make. Parts can be added by selecting part then entering the desired part name and the price for the part. A ship model can be added by selecting ship and entering a the model name for the new ship. The user can select up to 10 luxury items that will be added to that ships model. 

Prices of parts can be updated from the “Update” tab. Select the luxury item from the list and enter the new price. This will only affect newly added parts of that type.

Invoices can be deleted from the “Delete” tab. Enter the name of the user and click show invoices in order to view all available invoices to choose from. Then copy the  invoice id of the desired invoice targeted for deletion into the invoice id field and the invoice will be deleted along with all of the parts corresponding to that invoice.  

The expected queries and two additional queries can be found under the “Query” tab. For query #1, select a ship model from the drop down select and press “Model Cost” to display the cost for each part of that model. For query #2, press the “List Incomplete Ships” button. For query #3, press the “Top Paying Customer” button. For both additional queries, the user can enter the name of the desired user and press the “Show Customer ID” button to get the id of the customer, which is used for the queries. Enter the user’s customer id into the field and press the “Money Spent” button for the additional query #1. Enter the user’s customer id into the field and press the “Completed Ships” button for the additional query #2.

Workload Distribution:

Aakash Rathore: Helped create the overall design of the database, created tables in the database and populated the tables (backend), created queries, worked on Project Write Up

Ana Huff: Helped create the overall design of the database, wrote methods for the DatabaseController (middle layer), worked on Project Write Up

Briana Liosatos: Helped create the overall design of the database, wrote methods for the DatabaseController (middle layer), worked on Project Write Up

Tanner Bernth: Helped create the overall design of the database, wrote the webpages  (front end), worked on Project Write Up
