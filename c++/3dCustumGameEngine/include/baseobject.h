#ifndef BASEOBJECT_H
#define BASEOBJECT_H
#include <GL/glfw.h>
#include <deque>
#include "plane.h"
#include "basevector.h"


using namespace std;
class BaseObject
{
    public:
        BaseVector pos;
        BaseVector rot;
        deque<Plane*> planes;
        deque<BaseVector*> verts;
        void draw();
        void move(BaseVector x);
        void rotAroundPoint(BaseVector pos, BaseVector rot);
        void rotWithVec(BaseVector oldUp, BaseVector oldForward, BaseVector oldRight, BaseVector up, BaseVector forward, BaseVector right,BaseVector base);
        BaseObject();
        virtual ~BaseObject();
    protected:
    private:
};

#endif // BASEOBJECT_H
