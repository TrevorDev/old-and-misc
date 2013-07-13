#include "baseobject.h"
#include <stdio.h>
#include "physics.h"
BaseObject::BaseObject()
{
    //ctor
}

BaseObject::~BaseObject()
{
	for (deque<BaseVector*>::iterator i = this->verts.begin(); i != this->verts.end(); ++i)
        {
            delete (*i);
        }
    for (deque<Plane*>::iterator i = this->planes.begin(); i != this->planes.end(); ++i)
        {
            delete (*i);
        }
}

void BaseObject::move(BaseVector x)
{
    for (deque<BaseVector*>::iterator i = this->verts.begin(); i != this->verts.end(); ++i)
        {
            *(*i) = BaseVector::add(*(*i),x);
        }
}

void BaseObject::rotWithVec(BaseVector oldUp, BaseVector oldForward, BaseVector oldRight, BaseVector up, BaseVector forward, BaseVector right,BaseVector base)
{
    for (deque<BaseVector*>::iterator i = this->verts.begin(); i != this->verts.end(); ++i)
        {
            BaseVector dif = BaseVector::subtract((*(*i)), base);
            (*(*i))=BaseVector::add(base, Physics::newOrientation(oldUp, oldForward, oldRight, up, forward, right, base, dif));
        }
    for (deque<Plane*>::iterator i = this->planes.begin(); i != this->planes.end(); ++i)
        {
            (*i)->calcNormal();
        }
}

void BaseObject::rotAroundPoint(BaseVector pos, BaseVector rot)
{
    for (deque<BaseVector*>::iterator i = this->verts.begin(); i != this->verts.end(); ++i)
        {
            (*(*i))=Physics::rotAroundPoint(pos,(*(*i)),rot);
        }
}

void BaseObject::draw()
{

glBegin(GL_TRIANGLES);

        for (deque<Plane*>::iterator i = this->planes.begin(); i != this->planes.end(); ++i)
        {
            glNormal3f((*i)->normal->x, (*i)->normal->y, (*i)->normal->z);
            glVertex3f((*i)->vertices[0]->x,(*i)->vertices[0]->y,(*i)->vertices[0]->z);
            glVertex3f((*i)->vertices[1]->x,(*i)->vertices[1]->y,(*i)->vertices[1]->z);
            glVertex3f((*i)->vertices[2]->x,(*i)->vertices[2]->y,(*i)->vertices[2]->z);
        }

glEnd();
}
