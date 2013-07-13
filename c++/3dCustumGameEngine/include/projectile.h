#ifndef PROJECTILE_H
#define PROJECTILE_H
#include <vector>
#include "basevector.h"
#include "baseobject.h"
#include "shapegen.h"
#include "planet.h"
#include "global.h"
#include "physics.h"
class Projectile
{
    public:
        static vector<Projectile*> projectiles;
        BaseVector pos;
        BaseVector spd;
        BaseObject * projectileModel;
		static void unloadProjectiles();
        static void draw();
        static void move();
        Projectile(BaseVector pos, BaseVector spd);
        virtual ~Projectile();
    protected:
    private:
};

#endif // PROJECTILE_H
