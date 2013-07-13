#ifndef SERVERRESPONSE_H
#define SERVERRESPONSE_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <boost/thread/mutex.hpp>
using namespace std;

class ServerResponse
{
public:
	static boost::mutex mapUse;
	static unsigned char msgNum;
	static map<unsigned char ,ServerResponse*> responses;
	volatile bool success;
	volatile bool complete;
	volatile bool waitingForReply;
	//needed?
	boost::mutex respUse;
	unsigned char reqNum;
	float timeOut;
	float startTime;
	static void addReq(ServerResponse* resp);
	static ServerResponse * getResp(unsigned char num);
	static void doneResp();
	static void removeResp(ServerResponse* resp);
	static void removeAndDeleteResp(ServerResponse* resp);
	bool checkTimeOut();
	void clear();
	ServerResponse(float timeOut);
	virtual ~ServerResponse();
protected:
private:
};

#endif // SERVERRESPONSE_H
