#include "udpserver.h"
#include <stdio.h>
udpServer::udpServer(boost::asio::io_service& io_service) : socket_(io_service, udp::endpoint(udp::v4(), 13)){
	start_receive();
}

void udpServer::start_receive(){
	socket_.async_receive_from(boost::asio::buffer(recv_buffer_), remote_endpoint_, boost::bind(&udpServer::handle_receive, this, boost::asio::placeholders::error, boost::asio::placeholders::bytes_transferred));
}

void udpServer::handle_receive(const boost::system::error_code& error, std::size_t bytes_transferred){
	if (!error || error == boost::asio::error::message_size)
	{
		cout << remote_endpoint_.port();
		cout << " UDS: ";
		for(unsigned int i =0;i<bytes_transferred;i++){
			printf("%c",recv_buffer_[i]);
		}
		printf("\n");

		boost::shared_ptr<std::string> message(new std::string(recv_buffer_.begin(), recv_buffer_.end()));
		socket_.async_send_to(boost::asio::buffer(*message), remote_endpoint_,
			boost::bind(&udpServer::handle_send, this, message,
			boost::asio::placeholders::error,
			boost::asio::placeholders::bytes_transferred));

		start_receive();
	}
	//Sleep(10000);
	//printf("awake\n");
}

void udpServer::handle_send(boost::shared_ptr<std::string> /*message*/, const boost::system::error_code& /*error*/, std::size_t /*bytes_transferred*/){

}

string udpServer::make_daytime_string()
{
  using namespace std; // For time_t, time and ctime;
  unsigned int size = 26;
  char str[80];
  time_t now = time(0);
  //ctime_s(str,size,&now);
  return str;
}