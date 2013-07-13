#ifndef ACCOUNT_H
#define ACCOUNT_H
#include <string>
using namespace std;
class Account
{
    public:
		int cash;
		string username;
		string password;

		Account(string un, string pw, int c);
        virtual ~Account();
    protected:
    private:
};

#endif // ACCOUNT_H
