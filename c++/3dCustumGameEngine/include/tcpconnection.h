#ifndef TCPCONNECTION_H
#define TCPCONNECTION_H
#include <ctime>
#include <iostream>
#include <string>
#include <boost/array.hpp>
#include <boost/bind.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/asio.hpp>
#include <boost/enable_shared_from_this.hpp>
#include "buffertool.h"
#include "databasetool.h"

using boost::asio::ip::tcp;
using namespace std;
class tcpConnection : public boost::enable_shared_from_this<tcpConnection>
{
	public:
		static string make_daytime_string();
		typedef boost::shared_ptr<tcpConnection> pointer;
		static pointer create(boost::asio::io_service& io_service);
		tcp::socket& socket();
		void start();
		tcpConnection(boost::asio::io_service& io_service);
		void handle_read(const boost::system::error_code& /*error*/, std::size_t /*bytes_transferred*/);
		void runCommand(BufferTool * bt);
		void handle_write();
		tcp::socket socket_;
		std::string message_;
		std::string message_2;
		boost::array<char, BUFFER_SIZE> recv_buffer_;
	protected:
	private:
};

#endif // TCPCONNECTION_H