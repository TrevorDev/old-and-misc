#include "rendertext.h"

FT_Library RenderText::library;
deque<RenderText *> RenderText::selectedInputs;

void RenderText::init(){
	FT_Init_FreeType(&library);
}

/* calculate the next power of 2 for x. */
int RenderText::npo2(int x) {
    int result = 1;
    while (result < x) {
        result *= 2;
    }
    return result;
}


RenderText::RenderText(string filename, string x, int pixel_size, int xPos, int yPos, int input)
{
	dispText=x;
	inputAllowed = input;
	pixelSize=pixel_size;
	this->text.append(x);
	setPos(xPos, yPos);
    FT_New_Face(library, filename.c_str(), 0, &face);
    FT_Set_Char_Size(face, pixelSize * 64, pixelSize * 64, DPI, DPI);
	if(input){
		selectedInputs.push_back(this);
	}
}

void RenderText::setPos(int xPos, int yPos){
	int width, height;
	glfwGetWindowSize(&width, &height);
	this->x=(width*xPos)/100;
	this->y=(height*yPos)/100;
}

void RenderText::draw(){
	//glClearColor(1, 1, 1, 0);
	glEnable(GL_BLEND);
    //glEnable(GL_TEXTURE_2D);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	//glDisable(GL_DEPTH_TEST);
	//glDisable(GL_CULL_FACE);
	//glDisable(GL_TEXTURE_2D);
	//glDisable(GL_LIGHTING);
	
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	int stageWidth, stageHeight;
	glfwGetWindowSize(&stageWidth, &stageHeight);
	glOrtho(0.0f, stageWidth, 0.0f, stageHeight, 0.0f, 1.0f);

	glMatrixMode(GL_MODELVIEW);
	int i;
	if(selectedInputs.size()>0&&selectedInputs[0]!=this&&inputAllowed&&text==""){
		dispText = "Click to type here";
	}else {
		dispText=text;
	}

	if(selectedInputs.size()>0&&selectedInputs[0]==this&&inputAllowed){
		static int curserOn = 0;
		static float prevSwitchTime=glfwGetTime();
		if(glfwGetTime()-prevSwitchTime>0.3){
			curserOn = !curserOn;
			prevSwitchTime=glfwGetTime();
		}
		if(curserOn){
			dispText.append("_");
		}
	}

	const size_t length = dispText.length();
	textures = (GLuint*)calloc(length, sizeof(GLuint));
    glGenTextures(length, textures);
	glPushMatrix();
    glTranslatef(x, y, 0);
	glPushMatrix();
    for (i = 0; i < length; ++i) {
		FT_Load_Glyph(face, FT_Get_Char_Index(face, dispText.at(i)), FT_LOAD_DEFAULT);
        FT_Get_Glyph(face->glyph, &glyph);
        FT_Glyph_To_Bitmap(&glyph, FT_RENDER_MODE_NORMAL, 0, 1);
        bitmap_glyph = (FT_BitmapGlyph)glyph;
        bitmap = bitmap_glyph->bitmap;

        int width = RenderText::npo2(bitmap.width);
        int height = RenderText::npo2(bitmap.rows);
        float x = (float)bitmap.width / (float)width;
        float y = (float)bitmap.rows / (float)height;

        glBindTexture(GL_TEXTURE_2D, textures[i]);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_ALPHA, GL_UNSIGNED_BYTE, 0);
		glPixelStorei(GL_UNPACK_ALIGNMENT,1); // no alignment
		glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, bitmap.width, bitmap.rows, GL_ALPHA, GL_UNSIGNED_BYTE, bitmap.buffer);

        glPushMatrix();
        glTranslatef(0, bitmap_glyph->top - bitmap.rows, 0);
        glBindTexture(GL_TEXTURE_2D, textures[i]);
        glBegin(GL_QUADS);
            glTexCoord2f(0, 0); glVertex2f(0, bitmap.rows);
            glTexCoord2f(0, y); glVertex2f(0, 0);
            glTexCoord2f(x, y); glVertex2f(bitmap.width, 0);
            glTexCoord2f(x, 0); glVertex2f(bitmap.width, bitmap.rows);
        glEnd();
        glPopMatrix();
        glTranslatef(glyph->advance.x / 65536, 0, 0);
        FT_Done_Glyph(glyph);
    }
	glPopMatrix();
	glPopMatrix();
	glMatrixMode(GL_PROJECTION);
	glPopMatrix();
	glDeleteTextures(length, textures);
    free(textures);
}


RenderText::~RenderText()
{
	if(inputAllowed){
		deque<RenderText *>::iterator rit;
		for(rit=selectedInputs.begin() ; rit < selectedInputs.end(); rit++){
			if((*rit)==this){
				selectedInputs.erase(rit);
				break;
			}
		}
	}
    FT_Done_Face(face);
}
