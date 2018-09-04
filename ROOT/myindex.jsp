<!DOCTYPE html>
<%@ 
page import = "java.util.*,
			   java.lang.StringBuffer,
			   dbController.DatabaseController"
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" id="css">
</head>
<body>
<div id="container">
	<div id="selectform">
		<div id="selectbar">
			<ul>
				<li class="nav" id="order">Order</li>
				<li class="nav" id="build">Build</li>
				<li class="nav" id="insertion">Insert</li>
				<li class="nav" id="update">Update</li>
				<li class="nav" id="deletion">Delete</li>
				<li class="nav" id="query">Query</li>
			</ul>
		</div>
		<div class="description" id="desc"></div>
		<div id="formcontainer">
			<div id="default">
				Select a tab to access the database.
			</div>
			<form method="POST" id="form1" class="formsubmit">
				<div id="orderform" class="form">
					<div class="field select">
						<select name="customertype" id="customertype" onchange="select_insert_form(this)">
							<option selected disabled>Customer Type</option>
							<option value="new">New</option> 
							<option value="returning">Returning</option> 
						</select>
					</div>
					<div class="field new options">
						<label class="label">Name</label>
						<input name="name" type="Text">
					</div>
					<div class="field returning options">
						<label class="label">Name</label>
						<input name="name" type="Text">
					</div>
					<div class="field new returning options select">
						<select name="shipmodel">
							<option selected disabled value=""> Select a ship model</option>
							<% 
							DatabaseController db = new DatabaseController();
							db.Open();
							Vector<String> luxuryParts = new Vector<String>();
							luxuryParts = db.getLuxuryParts();
							Vector<String> models = new Vector<String>();
							models = db.getModelNames();
							for (String element : models) { %>
							<option value="<%= element %>"><%= element %></option>
							<% 
							}
							db.Close(); 
							%>
						</select>
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="New Invoice">
						<div class="submit" onclick="request('form1')">New Invoice</div>
					</div>
				</div>
			</form>
				<div id="buildform" class="form">
					<form method="POST" id="form21" class="formsubmit">
						<div class="field">
							<label class="label">Name</label>
							<input type="Text" name="name">
						</div>
						<div class="field">
							<input type="hidden" name="submit" value="Show Invoices">
							<div class="submit" onclick="request('form21')">Show Invoices</div>
						</div>
					</form>
					<form method="POST" id="form22" class="formsubmit">
						<div class="field">
							<label class="label">Invoice Id</label>
							<input type="Text" name="invoiceid">
						</div>
						<div class="field">
							<input type="hidden" name="submit" value="Show Parts">
							<div class="submit" onclick="request('form22')">Show Parts</div>
						</div>
					</form>
					<form method="POST" id="form23" class="formsubmit">
						<div class="field">
							<label class="label">Invoice Id</label>
							<input type="Text" name="invoiceid">
						</div>
						<div class="field">
							<label class="label">Part ID</label>
							<input type="Text" name="partid">
						</div>

						<div class="field">
							<label class="label">Construction ID</label>
							<input type="Text" name="constructionid">
						</div>
						<div class="field">
							<input type="hidden" name="submit" value="Build Part">
							<div class="submit" onclick="request('form23')">Build Part</div>
						</div>
					</form>
				</div>
			<form method="POST" id="form31" class="formsubmit">
				<div id="insertionform" class="form">
					<div class="field select">
						<select id="inserttype" onchange="select_insert_form(this)">
							<option selected disabled>Select Insert Type</option>
							<option value="department">Department</option> 
							<option value="part">Part</option> 
							<option value="ship">Ship</option> 
						</select>
					</div>
					<div class="field department options">
						<label class="label">Dept. Name</label>
						<input type="Text" name="deptname">
					</div>
					<div class="field select department options">
						<select name="shipmodel">
							<option selected disabled>Select a ship model</option>
							<% 
							for (String element : models) { %>
							<option value="<%= element %>"><%= element %></option>
							<% 
							} 
							%>
						</select>
					</div>
					<div class="field department options">
						<input type="hidden" name="submit" value="Insert Department">
						<div class="submit" onclick="request('form31')">Insert Department</div>
					</div>
			</form>
			<form method="POST" id="form32" class="formsubmit">
					<div class="field ship options">
						<label class="label">Model Name</label>
						<input type="Text" name="modelname">
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options select">
						<select name="luxury">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field ship options">
						<input type="hidden" name="submit" value="Insert Ship">
						<div class="submit" onclick="request('form32')">Insert Ship</div>
					</div>
			</form>
			<form method="POST" id="form33" class="formsubmit">
					<div class="field part options">
						<label class="label">Part Name</label>
						<input type="Text" name="part">
					</div>
					<div class="field part options select">
						<select name="parttype">
							<option selected disabled>Select Part Type</option>
							<option value="required">Required</option> 
							<option value="luxury">Luxury</option> 
						</select>
					</div>
					<div class="field part options">
						<label class="label">Price</label>
						<input type="Text" name="price">
					</div>
					<div class="field part options">
						<input type="hidden" name="submit" value="Insert Part">
						<div class="submit" onclick="request('form33')">Insert Part</div>
					</div>
				</div>
			</form>
			<form method="POST" id="form4" class="formsubmit">
				<div id="updateform" class="form">
					<div class="field select">
						<select name="part">
							<option selected disabled value="">Select Luxury Item</option>
							<%
								for (String current : luxuryParts) {
								%>
								<option value="<%= current %>"><%= current %></option>
								<%
								}
							%>
						</select>
					</div>
					<div class="field">
						<label class="label">New Price</label>
						<input type="Text" name="price">
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Update Price">
						<div class="submit" onclick="request('form4')">Update Price</div>
					</div>
				</div>
			</form>
			<form method="POST" id="form51" class="formsubmit">
				<div id="deletionform" class="form">
					<div class="field">
						<label class="label">Name</label>
						<input type="Text" name="name">
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Show Invoices">
						<div class="submit" onclick="request('form51')">Show Invoices</div>
					</div>
			</form>
			<form method="POST" id="form52" class="formsubmit">
					<div class="field">
						<label class="label">Invoice ID</label>
						<input type="Text" name="invoiceid">
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Delete Invoice">
						<div class="submit" onclick="request('form52')">Delete Invoice</div>
					</div>
				</div>
			</form>
			<div id="queryform" class="form">
				<form method="POST" id="form6" class="formsubmit" action="myindex.jsp" onsubmit="model_cost()">
					<div class="field select">
						<select name="shipmodel">
							<option selected disabled>Select a ship model</option>
							<% 
							for (String element : models) { %>
							<option value="<%= element %>"><%= element %></option>
							<% 
							} 
							%>
						</select>
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Model Cost">
						<div class="submit" onclick="request('form6')">Model Cost</div>
					</div>
				</form>
				<form method="POST" id="form7" class="formsubmit">
					<div class="field">
						<input type="hidden" name="submit" value="List Incomplete Ships">
						<div class="submit" onclick="request('form7')">List Incomplete Ships</div>
					</div>
				</form>
				<form method="POST" id="form8" class="formsubmit">
					<div class="field">
						<input type="hidden" name="submit" value="Top Paying Customer">
						<div class="submit" onclick="request('form8')">Top Paying Customer</div>
					</div>
				</form>
				<form method="POST" id="form91" class="formsubmit">
					<div class="field">
						<label class="label">Name</label>
						<input type="Text" name="name">
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Show Customer ID">
						<div class="submit" onclick="request('form91')">Show Customer ID</div>
					</div>
				</form>
				<form method="POST" id="form92" class="formsubmit">
					<div class="field">
						<label class="label">Customer ID</label>
						<input type="Text" name="custid">
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Money Spent">
						<div class="submit" onclick="request('form92')">Money Spent</div>
					</div>
				</form>
				<form method="POST" id="form10" class="formsubmit">
					<div class="field">
						<label class="label">Customer ID</label>
						<input type="Text" name="custid">
					</div>
					<div class="field">
						<input type="hidden" name="submit" value="Completed Ships">
						<div class="submit" onclick="request('form10')">Completed Ships</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="ajaxresponse"></div>
	<div id="footer">
		&copy Tanner Bernth | Ana Huff | Briana Liosatos | Aakash Rathore
	</div>
</div>
<script src="script.js"></script>
</body>
</html>