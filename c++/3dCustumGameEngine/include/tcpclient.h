#ifndef TCPCLIENT_H
#define TCPCLIENT_H
#include <ctime>
#include <iostream>
#include <string>
#include <boost/array.hpp>
#include <boost/bind.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/asio.hpp>
#include <boost/enable_shared_from_this.hpp>
#include "buffertool.h"
#include "commandhandler.h"

using boost::asio::ip::tcp;
using namespace std;
class tcpClient : public boost::enable_shared_from_this<tcpClient>
{
	public:
		static string make_daytime_string();
		typedef boost::shared_ptr<tcpClient> pointer;
		static pointer create(tcp::socket * socket);
		void start();
		tcpClient(tcp::socket * socket);
		void handle_read(const boost::system::error_code& /*error*/, std::size_t /*bytes_transferred*/);
		void runCommand(BufferTool * bt);
		void handle_write();
		tcp::socket * socket;
		std::string message_;
		std::string message_2;
		boost::array<char, BUFFER_SIZE> recv_buffer_;
	protected:
	private:
};

#endif // TCPClient_H