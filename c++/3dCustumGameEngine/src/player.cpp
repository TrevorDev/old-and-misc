#include "player.h"
Player * Player::player;
Player::Player(BaseVector pos)
{
    player = this;
    BaseVector len;
    len.x=1;
    len.y=2;
    len.z=1;
    grounded=0;
    this->collidePoint=pos;
    pos.y+=len.y/2;
    this->body=ShapeGen::genRectangularPrism(pos,len);
    this->spd.setAll(0);
    this->acc.setAll(0);
    turnRot = 0;
    this->up.setAll(0);
    this->right.setAll(0);
    this->forward.setAll(0);
    this->forward.z+=1;
    this->up.y+=1;
    this->right.x+=1;

}

//Rotate guy facing forward of camera
void Player::faceCam()
{
     int valid;

            BaseVector rot=Physics::solveThree(this->up, this->forward, this->right, BaseVector::subtract(Camera::pos,Camera::look),&valid);
            this->forward=BaseVector::setMag(BaseVector::add(BaseVector::scaleMult(this->forward, rot.y), BaseVector::scaleMult(this->right, rot.z)),-1);
            this->forward = BaseVector::setMag(this->forward, 1);
            this->right=Physics::cross(this->forward, this->up);
            Camera::rot.x=0;
}

void Player::receiveInput()
{
    switch ( Camera::mode )
    {
    case 2:
    {
        static int hit =1;
        if(Input::space.state)
        {
            if(hit)
            {
                this->spd=BaseVector::add(this->spd, BaseVector::scaleMult(this->up,50));
                this->acc.setAll(0);
                hit=0;
            }
        }
        else
        {
            hit=1;
        }
        int valid;
        BaseVector moveAcc;
        moveAcc.setAll(0);
        if(Input::up.state)
        {
            this->faceCam();

            moveAcc=BaseVector::add(moveAcc, BaseVector::scaleMult(this->forward,Global::deltaTime*20));
        }

        if(Input::down.state)
        {
            this->faceCam();

            moveAcc=BaseVector::add(moveAcc, BaseVector::scaleMult(this->forward,Global::deltaTime*-20));
        }

        if(Input::left.state)
        {
            this->faceCam();

            moveAcc=BaseVector::add(moveAcc, BaseVector::scaleMult(this->right,Global::deltaTime*-20));
        }

        if(Input::right.state)
        {
            this->faceCam();

            moveAcc=BaseVector::add(moveAcc, BaseVector::scaleMult(this->right,Global::deltaTime*20));
        }

        if(moveAcc.getMag()!=0){
            moveAcc = BaseVector::setMag(moveAcc, 1);

            this->spd = BaseVector::add(this->spd, moveAcc);
            if(grounded){
            BaseVector crossed = Physics::cross(moveAcc, this->up);
            BaseVector makeUp = Physics::solveThree(crossed, this->up, moveAcc, this->spd, &valid);
            this->spd = BaseVector::add(BaseVector::add(BaseVector::scaleMult(crossed, makeUp.x*0.5), BaseVector::scaleMult(this->up, makeUp.y*0.5)), BaseVector::scaleMult(moveAcc, makeUp.z));
            }
        }else{
            if(grounded){
            this->spd = BaseVector::scaleMult(this->spd, 0.5);
            }
        }

        static int hit2 =1;
        if(Input::mouseLeft)
        {
            if(hit2)
            {
                new Projectile(BaseVector::add(this->collidePoint, BaseVector::scaleMult(this->up,2)),BaseVector::add(BaseVector::scaleMult(this->forward,15), BaseVector::scaleMult(this->up,20)));
                hit2=0;
            }
        }
        else
        {
            hit2=1;
        }


//            Camera::look=this->collidePoint;
//            Camera::pos=BaseVector::add(this->collidePoint,BaseVector::setMag(this->forward,-100));
//            Camera::up=this->up;
    }
    }

    /*switch ( Camera::cam->mode ) {
        case 2:{
            float acc=acceleration*Global::deltaTime;
            if(Input::up.state){
                xSpd-=sin(Camera::cam->xRot)*acc;
                zSpd-=cos(Camera::cam->xRot)*acc;
            }
            if(Input::down.state){
                xSpd+=sin(Camera::cam->xRot)*acc;
                zSpd+=cos(Camera::cam->xRot)*acc;
            }
            if(Input::left.state){
                xSpd+=sin(Camera::cam->xRot+(PI/2))*acc;
                zSpd+=cos(Camera::cam->xRot+(PI/2))*acc;
            }
            if(Input::right.state){
                xSpd-=sin(Camera::cam->xRot+(PI/2))*acc;
                zSpd-=cos(Camera::cam->xRot+(PI/2))*acc;
            }
            float spd = sqrt(xSpd*xSpd+zSpd*zSpd);
            if(spd>maxSpd){
                float triRatio = maxSpd/spd;
                xSpd*=triRatio;
                zSpd*=triRatio;
            }

            static int space =1;
            if(Input::keys.space){
                if(space){
                    ySpd=10;
                    space=0;
                }
            }else{
            space=1;
            }

            break;
        }
    }*/
}

void Player::enterFrame()
{
    //collision
    this->spd=BaseVector::add(this->spd, BaseVector::scaleMult(this->acc, Global::deltaTime));
    BaseVector nextPoint = BaseVector::add(this->collidePoint,BaseVector::scaleMult(this->spd, Global::deltaTime));
    BaseVector * collision;
    Plane* colPlane;
    int valid=0;
    for (vector<Planet*>::iterator i = Planet::planets.begin(); i != Planet::planets.end(); ++i)
    {
        for (deque<Plane*>::iterator j = (*i)->planetModel->planes.begin(); j != (*i)->planetModel->planes.end(); ++j)
        {
            collision = Physics::collidePoint(this->up, this->collidePoint, nextPoint,(*j),&valid);
            if(valid==1)
            {
                colPlane=(*j);
                break;
            }
            delete collision;
        }
        if(valid==1)
        {
            break;
        }
    }

    if(valid==1)
    {
        grounded=1;
        this->body->move(BaseVector::subtract(*collision, this->collidePoint));
        this->collidePoint= *collision;
        int valid;
        BaseVector solve = Physics::solveThree(this->up,this->forward,this->right,this->spd,&valid);
        this->spd=BaseVector::add(BaseVector::scaleMult(this->forward,solve.y), BaseVector::scaleMult(this->right,solve.z));
        //this->spd = BaseVector::scaleMult(this->spd, 0.5);
        this->spd = BaseVector::add(this->spd, BaseVector::scaleMult(this->up,-2));
        delete collision;
    }
    else
    {
        grounded=0;
        this->collidePoint= nextPoint;
        this->body->move(BaseVector::scaleMult(this->spd, Global::deltaTime));
    }
    //printf("%d\n", grounded);
    //Changing up to gravity up
    this->acc.setAll(0);
    for (vector<Planet*>::iterator i = Planet::planets.begin(); i != Planet::planets.end(); ++i)
    {
        BaseVector dif = (*i)->pos;
        dif = BaseVector::subtract(dif, this->collidePoint);
        float dist = dif.getMag();
        float mag = (*i)->mass/(dist*dist);
        dif=BaseVector::setMag(dif,mag);
        this->acc = BaseVector::add(this->acc,dif);
    }
    BaseVector oldUp = this->up;
    BaseVector oldForward = this->forward;
    BaseVector oldRight = this->right;
    this->up=this->acc;
    this->up=BaseVector::setMag(this->up,-1);
    //get upadated orentation
    rot = Physics::upAndForward(oldUp,this->up,&(this->forward),&(this->right));
    this->receiveInput();
    //rotates body to match orentation
    this->body->rotWithVec(oldUp,oldForward,oldRight,up,forward,right,this->collidePoint);
}

Player::~Player()
{
    delete this->body;
}
