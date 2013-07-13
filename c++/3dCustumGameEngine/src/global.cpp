#include "global.h"
#include <stdio.h>
float Global::time=0;
float Global::lastTime=0;
float Global::deltaTime=0;
int Global::maxFPS=120;
int Global::curFPS=0;
int Global::modelQuality=1;
float Global::maxFPSTimeOffset=0;
float Global::secondsTillRecheck=1;
float Global::gravity=20;

void Global::frameRun(){
    static float timeWait=glfwGetTime();
    static int frameCount=0;
    frameCount++;
    lastTime=time;
    time = glfwGetTime();
    deltaTime=time-lastTime;
    if(maxFPS>0&&maxFPSTimeOffset>0){
        glfwSleep(maxFPSTimeOffset);
    }
    if(time-timeWait>secondsTillRecheck){
        curFPS=frameCount/secondsTillRecheck;
        timeWait=time;
        frameCount=0;
        if(maxFPS>0&&curFPS>0){
        maxFPSTimeOffset+=(1/(double)maxFPS)-(1/(double)curFPS);
        }
        //printf("%d %lf\n",curFPS, maxFPSTimeOffset);
    }
}
