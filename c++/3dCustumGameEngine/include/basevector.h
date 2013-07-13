#ifndef BASEVECTOR_H
#define BASEVECTOR_H
#include <math.h>

class BaseVector
{
    public:
        float x;
        float y;
        float z;
        void setAll(float x);
        static BaseVector setMag(BaseVector vec, float x);
        float getMag();
        static BaseVector subtract(BaseVector a,BaseVector b);
        static BaseVector add(BaseVector a,BaseVector b);
        void print();
        static BaseVector scaleMult(BaseVector a,float x);
        static float mult(BaseVector a,BaseVector b);
        int isZero();
        BaseVector(float x, float y, float z);
        BaseVector(BaseVector * x);
        BaseVector();
        virtual ~BaseVector();
    protected:
    private:
};

#endif // BASEVECTOR_H
