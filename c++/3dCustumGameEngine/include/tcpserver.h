#ifndef TCPSERVER_H
#define TCPSERVER_H
#include <ctime>
#include <iostream>
#include <string>
#include <boost/array.hpp>
#include <boost/bind.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/asio.hpp>
#include "tcpconnection.h"
using boost::asio::ip::udp;
using namespace std;

class tcpServer
{
	public:
		tcpServer(boost::asio::io_service& io_service);
		void start_accept();
		void handle_accept(tcpConnection::pointer new_connection, const boost::system::error_code& error);
		tcp::acceptor acceptor_;
	protected:
	private:
};

#endif // TCPSERVER_H