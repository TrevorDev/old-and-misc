#ifndef PHYSICS_H
#define PHYSICS_H
#include<stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "basevector.h"
#include "baseobject.h"
#include "plane.h"
#define PI 3.14159265


class Physics
{
    public:
        static BaseVector * hitPoint(BaseVector start, BaseVector end,Plane * plane,int * valid);
        static BaseVector * collidePoint(BaseVector up,BaseVector start, BaseVector end,Plane * plane,int * valid);
        static BaseVector cross(BaseVector x, BaseVector y, BaseVector z);
        static BaseVector cross(BaseVector x, BaseVector y);
        static BaseVector rotAroundPoint(BaseVector pivot, BaseVector point, BaseVector rot);
        static BaseVector newOrientation(BaseVector oldUp, BaseVector oldForward, BaseVector oldRight, BaseVector up, BaseVector forward, BaseVector right,BaseVector base, BaseVector point);
        static float getZYDeg(BaseVector vec);
        static float getXZDeg(BaseVector vec);
        static BaseVector upAndForward(BaseVector oldUp, BaseVector up,BaseVector * right,BaseVector * forward);
        static BaseVector solveThree(BaseVector up, BaseVector forward, BaseVector right, BaseVector mix, int * valid);
        static BaseVector solveThree(BaseVector up, BaseVector forward, BaseVector mix, int * valid);
        static BaseVector solveThree(BaseVector vec,BaseVector mix, int * valid);
        Physics();
        virtual ~Physics();
    protected:
    private:
};

#endif // PHYSICS_H
