#ifndef ROOM_H
#define ROOM_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include "atomicvector.h"
#include "account.h"
#include "basevector.h"
#include <boost/thread/mutex.hpp>
using namespace std;

class Room
{
public:
	AtomicVector<Account*> accounts;
	BaseVector pos;
	Room();
	virtual ~Room();
protected:
private:
};

#endif // ROOM_H
