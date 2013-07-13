#include "account.h"

Account::Account(string un, string pw, int c){
	this->username=un;
	this->password=pw;
	this->cash=c;
}

Account::~Account()
{
}
