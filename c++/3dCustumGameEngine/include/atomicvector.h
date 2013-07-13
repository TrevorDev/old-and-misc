#ifndef ATOMICVECTOR_H
#define ATOMICVECTOR_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <vector>
#include "account.h"
#include "basevector.h"
#include <boost/thread/mutex.hpp>
using namespace std;

template <class T>
class AtomicVector
{
public:
	vector<T*> vec;
	boost::mutex inUse;
	AtomicVector();
	virtual ~AtomicVector();
protected:
private:
};
#include "atomicVector.cpp"
#endif // ATOMICVECTOR_H
