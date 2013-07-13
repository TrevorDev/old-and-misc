#include "shapegen.h"
BaseObject* ShapeGen::genRectangularPrism(BaseVector pos,BaseVector len)
{
    len.x=len.x/2;
    len.y=len.y/2;
    len.z=len.z/2;
    BaseObject * bObject=new BaseObject();
    /*BaseVector* verts[8];
    verts[0]=new BaseVector(pos.x-len.x,pos.y-len.y,pos.z-len.z);
    verts[1]=new BaseVector(pos.x+len.x,pos.y-len.y,pos.z-len.z);
    verts[2]=new BaseVector(pos.x-len.x,pos.y+len.y,pos.z-len.z);
    verts[3]=new BaseVector(pos.x-len.x,pos.y-len.y,pos.z+len.z);
    verts[4]=new BaseVector(pos.x+len.x,pos.y+len.y,pos.z-len.z);
    verts[5]=new BaseVector(pos.x+len.x,pos.y-len.y,pos.z+len.z);
    verts[6]=new BaseVector(pos.x-len.x,pos.y+len.y,pos.z+len.z);
    verts[7]=new BaseVector(pos.x+len.x,pos.y+len.y,pos.z+len.z);
    */
    bObject->verts.push_back(new BaseVector(pos.x-len.x,pos.y-len.y,pos.z-len.z));
    bObject->verts.push_back(new BaseVector(pos.x+len.x,pos.y-len.y,pos.z-len.z));
    bObject->verts.push_back(new BaseVector(pos.x-len.x,pos.y+len.y,pos.z-len.z));
    bObject->verts.push_back(new BaseVector(pos.x-len.x,pos.y-len.y,pos.z+len.z));
    bObject->verts.push_back(new BaseVector(pos.x+len.x,pos.y+len.y,pos.z-len.z));
    bObject->verts.push_back(new BaseVector(pos.x+len.x,pos.y-len.y,pos.z+len.z));
    bObject->verts.push_back(new BaseVector(pos.x-len.x,pos.y+len.y,pos.z+len.z));
    bObject->verts.push_back(new BaseVector(pos.x+len.x,pos.y+len.y,pos.z+len.z));
    bObject->planes.push_front(new Plane(bObject->verts[2],bObject->verts[0],bObject->verts[1]));
    bObject->planes.push_front(new Plane(bObject->verts[1],bObject->verts[4],bObject->verts[2]));
    bObject->planes.push_front(new Plane(bObject->verts[6],bObject->verts[7],bObject->verts[5]));
    bObject->planes.push_front(new Plane(bObject->verts[5],bObject->verts[3],bObject->verts[6]));
    bObject->planes.push_front(new Plane(bObject->verts[1],bObject->verts[0],bObject->verts[3]));
    bObject->planes.push_front(new Plane(bObject->verts[3],bObject->verts[5],bObject->verts[1]));
    bObject->planes.push_front(new Plane(bObject->verts[4],bObject->verts[1],bObject->verts[5]));
    bObject->planes.push_front(new Plane(bObject->verts[5],bObject->verts[7],bObject->verts[4]));
    bObject->planes.push_front(new Plane(bObject->verts[6],bObject->verts[2],bObject->verts[4]));
    bObject->planes.push_front(new Plane(bObject->verts[4],bObject->verts[7],bObject->verts[6]));
    bObject->planes.push_front(new Plane(bObject->verts[6],bObject->verts[3],bObject->verts[0]));
    bObject->planes.push_front(new Plane(bObject->verts[0],bObject->verts[2],bObject->verts[6]));
    return bObject;
}
BaseObject* ShapeGen::genSphere(BaseVector pos,float radius, int segments, int rings)
{
    BaseObject * bObject=new BaseObject();
    BaseVector point;
    BaseVector rot;
    float yRotChange = PI/rings;
    float xRotChange = 2*PI/segments;
    rot.x=0;
    rot.y=-PI/2;
    point.x=pos.x+sin(rot.x)*cos(rot.y)*radius;
    point.y=pos.y+sin(rot.y)*radius;
    point.z=pos.z+cos(rot.x)*cos(rot.y)*radius;
    bObject->verts.push_front(new BaseVector(point.x,point.y,point.z));
    for(int i = 1;i<rings;i++){
        //printf("HIT\n");
        rot.y+=yRotChange;
        for(int j = 0;j<segments;j++){
            static int f =0;
            f++;
            //printf("%d  %d\n",f, segments);
            point.x=pos.x+sin(rot.x)*cos(rot.y)*radius;
            point.y=pos.y+sin(rot.y)*radius;
            point.z=pos.z+cos(rot.x)*cos(rot.y)*radius;
            bObject->verts.push_front(new BaseVector(point.x,point.y,point.z));
            rot.x+=xRotChange;
        }
    }
    rot.y=PI/2;
    point.x=pos.x+sin(rot.x)*cos(rot.y)*radius;
    point.y=pos.y+sin(rot.y)*radius;
    point.z=pos.z+cos(rot.x)*cos(rot.y)*radius;
    bObject->verts.push_front(new BaseVector(point.x,point.y,point.z));
    for(int i = 1;i<bObject->verts.size()-1;i++){
        int p=0;
        if(i<segments+1){
            if(i%segments==0){
                p=i+1-segments;
            }else{
                p=i+1;
            }
            bObject->planes.push_front(new Plane(bObject->verts[0],bObject->verts[i],bObject->verts[p]));
            bObject->planes.push_front(new Plane(bObject->verts[i+segments],bObject->verts[p],bObject->verts[i]));
            bObject->planes.push_front(new Plane(bObject->verts[i+segments],bObject->verts[p+segments],bObject->verts[p]));
        }else if(i>(bObject->verts.size()-segments-2)){
            if(i%segments==0){
                p=i+1-segments;
            }else{
                p=i+1;
            }
            bObject->planes.push_front(new Plane(bObject->verts[bObject->verts.size()-1],bObject->verts[p],bObject->verts[i]));

        }else{
             if(i%segments==0){
                p=i+1-segments;
            }else{
                p=i+1;
            }
            bObject->planes.push_front(new Plane(bObject->verts[i+segments],bObject->verts[p],bObject->verts[i]));

            bObject->planes.push_front(new Plane(bObject->verts[i+segments],bObject->verts[p+segments],bObject->verts[p]));
        }

    }
    return bObject;
}

