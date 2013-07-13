#include "camera.h"
int Camera::mode = 2;
float Camera::rotSpd=0.1;
float Camera::moveSpd=50;\
BaseVector Camera::pos;
BaseVector Camera::rot;
BaseVector Camera::look;
BaseVector Camera::up;
void Camera::receiveInput(){
    switch ( mode ) {
        case 1:{
            float spd=moveSpd*Global::deltaTime;
            if(Input::up.state){
                pos.x+=(look.x-pos.x)*spd;
                pos.y+=(look.y-pos.y)*spd;
                pos.z+=(look.z-pos.z)*spd;
            }
            if(Input::down.state){
                pos.x-=(look.x-pos.x)*spd;
                pos.y-=(look.y-pos.y)*spd;
                pos.z-=(look.z-pos.z)*spd;
            }
            if(Input::left.state){
                pos.x-=sin(rot.x+(PI/2))*spd;
                pos.z-=cos(rot.x+(PI/2))*spd;
            }
            if(Input::right.state){
                pos.x+=sin(rot.x+(PI/2))*spd;
                pos.z+=cos(rot.x+(PI/2))*spd;
            }

            float yRotChange = Input::mouseDeltaY*(PI/180)*rotSpd;
            if(rot.y-yRotChange>-PI/2&&rot.y-yRotChange<PI/2){
                rot.y-=yRotChange;
            }
            rot.x+=Input::mouseDeltaX*(PI/180)*rotSpd;
            //rot.y-=Input::mouseDeltaY*(PI/180)*rotSpd;
            look.x=pos.x+sin(rot.x)*cos(rot.y);
            look.y=pos.y+sin(rot.y);
            look.z=pos.z+cos(rot.x)*cos(rot.y);
        }
        case 2:{
            float yRotChange = Input::mouseDeltaY*(PI/180)*rotSpd;
            if(rot.y-yRotChange>-PI/2&&rot.y-yRotChange<PI/2){
                rot.y-=yRotChange;
            }
            rot.x+=Input::mouseDeltaX*(PI/180)*rotSpd;

            look.x=Player::player->collidePoint.x;
            look.y=Player::player->collidePoint.y;//-sin(rot.y);
            look.z=Player::player->collidePoint.z;
            pos=look;
            pos = BaseVector::subtract(pos, BaseVector::scaleMult(Player::player->right, sin(rot.x)*cos(rot.y)*20));
            pos = BaseVector::subtract(pos, BaseVector::scaleMult(Player::player->forward, cos(rot.x)*cos(rot.y)*20));
            pos = BaseVector::subtract(pos, BaseVector::scaleMult(Player::player->up, sin(rot.y)*20));
            up=Player::player->up;
        }

    }
}
void Camera::init(){
    pos.x=1;
    pos.y=1;
    pos.z=1;
    up.x=0;
    up.y=1;
    up.z=0;
    rot.setAll(0);
}
void Camera::enterFrame(){
    receiveInput();

    //cout << pos.x <<"\n";
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(pos.x, pos.y, pos.z, look.x, look.y,look.z, up.x, up.y, up.z);

            GLfloat lightColor0[] = {0,0,0, 1}; //Color (0.5, 0.5, 0.5)
            BaseVector posit = BaseVector::add(pos, BaseVector::setMag(Player::player->up,5));
            GLfloat lightPos0[] = {posit.x,posit.y,posit.z, 1.0f}; //Positioned at (4, 0, 8)
            GLfloat lightPoss0[] = {look.x-pos.x, look.y-pos.y, look.z-pos.z};
            GLfloat light_diffuse[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
            GLfloat light_specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };

            glLightfv(GL_LIGHT0, GL_AMBIENT, lightColor0);
            glLightfv(GL_LIGHT0, GL_DIFFUSE,  light_diffuse);
            glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
            glLightfv(GL_LIGHT0, GL_POSITION, lightPos0);
            glLightfv(GL_LIGHT0, GL_SPOT_DIRECTION, lightPoss0);

            glLightf(GL_LIGHT0, GL_SPOT_EXPONENT, 30);
            glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, 60);

}
