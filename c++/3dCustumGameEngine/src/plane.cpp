#include "plane.h"
#include "physics.h"
void Plane::calcNormal(){
    delete this->normal;
    this->normal=new BaseVector(&Physics::cross(*(this->vertices[0]),*(this->vertices[1]),*(this->vertices[2])));
}

Plane::Plane(BaseVector* v1, BaseVector* v2, BaseVector* v3)
{
    this->vertices[0]=v1;
    this->vertices[1]=v2;
    this->vertices[2]=v3;
    this->normal=new BaseVector(&Physics::cross(*v1,*v2,*v3));

}

Plane::~Plane()
{
    delete normal;
    //delete[] vertices;

}

