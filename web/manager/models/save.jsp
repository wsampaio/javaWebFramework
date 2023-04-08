<%-- 
    Document   : save.jsp
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
<%@page 



isErrorPage="true"

import="com.wsampaio.jdbc.ConnDB"
import="com.wsampaio.jdbc.Field"
import="com.wsampaio.jdbc.ObjTable"

import="java.util.Iterator"

import="org.json.JSONObject"


contentType="text/html" 
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


JSONObject jsonObject = new JSONObject(request.getReader().readLine());
Iterator<String> it = jsonObject.keys();


for (Field f : obj.getFields()){
  while(it.hasNext()) {
	String key = it.next();
	  obj.setValueOf(key, jsonObject.get(key));
  }
}



if (
  request.getMethod().equalsIgnoreCase("delete")
)
obj.delete(obj);

if (
  request.getMethod().equalsIgnoreCase("post") || 
  request.getMethod().equalsIgnoreCase("put")
)
obj.save(obj);


request.getRequestDispatcher(
  "/manager/models/json.jsp" +
	"?schema=" + schema +
	"&table=" + tableName +
	"&qry=select" +
	"&params=" + obj.getValueOf(obj.getPkName()) + ","
).forward(new HttpServletRequestWrapper(request) {
  @Override
  public String getMethod() {
	String method = super.getMethod();
	if (method.equalsIgnoreCase("delete") || method.equalsIgnoreCase("put")) {
	  return "POST";
	} else {
	  return method;
	}
  }
}, response);



%>