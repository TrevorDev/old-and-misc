#ifndef COMMANDHANDLER_H
#define COMMANDHANDLER_H
#include <boost/array.hpp>
#include <boost/asio.hpp>
#include "buffertool.h"
using namespace std;
using boost::asio::ip::udp;
using boost::asio::ip::tcp;
class CommandHandler
{
	public:
		static void init(tcp::socket * tcp, udp::socket * udp);
		static void login(char * userName, char * password, char msgNum);
		static void test();
		static void createAccount(char * userName, char * password);
		static tcp::socket * tcpSocket;
		static udp::socket * udpSocket;
	protected:
	private:
};

#endif // COMMANDHANDLER_H