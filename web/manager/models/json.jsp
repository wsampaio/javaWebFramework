<%-- 
    Document   : json.jsp
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


--%><%@ page 

import="com.wsampaio.jdbc.ConnDB"
import="com.wsampaio.jdbc.Field"
import="com.wsampaio.jdbc.ObjTable"
import="com.wsampaio.jdbc.Paginacao"

import="org.json.JSONArray"
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

int pagAtual = ( request.getParameter("pag") == null )?
	0:Integer.parseInt(request.getParameter("pag"));

int itensPorPagina = ( request.getParameter("ipp") == null )?
	0:Integer.parseInt(request.getParameter("ipp"));

if (itensPorPagina < 0)
	itensPorPagina = 99999;

if (itensPorPagina < 1)
	itensPorPagina = 30;

String nomeClasse = "";


ConnDB connDB = new ConnDB(dbFolder, schema, "sqlite");
ObjTable obj = connDB.getObjTableInstance(tableName);
obj.load(connDB);


int[] lista;

if(queryName != null){
	lista = obj.getIndexList(queryName, parameters);
} else {
	lista = obj.getIndexList("getLast");
}


int regPorPagina = itensPorPagina;

Paginacao p = new Paginacao(lista, regPorPagina);

lista = p.getPagina(pagAtual);


// pegar chaves extrangeiras





/*
jackcess, 
hsqldb,
commons-logging and 
commons-lang
*/





/*


BUSCA CHAVES ESTRANGEIRAS

String diretorioDB = request.getServletContext().getInitParameter("diretorioBD");


String schema = request.getParameter("schema");
String tableName = request.getParameter("table");
String queryName = request.getParameter("qry");
String[] parameters = ( request.getParameter("params") == null )?
new String[] {}:request.getParameter("params").split(",");


Connection conn = new ConnDB().getACCConn(diretorioDB, schema);



java.sql.ResultSet rs = conn.getMetaData().getImportedKeys(null, null, "modelos");

while (rs.next()){
	for (int i = 1; i <= 14; i++){
		out.println(i + ": " + rs.getMetaData().getColumnName(i));
		//out.println(i + ": " + rs.getString(i));
	}
}


//rs.getString(3) // PKTABLE_NAME
//rs.getString(4) // PKCOLUMN_NAME


//rs.getString(6) // FKTABLE_SCHEM


// 01: PKTABLE_CAT
// 02: PKTABLE_SCHEM
// 03: TABLE_NAME
// 04: COLUMN_NAME

// 05: FKTABLE_CAT
// 06: FKTABLE_SCHEM
// 07: TABLE_NAME
// 08: COLUMN_NAME

// 09: KEY_SEQ
// 10: UPDATE_RULE
// 11: DELETE_RULE
// 12: FK_NAME
// 13: PK_NAME
// 14: DEFERRABILITY









*/











// prepara array principal
// com registros da tabela
JSONArray objRows = new JSONArray();

for(Integer i : lista){

	obj.loadPk(i);

	// objeto da tabela - registro row
	JSONObject objField = new JSONObject();

	// passa por cada campo do registro
	for(Field f : obj.getObjFields()){

		// pega campos Field do registro row
		System.out.println(f.toString());
		JSONObject field = new JSONObject(f.toString());



// insere objFK
/*

if 
08: COLUMN_NAME = fieldName

{
// 02: PKTABLE_SCHEM
// 03: TABLE_NAME

}


*/
// field.put("fk", "00");



		// insere campos Field no registro row
		objField.put(f.fieldName, field);
	}

	// insere registro row no arr da tabela
	objRows.put(objField);

}

// prepara objeto principal
// nome da tabela no singular (OU NÃO)
JSONObject objJSON = new JSONObject();

// insere registros no objeto principal
objJSON.put(obj.getTableName(), objRows);


// dados de paginação

//JSONObject objField = new JSONObject();
//objField.put(f.fieldName, field);
//JSONArray objRows = new JSONArray();
//objRows.put(objField);

JSONObject objPaginacao = new JSONObject();

objPaginacao.put("regPorPagina", regPorPagina);
objPaginacao.put("pagAtual", pagAtual);
objPaginacao.put("ttlPaginas", p.getTtlPaginas());

objJSON.put("paginacao", objPaginacao);


connDB.closeConn();


out.print(
	objJSON.toString()
//		.replace("{", "\n{")
//		.replace(",\"", ",\n\"")
//		.replace("{\"", "{\n\"")
//		.replace("\"}", "\"\n}")
);







%>