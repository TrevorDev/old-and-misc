#include <ctime>
#include <iostream>
#include <string>
#include <boost/array.hpp>
#include <boost/bind.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/asio.hpp>
#include <boost/thread.hpp>
#include "account.h"
using boost::asio::ip::udp;
using namespace std;

#include "udpserver.h"
#include "tcpserver.h"
#include "databasetool.h"
#include "buffertool.h"

#include <vld.h> 
void gui(boost::asio::io_service * io_service){
	bool run = true;
	while(run){
		char request[100];
		std::cin.getline(request, 100);
		if(strcmp(request, "q")==0){
			run=false;
		}
	}
	io_service->stop();
}

int main(int argc, char* argv[])
{



	PGconn *database = databaseTool::ConnectDB("user=postgres password=q1q1q1 dbname=postgres hostaddr=127.0.0.1 port=5432");
	//databaseTool::CreateAccountTable(database);
	//int x = databaseTool::CreateAccount("jon","q1");
	//cout << x;

	try
	{
		printf("Starting server\n");
		boost::asio::io_service io_service;
		boost::thread guiThread(boost::bind(gui, &io_service));
		udpServer serverUdp(io_service);
		tcpServer serverTcp(io_service);
		io_service.run();
	}
	catch (std::exception& e)
	{
		std::cerr << e.what() << std::endl;
	}
	return 0;
}

