#include "projectile.h"
vector<Projectile*> Projectile::projectiles;

void Projectile::unloadProjectiles(){
    for (vector<Projectile*>::iterator i = projectiles.begin(); i != projectiles.end(); ++i){
        delete (*i);
    }
}

void Projectile::draw(){
    for (vector<Projectile*>::iterator i = projectiles.begin(); i != projectiles.end(); ++i){
        (*i)->projectileModel->draw();
    }
}
void Projectile::move(){
    for (vector<Projectile*>::iterator i = projectiles.begin(); i != projectiles.end(); ++i){





        BaseVector acc;
        acc.setAll(0);
        for (vector<Planet*>::iterator j = Planet::planets.begin(); j != Planet::planets.end(); ++j){
                BaseVector dif;
                dif = BaseVector::subtract((*j)->pos, (*i)->pos);
                float dist = dif.getMag();
                float mag = (*j)->mass/(dist*dist);
                dif=BaseVector::setMag(dif,mag);
                acc = BaseVector::add(acc,dif);
        }
        (*i)->spd = BaseVector::add((*i)->spd, BaseVector::scaleMult(acc, Global::deltaTime));
        BaseVector change = BaseVector::scaleMult((*i)->spd, Global::deltaTime);
        BaseVector end = BaseVector::add((*i)->pos, change);



         int valid=0;
        for (vector<Planet*>::iterator k = Planet::planets.begin(); k != Planet::planets.end(); ++k)
        {
            for (deque<Plane*>::iterator l = (*k)->planetModel->planes.begin(); l != (*k)->planetModel->planes.end(); ++l)
            {
                BaseVector * hit = Physics::hitPoint((*i)->pos,end,(*l),&valid);
                delete hit;
                if(valid==1)
                {
                    break;
                }
                //delete collision;
            }
            if(valid==1)
            {
                break;
            }
        }
        if(valid){
            (*i)->spd = BaseVector::scaleMult((*i)->spd,-0.5);
        }else{
            (*i)->pos=end;
            (*i)->projectileModel->move(change);
        }
    }
}

Projectile::Projectile(BaseVector pos, BaseVector spd)
{
    this->projectileModel = ShapeGen::genSphere(pos,0.1, 10, 10);
    this->pos=pos;
    this->spd=spd;
    projectiles.push_back(this);
}

Projectile::~Projectile()
{
    delete projectileModel;
}
