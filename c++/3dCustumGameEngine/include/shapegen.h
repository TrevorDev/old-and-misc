#ifndef SHAPEGEN_H
#define SHAPEGEN_H
#include "basevector.h"
#include "plane.h"
#include <deque>
#include <math.h>
#include <stdio.h>
#include "baseobject.h"
#define PI 3.14159265
using namespace std;

class ShapeGen
{
    public:
        static BaseObject* genSphere(BaseVector pos,float radius, int segments, int rings);
        static BaseObject* genRectangularPrism(BaseVector pos,BaseVector len);
    protected:
    private:
};

#endif // SHAPEGEN_H
