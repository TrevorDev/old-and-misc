#ifndef PLAYER_H
#define PLAYER_H
#include "basevector.h"
#include "baseobject.h"
#include "shapegen.h"
#include "planet.h"
#include "camera.h"
#include "physics.h"
#include "global.h"
#include "projectile.h"
class Player
{
    public:
        static Player * player;
        BaseObject * body;
        BaseVector collidePoint;
        BaseVector spd;
        BaseVector acc;
        BaseVector rot;
        BaseVector nxtRot;
        BaseVector up;
        BaseVector forward;
        BaseVector right;
        int grounded;
        float turnRot;
        void faceCam();
        Player(BaseVector pos);
        virtual ~Player();
        void enterFrame();
        void receiveInput();
    protected:
    private:
};

#endif // PLAYER_H
