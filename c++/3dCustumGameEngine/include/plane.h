#ifndef PLANE_H
#define PLANE_H
#include "basevector.h"

class Plane
{
    public:
        Plane(BaseVector* v1, BaseVector* v2, BaseVector* v3);
        virtual ~Plane();
        void calcNormal();
        BaseVector* vertices[3];
        BaseVector* normal;

    protected:
    private:
};

#endif // PLANE_H
