package dbController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.*;

/*---------------------------------------------------
 * Tanner Bernth
 * Ana Huff
 * Briana Liosatos
 * Aakash Rathore
 * 
 * Program #4: Database-driven Web Application
 * 
 * DatabaseController provides an object that allows
 * for the middle, request.jsp, page to use its input
 * that it receives the from the user to query and
 * alter the database
 *---------------------------------------------------*/

/**
 * Servlet implementation class for Servlet: DatabaseController
 *
 */
public class DatabaseController {
  static final long serialVersionUID = 1L;
  /**
   * A handle to the connection to the DBMS.
   */
  protected Connection connection_;
  /**
   * A handle to the statement.
   */
  protected Statement statement_;
  /**
   * The connect string to specify the location of DBMS
   */
  protected String connect_string_ = null;
  /**
   * The password that is used to connect to the DBMS.
   */
  protected String password = null;
  /**
   * The username that is used to connect to the DBMS.
   */
  protected String username = null;

  /*---------------------------------------------------
   * Constructor
   *---------------------------------------------------*/
  public DatabaseController() {
    // your cs login name
    username = "tannerbernth"; 
    // your Oracle password, NNNN is the last four digits of your CSID
    password = "a1234";
    connect_string_ = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
  }


  /**
   * Closes the DBMS connection that was opened by the open call.
   */
  public void Close() {
    try {
      statement_.close();
      connection_.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    connection_ = null;
  }


  /**
   * Commits all update operations made to the dbms.
   * If auto-commit is on, which is by default, it is not necessary to call
   * this method.
   */
  public void Commit() {
    try {
      if (connection_ != null && !connection_.isClosed())
        connection_.commit();
    } catch (SQLException e) {
      System.err.println("Commit failed");
      e.printStackTrace();
    }
  }

  /*---------------------------------------------------
   * void Open()
   *---------------------------------------------------
   * Provided to us. Establishes a connection for the 
   * database and the statements.
   *---------------------------------------------------*/
    public void Open() {
  try {
      Class.forName("oracle.jdbc.OracleDriver");
      connection_ = DriverManager.getConnection(connect_string_, username, password);
      statement_ = connection_.createStatement();
      return;
  } catch (SQLException sqlex) {
      sqlex.printStackTrace();
  } catch (ClassNotFoundException e) {
      e.printStackTrace();
      System.exit(1); //programemer/dbsm error
  } catch (Exception ex) {
      ex.printStackTrace();
      System.exit(2);
  }
    }

  /*---------------------------------------------------
   * Vector<String> getModelNames()
   *---------------------------------------------------
   * Returns a String vector which is used to get a 
   * custom select input from the user based on the 
   * model names in the database.
   *---------------------------------------------------*/
  public Vector<String> getModelNames() {
    String sql_query = "select modelname from aakashrathore.modellist";
    try {
      ResultSet rs = statement_.executeQuery(sql_query);
      Vector<String> result = new Vector<String>();
      while (rs.next()) {
        String temp_record = rs.getString("modelname");
        result.add(temp_record);
      }
      return result;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return null;
  }

  /*---------------------------------------------------
   * Vector<String> getLuxuryParts()
   *---------------------------------------------------
   * Returns a String vector which is used to get all 
   * of the luxury parts for the user to select from
   * when adding a new model type.
   *---------------------------------------------------*/
  public Vector<String> getLuxuryParts() {
    String sql_query = "select distinct name from aakashrathore.luxuryparts";
    try {
      ResultSet rs = statement_.executeQuery(sql_query);
      Vector<String> result = new Vector<String>();
      while (rs.next()) {
        String temp_record = rs.getString("name");
        result.add(temp_record);
      }
      return result;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return null;
  }

  /*---------------------------------------------------
   * String newShipModel(String, Stringp[])
   *---------------------------------------------------
   * Creates a new ship model by inserting the user
   * provided modelname and the array of luxury parts
   * selected from the drop down menus. Each luxury part
   * chosen is also inserted into the luxuryparts 
   * table under the provided modelname
   *---------------------------------------------------*/
  public String newShipModel(String modelName, String[] parts) {
      String sql_query = "insert into aakashrathore.modellist values('" + modelName + "', 500)";
      try {
      ResultSet rs = statement_.executeQuery(sql_query);
      String lux_insert = "";
      String timeStamp = "";
      String price_query = "";
      
      for (int i = 0; i < parts.length; i++) {
        price_query = "select distinct price from aakashrathore.luxuryparts where name='" + parts[i] + "'"; 
        rs = statement_.executeQuery(price_query);
        String price = "";
        while (rs.next()) {
          price += String.valueOf(rs.getFloat("price"));
        }
        timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+ i +"L";
        lux_insert = "insert into aakashrathore.luxuryparts values('" + timeStamp + "','" + parts[i] + "','" + modelName + "'," + price + ")";
        statement_.executeQuery(lux_insert);
      }

      return "New ship model created successfully";
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return "Failed to create new ship";
  }

  /*---------------------------------------------------
   * String listModelParts(String)
   *---------------------------------------------------
   * Lists the partid, name, and price for all of the 
   * luxury and requiredparts. This is the required
   * query #1.
   *---------------------------------------------------*/
  public String listModelParts(String modelName) {
    String sql_query = "select partid, name, price from aakashrathore.luxuryParts where aakashrathore.luxuryParts.modelName='"
                       + modelName +"' union select * from aakashrathore.requiredParts order by partid";
    try {
      ResultSet rs = statement_.executeQuery(sql_query);

      String row = "<table id='formoutput'><tr><th colspan='3'>" + modelName + "</th></tr>";
      row += "<tr><th>Part ID</th><th>Name</th><th>Price</th></tr>";
      while (rs.next()) {
        String current = "<tr><td>" + rs.getString("partid") + "</td><td>" 
                        + rs.getString("name") + "</td><td>" + String.format("$%15.2f",rs.getFloat("price")) + "</td></tr>";
        row += current;
      }
      row += "</table>";
      return row;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return null;
  }

  /*---------------------------------------------------
   * String listIncompleteShips()
   *---------------------------------------------------
   * This lists the name, model, and cost of all of the
   * unfinished ships. This is the required query #2.
   *---------------------------------------------------*/
  public String listIncompleteShips() {
    String sql_query = "select name, modelname, currentcost from aakashrathore.customer inner join aakashrathore.invoice on aakashrathore.invoice.custid=aakashrathore.customer.rowid where complete=0 order by name";
    try {
      ResultSet rs = statement_.executeQuery(sql_query);

      String row = "<table id='formoutput'><tr><th colspan='3'>Incomplete Ships</th></tr>";
      row += "<tr><th>Customer</th><th>Model</th><th>Current Cost</th></tr>";
      while (rs.next()) {
        String current = "<tr><td>" + rs.getString("name") + "</td><td>" 
                        + rs.getString("modelName") + "</td><td>" + String.format("$%15.2f",rs.getFloat("currentCost")) + "</td></tr>";
        row += current;
      }
      row += "</table>";
      return row;
      //return result;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return null;
  }

  /*---------------------------------------------------
   * String topPayingCustomer()
   *---------------------------------------------------
   * This lists the customer name of the highest 
   * paying user. This is the required query #3.
   *---------------------------------------------------*/
  public String topPayingCustomer() {
          String sql_query = "SELECT customer.ROWID as custID, customer.name, tempFinal.finalMaxPrice as amountPaid FROM aakashrathore.customer, (SELECT tempNew.custID, tempNew.finalMaxPrice from (SELECT MAX(temp.markupPrice) as finalMaxPrice, temp.custID from (SELECT custID, SUM(currentCost)*500 as markupPrice from aakashrathore.invoice GROUP BY custID) temp GROUP BY custID ORDER BY MAX(temp.markupPrice) desc) tempNew) tempFinal where tempFinal.custID = customer.ROWID AND ROWNUM<2";

        try {
            ResultSet rs = statement_.executeQuery(sql_query);
            String temp = "<table id='formoutput'><tr><th colspan='2'>Top Paying Customer</th></tr>";
            temp += "<tr><th>Name</th><th>Money Spent</th></tr>";
            while (rs.next()) {
              temp += "<tr><td>" +rs.getString("name") + "</td><td>" + String.format("$%15.2f",rs.getFloat("amountPaid")) + "</td></tr>";
            }
            temp += "</table>";
            return temp;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return "query fails";
    }

  /*---------------------------------------------------
   * String showInvoices(String)
   *---------------------------------------------------
   * This shows all outstanding invoices of the user
   * provided.
   *---------------------------------------------------*/
    public String showInvoices(String name) {
        String sql_query = "select rowid as invoiceNum, modelname, currentcost from aakashrathore.invoice where complete=0 and custid=(select rowid from aakashrathore.customer where name='" + name + "')";
        try {
          ResultSet rs = statement_.executeQuery(sql_query);
          //RowId rowid = rs.getRow
          String row = "<table id='formoutput'><tr><th colspan='3'>" + name + "</th></td>";
          row += "<tr><th>Invoice ID</th><th>Model</th><th>Current Cost</th></tr>";
          while (rs.next()) {
            String current = "<tr><td>" + rs.getString("invoiceNum") + "</td><td>" 
                            + rs.getString("modelName") + "</td><td>" + String.format("$%15.2f",rs.getFloat("currentCost")) + "</td></tr>";
            row += current;
          }
          row += "</table>";
          return row;
          //return result;
        } catch (SQLException sqlex) {
          sqlex.printStackTrace();
        }
        return null;
    }

  /*---------------------------------------------------
   * String showParts(String)
   *---------------------------------------------------
   * This shows all of the corresponding parts to a 
   * specific invoiceid.
   *---------------------------------------------------*/
    public String showParts(String invoiceId) {
        String temp = "select rowid from aakashrathore.shipconstruction where invoicenum='" + invoiceId + "'";
        try {
          ResultSet rs = statement_.executeQuery(temp);
          //RowId rowid = rs.getRow
          String constructionid = "";
          int count = rs.getMetaData().getColumnCount();
          while(rs.next()) {
            for (int i = 0; i < count; i++) {
              constructionid += rs.getString(i+1);
            }
          }
          String sql_query = "select partid, name, price, constructionid from aakashrathore.listofmodelparts where constructionid='" + constructionid + "' and added=0 order by partid";
          rs = statement_.executeQuery(sql_query);
          String row = "<table id='formoutput'><tr><th colspan='4'> Parts </th></td>";
          row += "<tr><th>Part ID</th><th>Name</th><th>Price</th><th>Construction ID</th></tr>";
          while (rs.next()) {
            String current = "<tr><td>" + rs.getString("partid") + "</td><td>" 
                            + rs.getString("name") + "</td><td>" + String.format("$%15.2f",rs.getFloat("price")) + "</td><td>" + rs.getString("constructionid") + "</td></tr>";
            row += current;
          }
          row += "</table>";
          return row;
          //return result;
        } catch (SQLException sqlex) {
          sqlex.printStackTrace();
        }
        return null;
    }

  /*---------------------------------------------------
   * String removeInvoice(String) 
   *---------------------------------------------------
   * This removes a invoice from the provided invoiceid.
   * The invoice is deleted from the invoice table, 
   * shipconstruction table, and all parts 
   * corresponding to the invoiceid are removed from 
   * listofmodelparts.
   *---------------------------------------------------*/
    public String removeInvoice(String invoiceId) {
      String deleteinvoice= "DELETE from aakashrathore.invoice WHERE rowid='"+invoiceId+"'";
      String deleteshipConstruction="DELETE from aakashrathore.shipConstruction WHERE invoiceNum='"+invoiceId+"'";
      String getconstructionid = "SELECT ROWID AS constructionID FROM aakashrathore.shipConstruction WHERE invoiceNum='" + invoiceId + "'";
      try {
              statement_.executeQuery(deleteinvoice);
              statement_.executeQuery(deleteshipConstruction);
              ResultSet rs = statement_.executeQuery(getconstructionid);
              String constructionid = "";

              int count = rs.getMetaData().getColumnCount();
              while(rs.next()) {
                for (int i = 0; i < count; i++) {
                  constructionid += rs.getString(i+1);
                }
              }

              String delete_parts = "DELETE from aakashrathore.listOfModelParts where constructionID='" + constructionid + "'";
              statement_.executeQuery(delete_parts);
              return "Deleted the invoice successfully";
      }
      catch (SQLException sqlex) {
            sqlex.printStackTrace();
          }
      return "Failed to delete invoice";
    }
    
  /*---------------------------------------------------
   * String addToShip(String, String, String)
   *---------------------------------------------------
   * Changes the status of a part for the corresponding
   * invoiceid to added and updates the current cost 
   * for that ship.
   *---------------------------------------------------*/
    public String addToShip (String partIDToAdd, String constructionID, String invoicenumber) {
      String add= "UPDATE aakashrathore.listOfModelParts set added=1 where partID='"+partIDToAdd +"' and constructionID='"+constructionID+"'";
      String getcost="SELECT price from aakashrathore.listofmodelparts where partID='"+partIDToAdd+"' and constructionID='"+constructionID+"'";
      try{
        statement_.executeQuery(add);
        ResultSet rs = statement_.executeQuery(getcost);
        String price = "";
        while (rs.next()) {
          price += String.valueOf(rs.getFloat("price"));
        }
        String updateTotalCost="update aakashrathore.invoice set currentCost=(currentCost+" + price + ") where rowID ='" + invoicenumber+"'";
        statement_.executeQuery(updateTotalCost);

        String getAllParts = "select added from aakashrathore.listofmodelparts where constructionid='" + constructionID + "'";//AAB1BCAAGAAAGknAAB
        rs = statement_.executeQuery(getAllParts);
        boolean complete = true;
        while (rs.next()) {
          if (rs.getInt("added") == 0) {
            complete = false;
          }
        }
        if (complete) {
          String update1 = "UPDATE aakashrathore.invoice set complete = 1 where ROWID='" + invoicenumber + "'";
          String update2 = "UPDATE aakashrathore.invoice set currentCost=(currentCost*500) WHERE ROWID='" + invoicenumber + "'";
          statement_.executeQuery(update1);
          statement_.executeQuery(update2);
        }

        return complete ? "Ship Complete" : "Built Successfully";
      }
      catch (SQLException sqlex) {
          sqlex.printStackTrace();
        }
    return "Build failed";
    }

  /*---------------------------------------------------
   * String showCustId(String)
   *---------------------------------------------------
   * Shows the customer id given their name.
   *---------------------------------------------------*/
  public String showCustId(String name) {
    String sql_query = "select rowid from aakashrathore.customer where name='" + name + "'";
    try {
      ResultSet rs = statement_.executeQuery(sql_query);
      String temp = "";
      while(rs.next()) { 
        temp += rs.getString("rowid");     
      } 
      return temp;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return null;
  }

  /*---------------------------------------------------
   * String moneySpent(String custId)
   *---------------------------------------------------
   * Shows the total cost of a user with the given
   * customerid. This is the additional query #1.
   *---------------------------------------------------*/
  public String moneySpent(String custId) {
    String sql_query = "select (sum(currentcost)*500) as cost from aakashrathore.invoice group by custid having custid='" + custId + "'";
        try {
          ResultSet rs = statement_.executeQuery(sql_query);
          //RowId rowid = rs.getRow
          String row = "<table id='formoutput'><tr><th>" + custId + " Total Spent </th></tr>";
          row += "<tr><th>Amount</th></tr>";
          while (rs.next()) {
            row += "<tr><td>" + String.format("$%15.2f",rs.getFloat("cost"))+ "</td></tr>";
          }
          row += "</table>";
          return row;
          //return result;
        } catch (SQLException sqlex) {
          sqlex.printStackTrace();
        }
        return null;
  }

  /*---------------------------------------------------
   * String completedShips(String)
   *---------------------------------------------------
   * This shows all of the completed ships of the 
   * user given their customer id. This is the 
   * additional query #2.
   *---------------------------------------------------*/
  public String completedShips(String custId) {
    String sql_query = "select rowid as invoicenum, custid, modelname, currentcost from aakashrathore.invoice where complete=1 and custid='" + custId + "'";
        try {
          ResultSet rs = statement_.executeQuery(sql_query);
          //RowId rowid = rs.getRow
          String row = "<table id='formoutput'><tr><th colspan='3'>" + custId + "</th></tr>";
          row += "<tr><th>Invoice #</th><th>Model Name</th><th>Current cost</th></tr>";
          while (rs.next()) {
            String current = "<tr><td>" + rs.getString("invoicenum") + "</td><td>" 
                            + rs.getString("modelname") + "</td><td>" + String.format("$%15.2f",rs.getFloat("currentcost")) + "</td></tr>";
            row += current;
          }
          row += "</table>";
          return row;
          //return result;
        } catch (SQLException sqlex) {
          sqlex.printStackTrace();
        }
        return null;
  }

  /*---------------------------------------------------
   * boolean insertPart(String, String, String)
   *---------------------------------------------------
   * This inserts an additional part into the 
   * requiredparts table.
   *---------------------------------------------------*/
  public boolean insertPart(String name, String type, String price) {
    String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    if (type.equals("required")) {
      timeStamp += "R";
    } else {
      timeStamp += "L";
    }
    String sql_query = "insert into aakashrathore.requiredParts values('" + timeStamp + "','" + name + "'," + price + ")";    
    try {
      statement_.executeQuery(sql_query);
      return true;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return false;
  }

  /*---------------------------------------------------
   * String updatePartPrice(String, String)
   *---------------------------------------------------
   * This updates the price of a part in luxuryparts.
   * This does not affect the currently building parts
   * that are already in listofmodelparts.
   *---------------------------------------------------*/
  public String updatePartPrice(String name, String price) {
    String sql_query = "update aakashrathore.luxuryparts set price='" + price + "' where name='" + name + "'";
     try {
      statement_.executeQuery(sql_query);
      return "Price updated successfully";
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return "Failed to update price";
  }

  /*---------------------------------------------------
   * String insertDepartment(String, String)
   *---------------------------------------------------
   * Inserts a new department and that departments
   * given model type.
   *---------------------------------------------------*/
  public String insertDepartment(String name, String modelName) {
    String sql_query = "insert into aakashrathore.department values('" + name + "','" + modelName + "')";   
    String sql_query2 = "select name, modelname from aakashrathore.department"; 
    try {
      statement_.executeQuery(sql_query);
      String row = "<table id='formoutput'><tr><th colspan='2'>Inserted Successfully</th></tr><tr><th>Department Name</th><th>Model Name</th></tr>";
      ResultSet rs = statement_.executeQuery(sql_query2);
      while (rs.next()) {
        row += "<tr><td>" + rs.getString("name") + "</td><td>" + rs.getString("modelname") + "</td></tr>";
      }
      row += "</table>";
      return row;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return "Insert Department Failed";
  }

  /*---------------------------------------------------
   * String newCustomerAndInvoice(String, String, 
   * String)
   *---------------------------------------------------
   * Creates a new customer if the customertype is 
   * new. Otherwise a new invoice is created for the user
   * with the given modelname. Then the shipconstruction
   * is created for the user with their invoiceid.
   * Using the construction id, all of the parts
   * corresponding to the given modelname are 
   * input into listofmodelparts from the luxuryparts
   * and requiredparts table.
   *---------------------------------------------------*/
  public String newCustomerAndInvoice(String customerType, String name, String modelName) {
    String sql_query = "insert into aakashrathore.customer values('" + name + "')";
    String sql_query2 = "insert into aakashrathore.invoice values((select rowid from aakashrathore.customer where name='" + name + "'),0,'" +  modelName + "', 0)";
    String sql_query3 = "insert into aakashrathore.shipConstruction values ((SELECT ROWID as invoiceNum from aakashrathore.invoice WHERE rowid IN (select max(rowid) from aakashrathore.INVOICE)), '" + modelName + "')";
    String temp = "SELECT ROWID as constructionID from aakashrathore.shipConstruction WHERE rowid IN (select max(rowid) from aakashrathore.shipConstruction)";

    try {
      if (customerType.equals("new")) {
        statement_.executeQuery(sql_query);
      }
      statement_.executeQuery(sql_query2);
      statement_.executeQuery(sql_query3);
      ResultSet rs = statement_.executeQuery(temp);
      String constructionid = "";

      int count = rs.getMetaData().getColumnCount();
      while(rs.next()) {
        for (int i = 0; i < count; i++) {
          constructionid += rs.getString(i+1);
        }
      }
      String sql_query4 = "INSERT INTO aakashrathore.listOfModelParts(partID, name, modelName, price, constructionID, added) (SELECT partID, name, modelName, price, '" + constructionid + "' as constructionID, 0 as added FROM aakashrathore.luxuryParts WHERE aakashrathore.luxuryParts.modelName='" + modelName + "' union SELECT partID, name, '" + modelName + "' as modelName, price, '" + constructionid + "' as constructionID, 0 as added FROM aakashrathore.requiredParts)";
      statement_.executeQuery(sql_query4);

      return "User and invoice registered successfully";
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return "failed";
  }
}
