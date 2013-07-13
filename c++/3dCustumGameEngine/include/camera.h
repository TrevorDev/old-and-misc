#ifndef CAMERA_H
#define CAMERA_H
#include <GL/glfw.h>
#include <math.h>
#include "basevector.h"
#include "global.h"
#include "input.h"
#include "player.h"
#define PI 3.14159265
class Camera
{
    public:
        static int mode;
        static float moveSpd;
        static float rotSpd;
        static BaseVector pos;
        static BaseVector look;
        static BaseVector up;
        static BaseVector rot;
        static void init();
        static void enterFrame();
        static void receiveInput();
    protected:
    private:
};

#endif // CAMERA_H
