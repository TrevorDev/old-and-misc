#ifndef GLOBAL_H
#define GLOBAL_H
#include <GL/glfw.h>

class Global
{
    public:
        static float time;
        static float lastTime;
        static float deltaTime;
        static int maxFPS;
        static int curFPS;
        static int modelQuality;
        static float maxFPSTimeOffset;
        static float secondsTillRecheck;
        static float gravity;
        static void frameRun();
    protected:
    private:
};

#endif // GLOBAL_H
