/*

Copyright (c) 2023, 

/WELLSampaio
<github.com/wsampaio>
<linkedin.com/in/wellsampaio>

Este trabalho está licenciado sob a Licença Atribuição 4.0 Internacional 
Creative Commons. Para visualizar uma cópia desta licença, visite 
http://creativecommons.org/licenses/by/4.0/ ou mande uma carta para Creative 
Commons, PO Box 1866, Mountain View, CA 94042, USA.

 */
package com.wsampaio;

import com.wsampaio.jdbc.ObjTableSQLite;

/**
 *
 * @author wsampaio
 * 
 */
public class ObjTableExample extends ObjTableSQLite{
/**
 *
 * Esta classe deve extender as classes:
 * com.wsampaio.jdbc.ObjTableAcc
 * com.wsampaio.jdbc.ObjTablePSQL
 * com.wsampaio.jdbc.ObjTableSQLite
 * 
 */

  public ObjTableExample(){
	setAttributes();
  }

  @Override
  public void setAttributes(){
	schema = "schema";
	tableName = "tableName";
	pkName = "pkName";

	setSQLStatement(
	  "consultaComboBox", 
	  "values", 
	  "SELECT " +
			pkName + " " +
		  "AS [value], " +
			"texto_para_o_select " +
		  "AS [option] " +
		"FROM " +
		  tableName + " " +
		"ORDER BY " +
		  "2" +
		""
	);

  }
}
