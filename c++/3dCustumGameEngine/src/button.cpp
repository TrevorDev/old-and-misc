#include "button.h"

deque<Button *> Button::buttons;

Button::Button(string filename, int length, int width, int xPos, int yPos){
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
	this->xPercent=xPos;
	this->yPercent=yPos;
	this->width=width;
	this->length=length;
	clicked=0;
	buttons.push_back(this);
}



void Button::draw(){
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	int stageWidth, stageHeight;
	glfwGetWindowSize(&stageWidth, &stageHeight);
	glOrtho(0.0f, stageWidth, 0.0f, stageHeight, 0.0f, 1.0f);
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glPushMatrix();
	x = (((float)xPercent/100)*stageWidth), y=(((float)yPercent/100)*stageHeight);
        glPushMatrix();
				glEnable(GL_BLEND);
				glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
				glEnable(GL_ALPHA_TEST);
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


Button::~Button()
{

	deque<Button *>::iterator rit;
	for(rit=buttons.begin() ; rit < buttons.end(); rit++){
		if((*rit)==this){
			buttons.erase(rit);
			break;
		}
	}

	tgaDestroy(pic);
}
