#include "tcpconnection.h"
#include <iostream>
#include <algorithm>
#include <vector>
#include <time.h>
typedef boost::shared_ptr<tcpConnection> pointer;

pointer tcpConnection::create(boost::asio::io_service& io_service)
{
	return pointer(new tcpConnection(io_service));
}

tcp::socket& tcpConnection::socket()
{
	return socket_;
}

void tcpConnection::start()
{

	message_ = make_daytime_string();
	socket_.async_read_some(boost::asio::buffer(recv_buffer_), boost::bind( &tcpConnection::handle_read,shared_from_this(),boost::asio::placeholders::error,boost::asio::placeholders::bytes_transferred));
}


tcpConnection::tcpConnection(boost::asio::io_service& io_service) : socket_(io_service)
{
}

void tcpConnection::handle_read(const boost::system::error_code& error, std::size_t bytes_transferred)
{
	if (!error){
		BufferTool * bt = new BufferTool(recv_buffer_);
		runCommand(bt);
		delete bt;
		start();
	}else{
		cout << error.message();
	}
}

void tcpConnection::handle_write()
{
}

string tcpConnection::make_daytime_string()
{
  using namespace std; // For time_t, time and ctime;
  unsigned int size = 26;
  char str[80];
  time_t now = time(0);
  //ctime_s(str,size,&now);
  return str;
}

void tcpConnection::runCommand(BufferTool * bt){
	unsigned char cmd = bt->getCmd();
	switch(cmd){
		//create account
		case 0:{
			printf("creating account:\n", cmd);
			unsigned char requestVal = bt->getCmd();
			string userName = bt->getString();
			string pass = bt->getString();
			BufferTool * ret = new BufferTool();
			ret->addCmd(0);
			ret->addCmd(requestVal);
			if(databaseTool::CreateAccount(userName,pass)){
				ret->addCmd(1);
			}else{
				printf("account creation failed\n");
				ret->addCmd(0);
			}
			boost::asio::async_write(socket_,boost::asio::buffer(ret->getBuffer(), ret->getPos()), boost::bind( &tcpConnection::handle_write,shared_from_this()));
			delete ret;
			break;
		}
		case 1:{
			printf("logging in:\n", cmd);
			unsigned char requestVal = bt->getCmd();
			string userName = bt->getString();
			string pass = bt->getString();
			Account * acc = databaseTool::GetAccount((char*)(userName.c_str()));
			BufferTool * ret = new BufferTool();
			ret->addCmd(1);
			ret->addCmd(requestVal);
			if(acc!=0&&acc->password==pass){
				ret->addCmd(1);
			}else{
				printf("logging in failed\n");
				ret->addCmd(0);
			}
			boost::asio::async_write(socket_,boost::asio::buffer(ret->getBuffer(), ret->getPos()), boost::bind( &tcpConnection::handle_write,shared_from_this()));
			delete ret;
			delete acc;
			break;
		}
	}
}