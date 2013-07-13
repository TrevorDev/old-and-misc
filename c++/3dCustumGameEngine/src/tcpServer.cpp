#include "tcpserver.h"

tcpServer::tcpServer(boost::asio::io_service& io_service) : acceptor_(io_service, tcp::endpoint(tcp::v4(), 14))
{
	start_accept();
}

void tcpServer::start_accept()
{
	
	tcpConnection::pointer new_connection = tcpConnection::create(acceptor_.get_io_service());

	acceptor_.async_accept(new_connection->socket(),
		boost::bind(&tcpServer::handle_accept, this, new_connection,
		boost::asio::placeholders::error));
}

void tcpServer::handle_accept(tcpConnection::pointer new_connection, const boost::system::error_code& error)
{
	if (!error)
	{
		printf("new connection\n");
		new_connection->start();
		start_accept();
	}
}
