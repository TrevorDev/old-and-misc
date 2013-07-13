#ifndef IMAGE_H
#define IMAGE_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <GL/glfw.h>
#include "tga.h"
using namespace std;

class Image
{
    public:

		unsigned int texName[1];
		tgaInfo *pic;
		int x;
		int y;
		int length;
		int width;

		Image(string filename, int length, int width, int xPos, int yPos);
		void draw();
        virtual ~Image();
    protected:
    private:
};

#endif // IMAGE_H
