#ifndef LOGINRESPONSE_H
#define LOGINRESPONSE_H
#include "serverresponse.h"
#include <stdlib.h>
#include <stdio.h>
#include <string>
#include "commandhandler.h"
using namespace std;

class LoginResponse : public ServerResponse
{
public:
	void sendReq(string userName,string pass);
	LoginResponse(float timeOut);
	virtual ~LoginResponse();
protected:
private:
};

#endif // LOGINRESPONSE_H
