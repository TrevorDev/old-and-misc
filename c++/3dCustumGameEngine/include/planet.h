#ifndef PLANET_H
#define PLANET_H
#include <vector>
#include "basevector.h"
#include "baseobject.h"
#include "shapegen.h"
using namespace std;

class Planet
{
    public:
        static vector<Planet*> planets;
        BaseVector pos;
        float mass;
        BaseObject * planetModel;
		static void unloadPlanets();
        Planet(BaseVector pos, float mass, float radius, int segments, int rings);
        virtual ~Planet();
    protected:
    private:
};

#endif // PLANET_H
