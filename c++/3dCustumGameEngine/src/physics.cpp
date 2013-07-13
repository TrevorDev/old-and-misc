#include "physics.h"
Physics::Physics()
{
    //ctor
}

Physics::~Physics()
{
    //dtor
}



BaseVector * Physics::hitPoint(BaseVector start, BaseVector end,Plane * plane,int * valid){
    BaseVector * ansPoint = new BaseVector(0,0,0);
    if(start.x==end.x&&start.y==end.y&&start.z==end.z){
        *valid=0;
        return ansPoint;
    }
    BaseVector mix = BaseVector::subtract(start, *(plane->vertices[0]));
    BaseVector xVec = BaseVector::subtract(end, start);
    BaseVector yVec = BaseVector::subtract(*(plane->vertices[1]), *(plane->vertices[0]));
    BaseVector zVec = BaseVector::subtract(*(plane->vertices[2]), *(plane->vertices[0]));
    int val;
    BaseVector xyz = Physics::solveThree(xVec,yVec,zVec, mix,&val);
    if(val){
        if(-xyz.x<0||-xyz.x>1||xyz.y<0||xyz.y>1||xyz.z<0||xyz.z>1||1<xyz.z+xyz.y){
            *valid=0;
            return ansPoint;
        }else{
            *valid=1;
            *ansPoint = BaseVector::add(start, BaseVector::scaleMult(xVec, -xyz.x));
            return ansPoint;
        }
    }else{
        *valid=0;
        return ansPoint;
    }
}



BaseVector * Physics::collidePoint(BaseVector up, BaseVector start, BaseVector end,Plane * plane,int * valid){
    BaseVector * ansPoint = new BaseVector(0,0,0);
    if(start.x==end.x&&start.y==end.y&&start.z==end.z){
        *valid=0;
        return ansPoint;
    }

    BaseVector mix = BaseVector::subtract(start, *(plane->vertices[0]));
    BaseVector xVec = BaseVector::subtract(end, start);
    BaseVector yVec = BaseVector::subtract(*(plane->vertices[1]), *(plane->vertices[0]));
    BaseVector zVec = BaseVector::subtract(*(plane->vertices[2]), *(plane->vertices[0]));
    int val;
    BaseVector xyz = Physics::solveThree(xVec,yVec,zVec, mix,&val);
    if(val){
        if(-xyz.x<0||-xyz.x>1||xyz.y<0||xyz.y>1||xyz.z<0||xyz.z>1||1<xyz.z+xyz.y){
            *valid=0;
            return ansPoint;
        }else{
            *valid=1;


            BaseVector mix2 = BaseVector::subtract(end, *(plane->vertices[0]));
            BaseVector xVec2 = up;
            BaseVector yVec2 = BaseVector::subtract(*(plane->vertices[1]), *(plane->vertices[0]));
            BaseVector zVec2 = BaseVector::subtract(*(plane->vertices[2]), *(plane->vertices[0]));
            BaseVector xyz2 = Physics::solveThree(xVec2,yVec2,zVec2, mix2,&val);

            BaseVector perp = plane->normal;//Physics::cross(yVec,zVec);
            perp = BaseVector::setMag(perp, 1);
            float distP1 = BaseVector::subtract(BaseVector::add((plane->vertices[0]), perp), start).getMag();
            float distP2 = BaseVector::subtract(BaseVector::subtract((plane->vertices[0]), perp), start).getMag();
            if(distP1<distP2){
                perp = BaseVector::setMag(perp, 0.1);
            }else{
                perp = BaseVector::setMag(perp, -0.1);
            }
            *ansPoint=BaseVector::add(BaseVector::add(end, BaseVector::scaleMult(xVec2, -xyz2.x)), BaseVector::scaleMult(xVec2, 0.001));
            return ansPoint;
        }
    }else{
        *valid=0;
        return ansPoint;
    }
}









BaseVector Physics::cross(BaseVector x, BaseVector y, BaseVector z)
{
    BaseVector ret;
    BaseVector a = BaseVector::subtract(x,y);
    BaseVector b = BaseVector::subtract(z,y);
    ret.x=(a.y*b.z)-(a.z*b.y);
    ret.y=(a.z*b.x)-(a.x*b.z);
    ret.z=(a.x*b.y)-(a.y*b.x);
    float mag=sqrt(ret.x*ret.x+ret.y*ret.y+ret.z*ret.z);
    ret.x/=mag;
    ret.y/=mag;
    ret.z/=mag;
    return ret;
}

BaseVector Physics::cross(BaseVector x, BaseVector y)
{
    BaseVector ret;
    BaseVector a = x;
    BaseVector b = y;
    ret.x=(a.y*b.z)-(a.z*b.y);
    ret.y=(a.z*b.x)-(a.x*b.z);
    ret.z=(a.x*b.y)-(a.y*b.x);
    float mag=-ret.getMag();
    ret.x/=mag;
    ret.y/=mag;
    ret.z/=mag;
    return ret;
}

//Moves the forward and right vector perpendicular to the up vector moving the forward vector in the same direction as up was moved compared to oldUp
BaseVector Physics::upAndForward(BaseVector oldUp, BaseVector up, BaseVector * forward, BaseVector * right)
{

    int valid = 0;
    BaseVector ret = solveThree(oldUp,*right,*forward,up,&valid);
    if(ret.x==1)
    {
        return ret;
    }

    //set forward equal to the direction up was going
    BaseVector oldForward = *forward;

    *forward = BaseVector::add(BaseVector::scaleMult(*right, ret.y), BaseVector::scaleMult(*forward, ret.z));
    *forward=BaseVector::setMag(*forward, 1);

    BaseVector yRoter = solveThree(oldForward, * right, *forward,&valid);
//    oldForward.print();
//    right->print();
//    forward->print();
//    printf("here ->  %lf %lf %lf %d\n", yRoter.x, yRoter.y, yRoter.z, valid);
    if(valid==0){
        printf("solveTHreefail\n");
    }
    BaseVector dem = solveThree(oldUp, *forward, up,&valid);
    if(valid==0){
        printf("solveTHreefail\n");
    }
    //move forward distance up moved

    *forward = BaseVector::add(BaseVector::scaleMult(*forward, dem.x), BaseVector::scaleMult(oldUp, -dem.y));
    *forward=BaseVector::setMag(*forward, 1);

    *right=cross(*forward, up);
    *right=BaseVector::setMag(*right,1);


    *forward = BaseVector::add(BaseVector::scaleMult(*forward, yRoter.x), BaseVector::scaleMult(*right, -yRoter.y));

    *right=cross(*forward, up);
    *right=BaseVector::setMag(*right,1);

    return ret;
}

//returns basevector corrisonding to the number of up,forward and right vectors accordingly
BaseVector Physics::solveThree(BaseVector up, BaseVector forward, BaseVector right, BaseVector mix, int * valid)
{
    *valid=1;
    BaseVector ret;
    BaseVector bot;
    BaseVector mid;
    BaseVector top;
    float det = up.x*((forward.y*right.z)-(forward.z*right.y)) - forward.x*((up.y*right.z)-(up.z*right.y)) + right.x*((up.y*forward.z)-(up.z*forward.y));
    if(det==0)
    {
        *valid=0;
        printf("INVALID SOLVETHREE 3 vec CALL DET = 0\n");
        return mix;
    }
    //printf("%lf\n", det);
    top.x=(forward.y*right.z-right.y*forward.z)/det;
    top.y=(forward.x*right.z-right.x*forward.z)/-det;
    top.z=(forward.x*right.y-right.x*forward.y)/det;

    mid.x=(up.y*right.z-right.y*up.z)/-det;
    mid.y=(up.x*right.z-right.x*up.z)/det;
    mid.z=(up.x*right.y-right.x*up.y)/-det;

    bot.x=(up.y*forward.z-forward.y*up.z)/det;
    bot.y=(up.x*forward.z-forward.x*up.z)/-det;
    bot.z=(up.x*forward.y-forward.x*up.y)/det;

    ret.x = BaseVector::mult(top,mix);
    ret.y = BaseVector::mult(mid,mix);
    ret.z = BaseVector::mult(bot,mix);
    return ret;
}

BaseVector Physics::solveThree(BaseVector up, BaseVector forward, BaseVector mix, int * valid)
{
    *valid=1;
    int val;
    BaseVector ret;
    BaseVector top;
    top.z=0;
    BaseVector bot;
    bot.z=0;
    if(up.x==0&&forward.x==0)
    {
        up.x=up.z;
        forward.x=forward.z;
        mix.x=mix.z;
    }
    if(up.y==0&&forward.y==0)
    {
        up.y=up.z;
        forward.y=forward.z;
        mix.y=mix.z;
    }
    float det = up.x*forward.y-forward.x*up.y;
    //printf("det -> %lf\n\n", det);
    if(det<0.00000001&&det>-0.00000001)
    {
            //printf("det = 0\n\n");
            ret.y = solveThree(forward,mix,&val).x;
            *valid=val;
            if(val){

            ret.x=0;
            return ret;
            }

            ret.x = solveThree(up,mix,&val).x;
            *valid=val;
            if(val){
            ret.y=0;

            return ret;
            }

        printf("INVALID SOLVETHREE 2 vec CALL DET = 0\n");
        return mix;
    }
    //printf("det != 0\n\n");
    top.x=forward.y/det;
    top.y=forward.x/-det;
    bot.x=up.y/-det;
    bot.y=up.x/det;
    ret.x = BaseVector::mult(top,mix);
    ret.y = BaseVector::mult(bot,mix);
    return ret;
}

BaseVector Physics::solveThree(BaseVector vec,BaseVector mix, int * valid)
{
    *valid=1;
    if(vec.x!=0&&mix.x!=0)
    {
        mix.x= mix.x/vec.x;
        return mix;
    }
    else if(vec.y!=0&&mix.y!=0)
    {
        mix.x = mix.y/vec.z;
        return mix;
    }
    else if(vec.z!=0&&mix.z!=0)
    {
        mix.x = mix.z/vec.z;
        return mix;
    }
    *valid=0;
    printf("BROKEN SOLVE\n");
    return mix;
}

//changes the base of point from old vecs to new
BaseVector Physics::newOrientation(BaseVector oldUp, BaseVector oldForward, BaseVector oldRight, BaseVector up, BaseVector forward, BaseVector right,BaseVector base, BaseVector point)
{
    BaseVector ret;
    int valid;
    BaseVector mag = solveThree(oldUp, oldForward, oldRight, point, &valid);
    ret = BaseVector::scaleMult(up,mag.x);
    ret = BaseVector::add(ret, BaseVector::scaleMult(forward,mag.y));
    ret = BaseVector::add(ret, BaseVector::scaleMult(right,mag.z));
    return ret;
}























//OLD UNUSED

BaseVector Physics::rotAroundPoint(BaseVector pivot, BaseVector point, BaseVector rot)
{
    BaseVector ret;

    float x,y,z,xzRot=PI/2,zyRot=PI/2,yxRot=PI/2,xzDist,zyDist,yxDist;
    x=point.x;
    y=point.y;
    z=point.z;
    static int k =0;
    k++;
    if(k==8)
    {
        k=0;
    }
    xzDist = sqrtf((pivot.z-z)*(pivot.z-z)+(pivot.x-x)*(pivot.x-x));
    if((x-pivot.x)!=0)
    {
        xzRot = atanf((z-pivot.z)/(x-pivot.x));
    }
    else
    {
        if((z-pivot.z)<0)
        {
            xzRot=-PI/2;
        }
        else
        {
            xzRot=PI/2;
        }
    }
    if((x-pivot.x)>0)
    {
        z = pivot.z+sinf(xzRot-rot.y)*xzDist;
        x = pivot.x+cosf(xzRot-rot.y)*xzDist;
    }
    else
    {
        z = pivot.z-sinf(xzRot-rot.y)*xzDist;
        x = pivot.x-cosf(xzRot-rot.y)*xzDist;
    }
    yxDist = sqrtf((pivot.x-x)*(pivot.x-x)+(pivot.y-y)*(pivot.y-y));
    if((y-pivot.y)!=0)
    {
        yxRot = atanf((x-pivot.x)/(y-pivot.y));
    }
    else
    {
        if((x-pivot.x)<0)
        {
            yxRot=-PI/2;
        }
        else
        {
            yxRot=PI/2;
        }
    }
    if((y-pivot.y)<0)
    {
        x = pivot.x-sinf(yxRot-rot.z)*yxDist;
        y = pivot.y-cosf(yxRot-rot.z)*yxDist;
    }
    else
    {
        x = pivot.x+sinf(yxRot-rot.z)*yxDist;
        y = pivot.y+cosf(yxRot-rot.z)*yxDist;
    }
    zyDist = sqrtf((pivot.y-y)*(pivot.y-y)+(pivot.z-z)*(pivot.z-z));
    if((z-pivot.z)!=0)
    {
        zyRot = atanf((y-pivot.y)/(z-pivot.z));
    }
    else
    {
        if((y-pivot.y)<0)
        {
            zyRot=-PI/2;
        }
        else
        {
            zyRot=PI/2;
        }
    }
    if((z-pivot.z)>0)
    {
        y = pivot.y+sinf(zyRot-rot.x)*zyDist;
        z = pivot.z+cosf(zyRot-rot.x)*zyDist;
    }
    else
    {
        y = pivot.y-sinf(zyRot-rot.x)*zyDist;
        z = pivot.z-cosf(zyRot-rot.x)*zyDist;
    }
    ret.x=x;
    ret.y=y;
    ret.z=z;
    return ret;
}

float Physics::getZYDeg(BaseVector vec)
{
    float ret;
    if(vec.y==0)
    {
        return 0;
    }
    ret=atanf(vec.z/vec.y);
    if(vec.y<0)
    {
        ret=ret;
    }
    return ret;
}

float Physics::getXZDeg(BaseVector vec)
{
    float ret;
    if(vec.y==0)
    {
        return 0;
    }
    ret=atanf(vec.x/vec.y);
    if(vec.y<0)
    {
        ret=ret+(PI);
    }
    return -ret;
}
