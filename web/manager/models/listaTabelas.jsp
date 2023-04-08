<%-- 
    Document   : listaTabelas.jsp
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

import="com.wsampaio.jdbc.ClassMap"

contentType="application/json" 
pageEncoding="UTF-8"

%><%

response.flushBuffer();



String dbFolder = getServletContext().getInitParameter("dbFolder");

ClassMap classMap = new ClassMap(dbFolder);

String schemaStr = "";
String tableStr = "";

for(String schema : classMap.getSchemas()){

	tableStr = "";
	for(String[] classes : classMap.getClassesByContext(schema))
		tableStr += ",\"" + classes[0] + "\"";

	if (tableStr.length() < 1)
		tableStr = " ";

	schemaStr += ", \"" + schema + "\":[" + tableStr.substring(1) + "]";
}

if (schemaStr.length() < 2)
	schemaStr = "  ";

out.print("{" + schemaStr.substring(2) + "}");


%>