#include "image.h"







Image::Image(string filename, int length, int width, int xPos, int yPos){
	glEnable(GL_DEPTH_TEST);
	glGenTextures(1, texName);
	pic = tgaLoad((char *)filename.c_str());
	glBindTexture(GL_TEXTURE_2D,texName[0]);
	glTexParameteri(GL_TEXTURE_2D,	GL_TEXTURE_WRAP_S,	GL_REPEAT);
	glTexParameteri(GL_TEXTURE_2D,	GL_TEXTURE_WRAP_T,	GL_REPEAT);

	glTexParameteri(GL_TEXTURE_2D,	GL_TEXTURE_MAG_FILTER	,GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D,	GL_TEXTURE_MIN_FILTER	,GL_LINEAR);
	
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, pic->width, pic->height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pic->imageData);

	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, 0);
	this->x=xPos;
	this->y=yPos;
	this->width=width;
	this->length=length;
}



void Image::draw(){
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	int stageWidth, stageHeight;
	glfwGetWindowSize(&stageWidth, &stageHeight);
	glOrtho(0.0f, stageWidth, 0.0f, stageHeight, 0.0f, 1.0f);
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glPushMatrix();


        glPushMatrix();
				glEnable(GL_BLEND);
				glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
				glEnable(GL_ALPHA_TEST);
				//	glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE);
				glAlphaFunc(GL_GREATER, 0);
				glBindTexture(GL_TEXTURE_2D,texName[0]);
        glBegin(GL_QUADS);
            glTexCoord2f(1.0f,1.0f);glVertex2f(width+x, length+y);
			glTexCoord2f(1.0f,0.0f);glVertex2f(width+x, y);
			glTexCoord2f(0.0f,0.0f);glVertex2f(x,y);
			glTexCoord2f(0.0f,1.0f);glVertex2f(x, length+y);
        glEnd();
        glPopMatrix();
	glPopMatrix();
	glPopMatrix();
	glMatrixMode(GL_PROJECTION);
	glPopMatrix();
}


Image::~Image()
{
	tgaDestroy(pic);
}
