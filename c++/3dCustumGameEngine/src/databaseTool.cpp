#include "databasetool.h"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
PGconn * databaseTool::database;

/* Close connection to database */
void databaseTool::CloseConn(PGconn *conn)
{
    PQfinish(conn);
	getchar();
    exit(1);
}

/* Establish connection to database */
PGconn * databaseTool::ConnectDB(char * connectInfo)
{
	database = NULL;

	// Make a connection to the database
	database = PQconnectdb(connectInfo);

	// Check to see that the backend connection was successfully made
	if (PQstatus(database) != CONNECTION_OK)
	{
		printf("Connection to database failed");
		CloseConn(database);
	}else{
		printf("Connection to database - OK\n");
	}
return database;
}

/* Create employee table */
void databaseTool::CreateAccountTable(PGconn *conn)
{
  // Execute with sql statement
    PGresult *res = PQexec(conn, "CREATE TABLE account (userName varchar(30) PRIMARY KEY, password varchar(30), cash integer DEFAULT 0)");

  if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        printf("Create account table failed");
        PQclear(res);
        CloseConn(conn);
    }

  printf("Create account table - OK\n");

  // Clear result
  PQclear(res);
}

/* Append SQL statement and insert record into employee table */
int databaseTool::CreateAccount(string fname, string lname)
{
	PGconn *conn = database;
	int success = 1;
  // Append the SQL statment
  std::string sSQL;
  sSQL.append("INSERT INTO account (username, password, cash) VALUES ('");
  sSQL.append(fname);
  sSQL.append("','");
  sSQL.append(lname);
  sSQL.append("',0);");


  // Execute with sql statement
  PGresult *res = PQexec(conn, sSQL.c_str());

    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        //printf("CreateAccount failed");
		//printf("%s\n",PQerrorMessage(conn));
		success=0;
    }else{
		//printf("Insert employee record - OK\n");
	}
  // Clear result
  PQclear(res);
  return success;
}

Account * databaseTool::GetAccount(char * fname){
	string name;
	string password;
	int cash;
	PGconn *conn = database;
	std::string sSQL;
	sSQL.append("SELECT * FROM account WHERE username = '");
	sSQL.append(fname);
	sSQL.append("';");
	PGresult *res = PQexec(conn, sSQL.c_str());
	if (PQresultStatus(res) != PGRES_TUPLES_OK||PQntuples(res)!=1)
    {
		printf("%s\n",PQerrorMessage(conn));
		cout << "error";
		return 0;
	}else{

		cout << "returnedVAL ->>";
		name = PQgetvalue(res, 0, 0);
		password = PQgetvalue(res, 0, 1);
		cash = atoi(PQgetvalue(res, 0, 2));
	}
	Account * ret = new Account(name, password, cash);
	return ret;
}

/* Fetch employee record and display it on screen */
void databaseTool::FetchEmployeeRec(PGconn *conn)
{
  // Will hold the number of field in employee table
  int nFields;

  // Start a transaction block
  PGresult *res  = PQexec(conn, "BEGIN");

    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        printf("BEGIN command failed");
        PQclear(res);
        CloseConn(conn);
    }

   // Clear result
    PQclear(res);

    // Fetch rows from employee table
    res = PQexec(conn, "DECLARE emprec CURSOR FOR select * from employee");
    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        printf("DECLARE CURSOR failed");
        PQclear(res);
        CloseConn(conn);
    }

  // Clear result
    PQclear(res);

    res = PQexec(conn, "FETCH ALL in emprec");

    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        printf("FETCH ALL failed");
        PQclear(res);
        CloseConn(conn);
    }

    // Get the field name
    nFields = PQnfields(res);

  // Prepare the header with employee table field name
  printf("\nFetch employee record:");
  printf("\n********************************************************************\n");
    for (int i = 0; i < nFields; i++)
        printf("%-30s", PQfname(res, i));
    printf("\n********************************************************************\n");

    // Next, print out the employee record for each row
    for (int i = 0; i < PQntuples(res); i++)
    {
        for (int j = 0; j < nFields; j++)
            printf("%-30s", PQgetvalue(res, i, j));
        printf("\n");
    }

    PQclear(res);

    // Close the emprec
    res = PQexec(conn, "CLOSE emprec");
    PQclear(res);

    // End the transaction
    res = PQexec(conn, "END");

  // Clear result
    PQclear(res);
}

/* Erase all record in employee table */
void databaseTool::RemoveAllEmployeeRec(PGconn *conn)
{
  // Execute with sql statement
    PGresult *res = PQexec(conn, "DELETE FROM employee");

    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        printf("Delete employees record failed.");
        PQclear(res);
        CloseConn(conn);
    }

  printf("\nDelete employees record - OK\n");

  // Clear result
  PQclear(res);
}

/* Drop employee table from the database*/
void databaseTool::DropEmployeeTable(PGconn *conn)
{
  // Execute with sql statement
    PGresult *res = PQexec(conn, "DROP TABLE employee");

    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        printf("Drop employee table failed.");
        PQclear(res);
        CloseConn(conn);
    }

  printf("Drop employee table - OK\n");

  // Clear result
  PQclear(res);
}