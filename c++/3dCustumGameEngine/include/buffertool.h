#ifndef BUFFERTOOL_H
#define BUFFERTOOL_H
#include <boost/array.hpp>
#include <string>
#define BUFFER_SIZE 1024
class BufferTool
{
	public:
		BufferTool(boost::array<char,BUFFER_SIZE> buffer);
		BufferTool();
		boost::array<char,BUFFER_SIZE> getBuffer();
		int getPos();
		char getCmd();
		void addCmd(char x);
		unsigned int getUInt();
		void addUInt(unsigned int x);
		int getInt();
		void addInt(int x);
		std::string getString();
		bool outsideBuffer();
		bool outsideBuffer(int x);
		void addString(std::string x);
		int pos;
		bool invalid;
		boost::array<char,BUFFER_SIZE> buffer;
	protected:
	private:
};

#endif // BUFFERTOOL_H
using namespace std;