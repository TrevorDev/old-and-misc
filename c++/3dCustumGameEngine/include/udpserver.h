#ifndef UDPSERVER_H
#define UDPSERVER_H
#include <ctime>
#include <iostream>
#include <string>
#include <boost/array.hpp>
#include <boost/bind.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/asio.hpp>
#include "buffertool.h"
using boost::asio::ip::udp;
using namespace std;

class udpServer
{
    public:
		udpServer(boost::asio::io_service& io_service);
		void start_receive();
		void handle_receive(const boost::system::error_code& error,std::size_t /*bytes_transferred*/);
		void handle_send(boost::shared_ptr<std::string> /*message*/, const boost::system::error_code& /*error*/, std::size_t /*bytes_transferred*/);
		static string make_daytime_string();
		udp::socket socket_;
		udp::endpoint remote_endpoint_;
		boost::array<char, BUFFER_SIZE> recv_buffer_;
	protected:
    private:
};

#endif // UDPSERVER_H