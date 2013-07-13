#include "buffertool.h"
#include <string.h>
#include <stdio.h>
BufferTool::BufferTool(boost::array<char,BUFFER_SIZE> buffer)
{
	this->buffer = buffer;
	this->pos = 0;
	this->invalid = false;
}

BufferTool::BufferTool()
{
	this->pos = 0;
}

boost::array<char,BUFFER_SIZE> BufferTool::getBuffer(){
	return buffer;
}

int BufferTool::getPos(){
	return pos;
}

bool BufferTool::outsideBuffer(){
	bool ret = false;
	if(pos+1>=BUFFER_SIZE){
		printf("buffer is out of bounds\n");
		ret=true;
	}
	return ret;
}

bool BufferTool::outsideBuffer(int x){
	bool ret = false;
	if(pos+1+x>=BUFFER_SIZE){
		printf("buffer is out of bounds\n");
		ret=true;
	}
	return ret;
}

char BufferTool::getCmd(){
	if(outsideBuffer()){
		return 0;
	}
	char ret;
	ret = buffer[pos++];
	return ret;
}

void BufferTool::addCmd(char x){
	if(outsideBuffer()){
		return;
	}
	buffer[pos++]=x;
}

unsigned int BufferTool::getUInt()
{
	if(outsideBuffer(4)){
		return 0;
	}
	unsigned int ret;
	ret = buffer[pos++]<<24;
	ret+=buffer[pos++]<<16;
	ret+=buffer[pos++]<<8;
	ret+=buffer[pos++];
	return ret;
}

void BufferTool::addUInt(unsigned int x)
{
	if(outsideBuffer(4)){
		return;
	}
	for(int i =0;i<4;i++){
		buffer[pos+i]=(x >> ((3-i)*8));
	}
	pos+=4;
}




int BufferTool::getInt()
{
	if(outsideBuffer(4)){
		return 0;
	}
	unsigned int ret;
	ret = (unsigned char)buffer[pos++]<<24;
	ret+=(unsigned char)buffer[pos++]<<16;
	ret+=(unsigned char)buffer[pos++]<<8;
	ret+=(unsigned char)buffer[pos++];
	return ret;
}
//string and int are broken :'(
void BufferTool::addInt(int x)
{
	if(outsideBuffer(4)){
		return;
	}
	for(int i =0;i<4;i++){
		buffer[pos+i]=(x >> ((3-i)*8));
	}
	pos+=4;
}




string BufferTool::getString(){
	if(outsideBuffer()){
			return 0;
	}
	int place = pos;
	while(buffer[pos]!=0){
		pos++;
		if(outsideBuffer()){
			return 0;
		}
	}
	pos++;
	string ret(buffer.begin()+place, buffer.begin()+pos-1);
	return ret;
}

void BufferTool::addString(string x){
	if(outsideBuffer()){
			return;
	}
	string::iterator itr;
	for(itr = x.begin(); itr != x.end(); itr++)
	{
		if(outsideBuffer()){
			return;
		}
		buffer[pos++]=*itr;
	}
	buffer[pos++]=0;
}
