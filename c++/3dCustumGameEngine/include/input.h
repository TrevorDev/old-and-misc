#ifndef INPUT_H
#define INPUT_H
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <GL/glfw.h>
#include "key.h"
#include <vector>
#include "rendertext.h"
#include "mouse.h"
#include "button.h"


using namespace std;
class Input
{
    public:
        static int mouseDeltaX;
        static int mouseDeltaY;
        static int mouseCurX;
        static int mouseCurY;
        static int mouseCurScroll;
        static int mouseDeltaScroll;
        static int mouseLeft;


        static Key space;
        static Key up;
        static Key down;
        static Key left;
        static Key right;
        static Key one;
        static Key two;
		static Key q;
		static Key enter;
		static Key shift;

		
		
		static Mouse * mouse;

        static vector<Key*> keys;
        static void setUpKeys();
		static void unloadKeys();
        static void keyHandler(int key, int action);
        static void mouseHandler(int x, int y);
        static void checkMouseMovement();
        static void checkMouseWheel();
        static void checkMouseButtons();
        Input();
        virtual ~Input();
    protected:
    private:
};

#endif // INPUT_H
