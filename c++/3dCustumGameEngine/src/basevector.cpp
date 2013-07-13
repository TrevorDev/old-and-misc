#include "basevector.h"
#include <stdio.h>
void BaseVector::setAll(float x)
{
    this->x=x;
    this->y=x;
    this->z=x;
}

BaseVector BaseVector::subtract(BaseVector a,BaseVector b)
{
    a.x=a.x-b.x;
    a.y=a.y-b.y;
    a.z=a.z-b.z;
    return a;
}

int BaseVector::isZero()
{
    return (this->x==0)&&(this->y==0)&&(this->z==0);
}

BaseVector BaseVector::add(BaseVector a,BaseVector b)
{
    a.x=a.x+b.x;
    a.y=a.y+b.y;
    a.z=a.z+b.z;
    return a;
}

BaseVector BaseVector::scaleMult(BaseVector a,float x)
{
    a.x=a.x*x;
    a.y=a.y*x;
    a.z=a.z*x;
    return a;
}

float BaseVector::mult(BaseVector a,BaseVector b)
{
    float ret;
    ret = a.x*b.x;
    ret += a.y*b.y;
    ret += a.z*b.z;
    return ret;
}

void BaseVector::print()
{
    printf("%lf %lf %lf\n", this->x, this->y, this->z);
}

float BaseVector::getMag()
{
    return sqrt(this->x*this->x+this->y*this->y+this->z*this->z);
}

BaseVector BaseVector::setMag(BaseVector vec, float x)
{
    float ratio = sqrt(vec.x*vec.x+vec.y*vec.y+vec.z*vec.z)/x;
    vec.x/=ratio;
    vec.y/=ratio;
    vec.z/=ratio;
    return vec;
}

BaseVector::BaseVector(float x, float y, float z)
{
    this->x=x;
    this->y=y;
    this->z=z;
}
BaseVector::BaseVector(BaseVector * x)
{
    this->x=x->x;
    this->y=x->y;
    this->z=x->z;
}

BaseVector::BaseVector()
{
}
BaseVector::~BaseVector()
{
    //dtor
}
