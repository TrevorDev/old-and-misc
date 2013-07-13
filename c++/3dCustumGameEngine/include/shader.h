#ifndef SHADER_H_
#define SHADER_H_
#define GLEW_STATIC
#include <GL/glew.h>
#include <GL/glfw.h>
#include <string>

class Shader {

    public:
        Shader();
        Shader(const char *vsFile, const char *fsFile);
        ~Shader();
        void init(const char *vsFile, const char *fsFile);
        void bind();
        void unbind();
        unsigned int id();

    private:
        unsigned int shader_id;
        unsigned int shader_vp;
        unsigned int shader_fp;
};

#endif // SHADER_H_

