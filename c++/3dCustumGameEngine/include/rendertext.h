#ifndef RENDERTEXT_H
#define RENDERTEXT_H

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <ft2build.h>
#include FT_FREETYPE_H
#include FT_GLYPH_H
#include FT_OUTLINE_H
#include FT_TRIGONOMETRY_H
#include <GL/glfw.h>
#include <deque>
using namespace std;
#define DPI 72

class RenderText
{
    public:
		static deque<RenderText *> selectedInputs;
		static FT_Library library;
		static int npo2(int x);
		static void init();

		FT_Face face;
		FT_Glyph glyph;
		FT_BitmapGlyph bitmap_glyph;
		FT_Bitmap bitmap;
		GLuint * textures;
		string text;
		string dispText;
		int x;
		int y;
		int pixelSize;
		int inputAllowed;
		RenderText(string filename, string x, int pixel_size, int xPos, int yPos, int input);
		void draw();
		void setPos(int x,int y);
        virtual ~RenderText();
    protected:
    private:
};

#endif // RENDERTEXT_H
