#ifndef MOUSE_H
#define MOUSE_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <GL/glfw.h>
#include "tga.h"
using namespace std;

class Mouse
{
    public:

		unsigned int texName[1];
		tgaInfo *image;
		int x;
		int y;
		int length;
		int width;

		Mouse(string filename, int length, int width, int xPos, int yPos);
		void draw();
        virtual ~Mouse();
    protected:
    private:
};

#endif // MOUSE_H
