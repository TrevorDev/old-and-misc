#ifndef KEY_H
#define KEY_H
#include <string>
#include <vector>
using namespace std;
class Key
{
    public:
        int button;
        int state;
        string command;
        Key();
        void create(string command,int button, vector<Key*> * keys);
        virtual ~Key();
    protected:
    private:
};

#endif // KEY_H
