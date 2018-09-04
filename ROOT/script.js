/*---------------------------------------------------
 * Tanner Bernth
 * Ana Huff
 * Briana Liosatos
 * Aakash Rathore
 * 
 * Program #4: Database-driven Web Application
 * 
 * Javascript file for dynamic webpage. AJAX is 
 * used for a further dynamic database experience.
 *---------------------------------------------------*/

var nav_order = document.getElementById("order");
var nav_build = document.getElementById("build");
var nav_insertion = document.getElementById("insertion");
var nav_deletion = document.getElementById("deletion");
var nav_update = document.getElementById("update");
var nav_query = document.getElementById("query");

nav_order.addEventListener("click",toggle_form);
nav_build.addEventListener("click",toggle_form);
nav_insertion.addEventListener("click", toggle_form);
nav_deletion.addEventListener("click", toggle_form);
nav_update.addEventListener("click", toggle_form);
nav_query.addEventListener("click", toggle_form);

var default_hidden = false;

// Makes it so the user cannot submit the forms
// with the enter key
var all_forms = document.getElementsByTagName("form");
for (var i = 0; i < all_forms.length; i++) {
	all_forms[i].addEventListener("submit", function(e) {
		e.preventDefault();
		return false;
	});
}

/*---------------------------------------------------
 * toggle_form()
 *---------------------------------------------------
 * Toggles all of the fields for each of the 
 * navigation bar tabs to give the user the illusion
 * of a true navigation bar.
 *---------------------------------------------------*/
function toggle_form() {
	for (var i = 0; i < all_forms.length; i++) {
		all_forms[i].reset();
	}
	if (!default_hidden) {
		document.getElementById("default").style.display = "none";
		default_hidden = true;
	}
	var description = document.getElementById("desc");
	description.innerHTML = "- Database " + this.id.charAt(0).toUpperCase() + this.id.substring(1) + " -";
	var insertform = document.getElementById("formcontainer");
	var children = insertform.getElementsByClassName("form");

	for (var i = 0; i < children.length; i++) {
		children[i].style.display = "none";
	}
	document.getElementById(this.id+"form").style.display = "block";
}

/*---------------------------------------------------
 * select_insert_form()
 *---------------------------------------------------
 * Toggles the form elements visible to the user
 * based on the dropdown select fields.
 *---------------------------------------------------*/
function select_insert_form(dropdown) {
	var type = dropdown;
	var selected = type.options[type.selectedIndex].value;
	var options = document.getElementsByClassName(selected);
	var all_options = document.getElementsByClassName("options");
	for (var i = 0; i < all_options.length; i++) {
		all_options[i].style.display = "none";
	}
	for (var i = 0; i < options.length; i++) {
		options[i].style.display = "flex";
		if (luxury_count == 10) {
			document.getElementById("add").style.display = "none";
		}
	}
	var all_dropdowns = document.getElementsByTagName("select");
	for (var i = 0; i < all_dropdowns.length; i++) {
		if (all_dropdowns[i] != type) all_dropdowns[i].selectedIndex = 0;
	}
}

/*---------------------------------------------------
 * add_luxury_option()
 *---------------------------------------------------
 * Adds an additional luxury option to the list
 * Note - this was not used due to time constraints
 *---------------------------------------------------*/
var luxury_count = 3;
function add_luxury_option() {
	if (luxury_count < 10) {
		var add_field = document.getElementById("add");
		add_field.insertAdjacentHTML("beforebegin", '<div class="field ship options added">'
							  + '<label class="label">Luxury Item</label>'
							  + '<input type="Text">'
							  + '</div>');
		luxury_count++;
		if (luxury_count == 10) {
			add_field.style.display = "none";
		}
	} 
}

/*---------------------------------------------------
 * request()
 *---------------------------------------------------
 * Takes a form as input and compiles all of the 
 * into a single string for the send request.
 * The AJAX xmlhttprequest is sent to ./request.jsp
 * where the interconnection to the database is
 *---------------------------------------------------*/
function request(form) {
	var select = document.getElementById(form);
	var variables = "";
	for (var i = 0; i < select.length; i++) {
		if (select.elements[i].value != "") {
			if (i+1 == select.length)
				variables += select.elements[i].name + "=" + select.elements[i].value;
			else 
				variables += select.elements[i].name + "=" + select.elements[i].value+"&";
		}
	}
	var xRequest1;
	var response = document.getElementById("ajaxresponse");
	if(window.XMLHttpRequest) {
		xRequest1=new XMLHttpRequest();
	} else {
		xRequest1=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xRequest1.onreadystatechange=function () {
		if((xRequest1.readyState==4) && (xRequest1.status==200)) {
			response.innerHTML=xRequest1.responseText;
			response.style.display = "flex";
		}
	}
	xRequest1.open("POST","/request.jsp",true);
	xRequest1.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xRequest1.send(variables);
}