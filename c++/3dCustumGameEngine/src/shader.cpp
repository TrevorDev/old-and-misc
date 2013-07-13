#include "shader.h"
#include <cstring>
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
using namespace std;

static char* textFileRead(const char *fileName) {
    char* text=0;

    if (fileName != NULL) {
        FILE *file = fopen(fileName, "rt");

        if (file != NULL) {
            fseek(file, 0, SEEK_END);
            int count = ftell(file);
            rewind(file);

            if (count > 0) {
                text = (char*)malloc(sizeof(char) * (count + 1));
                count = fread(text, sizeof(char), count, file);
                text[count] = '\0';
            }
            fclose(file);
        }else{
            printf("%s", "broken");
        }
    }
    //printf("\n%s\n", text);
    return text;
}

Shader::Shader() {}

Shader::Shader(const char *vsFile, const char *fsFile)
{
    init(vsFile, fsFile);
}

void Shader::init(const char *vsFile, const char *fsFile)
{
    shader_vp = glCreateShader(GL_VERTEX_SHADER);
    shader_fp = glCreateShader(GL_FRAGMENT_SHADER);

    const char *vsText = textFileRead(vsFile);
    const char *fsText = textFileRead(fsFile);

    if (vsText == NULL || fsText == NULL)
    {
        cerr << "Either vertex shader or fragment shader file is not found" << endl;
        return;
    }

    glShaderSource(shader_vp, 1, &vsText, 0);
    glShaderSource(shader_fp, 1, &fsText, 0);
	free((char*)vsText);
	free((char*)fsText);
    glCompileShader(shader_vp);
    glCompileShader(shader_fp);

    shader_id = glCreateProgram();

    glAttachShader(shader_id, shader_fp);

    glAttachShader(shader_id, shader_vp);
    int * x=0;
    char  y[5000];
    glGetShaderInfoLog(shader_fp,50,x,y);
    //cout << y;
    glLinkProgram(shader_id);
}

Shader::~Shader()
{
    glDetachShader(shader_id, shader_fp);
    glDetachShader(shader_id, shader_vp);

    glDeleteShader(shader_fp);
    glDeleteShader(shader_vp);
    glDeleteShader(shader_id);
}

unsigned int Shader::id()
{
    return shader_id;
}

void Shader::bind()
{
    glUseProgram(shader_id);
}

void Shader::unbind()
{
    glUseProgram(0);
}

