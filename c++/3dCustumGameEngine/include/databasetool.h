#ifndef DATABASETOOL_H
#define DATABASETOOL_H
#include <string>
#include "libpq-fe.h"
#include "account.h"

using namespace std;

class databaseTool
{
    public:
		static PGconn * database;

		static void CloseConn(PGconn *conn);
		static PGconn *ConnectDB(char * connectInfo);
		static void CreateAccountTable(PGconn *conn);
		static int CreateAccount(string fname, string lname);
		static Account* GetAccount(char * fname);
		static void FetchEmployeeRec(PGconn *conn);
		static void RemoveAllEmployeeRec(PGconn *conn);
		static void DropEmployeeTable(PGconn *conn);
	protected:
    private:
};

#endif // DATABASETOOL_H