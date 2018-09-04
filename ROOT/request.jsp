<%@ 
page import = "java.util.*,
			   java.lang.StringBuffer,
			   dbController.DatabaseController"
%>
<% 
DatabaseController db = new DatabaseController();
String submitValue = request.getParameter("submit");

if (submitValue.equals("New Invoice")) {
	db.Open();
	String customerType = request.getParameter("customertype");
	String name = request.getParameter("name");
	String modelName = request.getParameter("shipmodel");
	out.write(db.newCustomerAndInvoice(customerType,name,modelName));
	db.Close();
} else if (submitValue.equals("Model Cost")) {
	db.Open();
	String modelName = request.getParameter("shipmodel");
	out.write(db.listModelParts(modelName));
	db.Close();
} else if (submitValue.equals("List Incomplete Ships")) {
	db.Open();
	out.write(db.listIncompleteShips());
	db.Close();
} else if (submitValue.equals("Top Paying Customer")) {
	db.Open();
	out.write(db.topPayingCustomer());
	db.Close();
} else if (submitValue.equals("Insert Part")) {
	db.Open();
	String partName = request.getParameter("part");
	String partType = request.getParameter("parttype");
	String partCost = request.getParameter("price");
	if (db.insertPart(partName, partType, partCost)) {
		out.write("Part added successfully.");
	} else {
		out.write("Failed to insert into db.");
	}
	db.Close();
} else if (submitValue.equals("Insert Department")) {
	db.Open();
	String departmentName = request.getParameter("deptname");
	String modelName = request.getParameter("shipmodel");
	out.write(db.insertDepartment(departmentName, modelName));
	db.Close();
} else if (submitValue.equals("Show Invoices")) {
	db.Open();
	String name = request.getParameter("name");
	out.write(db.showInvoices(name));
	db.Close();
} else if (submitValue.equals("Delete Invoice")) {
	db.Open();	
	String invoiceId = request.getParameter("invoiceid");
	out.write(db.removeInvoice(invoiceId));
	db.Close();
} else if (submitValue.equals("Show Parts")) {
	db.Open();
	String invoiceId = request.getParameter("invoiceid");
	out.write(db.showParts(invoiceId));
	db.Close();
} else if (submitValue.equals("Show Customer ID")) {
	db.Open();
	String name = request.getParameter("name");
	out.write(db.showCustId(name));
	db.Close();
} else if (submitValue.equals("Money Spent")) {
	db.Open();
	String custId = request.getParameter("custid");
	out.write(db.moneySpent(custId));
	db.Close();
} else if (submitValue.equals("Completed Ships")) {
	db.Open();
	String custId = request.getParameter("custid");
	out.write(db.completedShips(custId));
	db.Close();
} else if (submitValue.equals("Build Part")) {
	db.Open();
	String invoiceId = request.getParameter("invoiceid");
	String partId = request.getParameter("partid");
	String constructionId = request.getParameter("constructionid");
	out.write(db.addToShip(partId,constructionId,invoiceId));
	db.Close();
} else if (submitValue.equals("Insert Ship")) {
	db.Open();
	String modelName = request.getParameter("modelname");
	String[] luxury = request.getParameterValues("luxury");
	out.write(db.newShipModel(modelName,luxury));
	db.Close();
} else if (submitValue.equals("Update Price")) {
	db.Open();
	String part = request.getParameter("part");
	String price = request.getParameter("price");
	out.write(db.updatePartPrice(part,price));
	db.Close();
} else {
	out.write("Error. Given submit value not listed. ");
}
%>