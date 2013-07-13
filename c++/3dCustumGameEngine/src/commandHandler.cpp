#include "commandhandler.h"
tcp::socket* CommandHandler::tcpSocket;
udp::socket* CommandHandler::udpSocket;
void CommandHandler::init(tcp::socket * tcp, udp::socket * udp)
{
	tcpSocket=tcp;
	udpSocket=udp;
}

void CommandHandler::test()
{
	//int x = 5;
}

void CommandHandler::login(char * userName, char * password, char msgNum){
	
	BufferTool bt;
	char cmd = 1;
	string un = userName;
	string p = password;
	bt.addCmd(cmd);
	bt.addCmd(msgNum);
	bt.addString(un);
	bt.addString(p);
	tcpSocket->send(boost::asio::buffer(bt.getBuffer(), bt.getPos()));
}

void CommandHandler::createAccount(char * userName, char * password){
	BufferTool bt;
	char cmd = 0;
	string un = userName;
	string p = password;
	bt.addCmd(cmd);
	bt.addString(un);
	bt.addString(p);
	tcpSocket->send(boost::asio::buffer(bt.getBuffer(), bt.getPos()));
}