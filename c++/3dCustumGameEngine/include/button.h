#ifndef BUTTON_H
#define BUTTON_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <GL/glfw.h>
#include "tga.h"
#include <deque>
using namespace std;

class Button
{
    public:
		static deque<Button *> buttons;

		unsigned int texName[1];
		tgaInfo *pic;
		int x;
		int y;
		int xPercent;
		int yPercent;
		int length;
		int width;
		int clicked;

		Button(string filename, int length, int width, int xPos, int yPos);
		void draw();
        virtual ~Button();
    protected:
    private:
};

#endif // BUTTON_H
