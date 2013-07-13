#include "planet.h"
vector<Planet*> Planet::planets;

void Planet::unloadPlanets(){
	for (vector<Planet*>::iterator i = planets.begin(); i != planets.end(); ++i)
        {
            delete (*i);
        }
}

Planet::Planet(BaseVector pos, float mass, float radius, int segments, int rings)
{
    this->pos=pos;
    this->mass = mass;
    this->planetModel = ShapeGen::genSphere(pos,radius, segments, rings);
//    BaseVector len;
//    len.x=20;
//    len.y=20;
//    len.z=20;
//    this->planetModel = ShapeGen::genRectangularPrism(pos,len);
    planets.push_back(this);
}

Planet::~Planet()
{
    delete planetModel;
}
