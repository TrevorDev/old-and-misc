#include "loginresponse.h"

void LoginResponse::sendReq(string userName,string pass){
	this->clear();
	ServerResponse::addReq(this);
	CommandHandler::login((char *)userName.c_str(), (char *)pass.c_str(), this->reqNum);
}

LoginResponse::LoginResponse(float timeOut): ServerResponse(timeOut)
{
	
}

LoginResponse::~LoginResponse()
{

}