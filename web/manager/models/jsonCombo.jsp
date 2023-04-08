<%-- 
    Document   : jsonCombo.jsp
    Created on : 2023-04-08T00:00
    Author     : wsampaio

Copyright (c) 2023, 

/WELLSampaio
<github.com/wsampaio>
<linkedin.com/in/wellsampaio>

Este trabalho está licenciado sob a Licença Atribuição 4.0 Internacional 
Creative Commons. Para visualizar uma cópia desta licença, visite 
http://creativecommons.org/licenses/by/4.0/ ou mande uma carta para Creative 
Commons, PO Box 1866, Mountain View, CA 94042, USA.


--%>
<%@ page 

import="com.wsampaio.jdbc.ConnDB"
import="com.wsampaio.jdbc.ObjTable"

import="java.sql.PreparedStatement"
import="java.sql.ResultSet"
import="java.sql.SQLException"

import="org.json.JSONArray"
import="org.json.JSONObject"


contentType="application/json"
pageEncoding="UTF-8"


%><%





String dbFolder = getServletContext().getInitParameter("dbFolder");

String schema = request.getParameter("schema");
String tableName = request.getParameter("table");
String queryName = request.getParameter("qry");
String[] parameters = ( request.getParameter("params") == null )?
  new String[] {}:request.getParameter("params").split(",");

ConnDB connDB = new ConnDB(dbFolder, schema, "sqlite");
ObjTable obj = connDB.getObjTableInstance(tableName);
obj.load(connDB);

String[][] lista;


try {

//System.out.println(obj.getSQLStatement("consultaComboBox"));


  PreparedStatement stmt = connDB.getConn().prepareStatement(
	obj.getSQLStatement("consultaComboBox")
  );

  ResultSet rs = stmt.executeQuery();

  int len = 0;

  while (rs.next()){
	len++;
  }
	
  lista = new String[len][2];
  len = 0;

  rs = stmt.executeQuery();

  while (rs.next()){
	lista[len][0] = rs.getString("value");
	lista[len++][1] = rs.getString("option");
  }

  stmt.close();
  rs.close();

} catch(SQLException e){
  throw new RuntimeException(e);
}


// prepara array principal
// com registros da tabela
JSONArray objRows = new JSONArray();

	
for(int i=0;i<lista.length;i++){

  // objeto da tabela - registro row
  JSONObject objField = new JSONObject();
  objField.put("value", lista[i][0]);
  objField.put("option", lista[i][1]);

  objRows.put(objField);
}

// prepara objeto principal
// nome da tabela no singular (OU NÃO)
JSONObject objJSON = new JSONObject();

// insere registros no objeto principal
objJSON.put(obj.getTableName(), objRows);

out.print(objJSON.toString());


%>