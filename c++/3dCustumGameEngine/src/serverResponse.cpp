#include "serverresponse.h"
#include <GL/glfw.h>

boost::mutex ServerResponse::mapUse;
unsigned char ServerResponse::msgNum=0;
map<unsigned char ,ServerResponse*> ServerResponse::responses;

bool ServerResponse::checkTimeOut(){
	if(this->waitingForReply&&glfwGetTime()-this->startTime>=this->timeOut){
		ServerResponse::removeResp(this);
		this->waitingForReply=false;
		return true;
	}else{
		return false;
	}
}

void ServerResponse::clear(){
	this->waitingForReply=true;
	this->success=false;
	this->complete=false;
	this->startTime=glfwGetTime();
}

ServerResponse::ServerResponse(float timeOut)
{
	this->complete=false;
	this->success=false;
	this->waitingForReply=false;
	this->timeOut = timeOut;
	reqNum=0;
}

void ServerResponse::addReq(ServerResponse* resp){
	mapUse.lock();
	resp->reqNum=msgNum;
	responses.insert(make_pair<unsigned char ,ServerResponse*>(msgNum++, resp));
	mapUse.unlock();
}

void ServerResponse::removeResp(ServerResponse* resp){
	if(resp!=NULL){
		mapUse.lock();
		responses.erase(resp->msgNum);
		mapUse.unlock();
	}
}

void ServerResponse::removeAndDeleteResp(ServerResponse* resp){
	if(resp!=NULL){
		mapUse.lock();
		responses.erase(resp->msgNum);
		delete resp;
		mapUse.unlock();
	}
}

ServerResponse * ServerResponse::getResp(unsigned char num){
	mapUse.lock();
	map<unsigned char ,ServerResponse*>::const_iterator keyVal = ServerResponse::responses.find(num);
	if ( keyVal == responses.end() ){
		return NULL;
	}else{
		return keyVal->second;
	}
}

void ServerResponse::doneResp(){
	mapUse.unlock();
}

ServerResponse::~ServerResponse()
{

}
