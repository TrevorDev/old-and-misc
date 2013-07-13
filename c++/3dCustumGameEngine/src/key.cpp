#include "key.h"

Key::Key()
{

}

void Key::create(string command,int button, vector<Key*> * keys)
{
    this->command=command;
    this->button=button;
    this->state=0;
    keys->push_back(this);
}

Key::~Key()
{
    //dtor
}

