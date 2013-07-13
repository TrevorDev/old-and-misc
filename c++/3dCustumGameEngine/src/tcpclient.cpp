#include "tcpclient.h"
#include <iostream>
#include <algorithm>
#include <vector>
#include "loginresponse.h"
typedef boost::shared_ptr<tcpClient> pointer;
pointer tcpClient::create(tcp::socket * socket)
{
	return pointer(new tcpClient(socket));
}

void tcpClient::start()
{
	socket->async_receive(boost::asio::buffer(recv_buffer_), boost::bind( &tcpClient::handle_read,shared_from_this(),boost::asio::placeholders::error,boost::asio::placeholders::bytes_transferred));
}


tcpClient::tcpClient(tcp::socket * socket)
{
	this->socket=socket;
}

void tcpClient::handle_read(const boost::system::error_code& error, std::size_t bytes_transferred)
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

void tcpClient::handle_write()
{
}

string tcpClient::make_daytime_string()
{
  using namespace std; // For time_t, time and ctime;
  unsigned int size = 26;
  char str[80];
  time_t now = time(0);
  //ctime_s(str,size,&now);
  return str;
}

void tcpClient::runCommand(BufferTool * bt){
	unsigned char cmd = bt->getCmd();
	switch(cmd){
		//create account response
		case 0:{
			unsigned char requestVal = bt->getCmd();
			unsigned char returnStatus = bt->getCmd();
			ServerResponse* resp = ServerResponse::getResp(requestVal);
			if(resp!=NULL){
				if(returnStatus==1){
					resp->success=true;
				}else{
					resp->success=false;
				}
				resp->complete=true;
			}
			ServerResponse::doneResp();
			break;
		}
		case 1:{
			printf("received login ret\n");
			unsigned char requestVal = bt->getCmd();
			unsigned char returnStatus = bt->getCmd();
			map<unsigned char ,ServerResponse*>::const_iterator keyVal = ServerResponse::responses.find(requestVal);

			if ( keyVal == ServerResponse::responses.end() ){
				std::cout << "not found";
			}else{
				if(returnStatus==1){
					keyVal->second->success=true;
				}else{
					keyVal->second->success=false;
				}
				keyVal->second->complete=true;
			}
			break;
		}
	}
}