//Basic GLFW testing code
//You should see a red spinning triangle when you compile and run this

#define GLEW_STATIC
#include "shader.h"
#include <stdio.h>
#include <stdlib.h>
#include <GL/glew.h>
#include <GL/glfw.h>

#include "buffertool.h"
#include "baseobject.h"
#include "global.h"
#include "input.h"
#include "camera.h"
#include "shapegen.h"
#include "commandhandler.h"
#include "tcpclient.h"
#include "player.h"
#include "plane.h"
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <boost/asio.hpp>
#include <boost/thread.hpp>
#include <ft2build.h>
#include FT_FREETYPE_H
#include "freetype.h"
#include "rendertext.h"
#include "tga.h"
#include "mouse.h"
#include "image.h"
#include "button.h"

#include "loginresponse.h"

using boost::asio::ip::udp;
using boost::asio::ip::tcp;
#define USED_FONT "Lato-Bol.ttf"
#include <vld.h> 
enum { max_length = BUFFER_SIZE };


void killit(int return_code);
void Init(void);
void InitGameplay(void);
void unloadGamePlay(void);
void Main_Loop(void);
void MenuLoop(void);
void Draw(void);
Player * player;
Shader * shader;



void ioConnection(boost::asio::io_service * io_service){
	io_service->run();
}

int main()
{
	try {
	boost::system::error_code ec;
	boost::asio::io_service io_service;

	//setup udp
	udp::socket us(io_service, udp::endpoint(udp::v4(), 0));
	udp::resolver uresolver(io_service);
	udp::resolver::query uquery(udp::v4(), "127.0.0.1", "13");
	udp::resolver::iterator uiterator = uresolver.resolve(uquery);

	//setup tcp
	tcp::resolver tresolver(io_service);
	tcp::resolver::query tquery(tcp::v4(), "127.0.0.1", "14");
	tcp::resolver::iterator iter = tresolver.resolve(tquery);
	tcp::resolver::iterator end;

	tcp::socket ts(io_service);
	ts.connect(*iter);
	CommandHandler::init(&ts,&us);
	tcpClient::pointer cl = tcpClient::create(&ts);
	cl->start();

	boost::thread ioThread(boost::bind(ioConnection, &io_service));
	



	//	char request[max_length];
	//	char userName[max_length];
	//	char password[max_length];
	//	bool loginComplete = false;
	//	while(!loginComplete){
	//		std::cout << "Welcome to TinyStomp\n1. login\n2. create account\n";
	//		std::cin.getline(request, max_length);

	//		if(request[0]!='2'&&request[0]!='q'){
	//			MutexState::loggingIn.try_lock();
	//			MutexState::loggedIn=0;
	//			std::cout << "Enter username\n";
	//			std::cin.getline(userName, max_length);
	//			std::cout << "Enter password\n";
	//			std::cin.getline(password, max_length);
	//			std::cout << "Please Wait...\n";
	//			CommandHandler::login(userName, password);
	//			MutexState::loggingIn.try_lock_for(boost::chrono::microseconds(5000000));
	//			if(MutexState::loggedIn==1){
	//			loginComplete = true;
	//			printf("logged in\n");
	//			}else{
	//			loginComplete = false;
	//			printf("login failed\n");
	//			}
	//		}else if(request[0]=='2'){
	//			MutexState::creatingAcc.try_lock();
	//			MutexState::accCreated=0;
	//			std::cout << "Enter username";
	//			std::cin.getline(userName, max_length);
	//			std::cout << "Enter password";
	//			std::cin.getline(password, max_length);
	//			std::cout << "Please Wait...\n";
	//			CommandHandler::createAccount(userName, password);
	//			MutexState::creatingAcc.try_lock_for(boost::chrono::microseconds(5000000));
	//			if(MutexState::accCreated==1){
	//				printf("accCreated in\n");
	//			}else{
	//				printf("accCreated failed\n");
	//			}
	//		}else if(request[0]=='q'){
	//			io_service.stop();
	//			Init();
	//			killit(0);
	//			return 0;
	//		}
	//	}


	
    Init();
	MenuLoop();
	InitGameplay();
    Main_Loop();
	unloadGamePlay();
	io_service.stop();
    killit(0);
	}
	catch (std::exception& e) {
		std::cerr << "Exception: " << e.what() << "\n";
	}
    return 0;
}

void Init()
{
	//openGl init
    if (glfwInit() != GL_TRUE){
        printf("glfw error");
        killit(1);
    }
	const int window_width = 1600, window_height = 900;
    if (glfwOpenWindow(window_width, window_height, 8, 8, 8, 0, 0, 0, GLFW_WINDOW) != GL_TRUE){
        printf("cannot create window error");
        killit(1);
    }
    if(glewInit()!=GLEW_OK){
        printf("glew error");
        killit(1);
    }
	 glfwSwapInterval(1);
    
    glfwSetWindowTitle("The GLFW Window");

    // set the projection matrix to a normal frustum with a max depth of 50
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    float aspect_ratio = ((float)window_height) / window_width;
    glFrustum(.5, -.5, -.5 * aspect_ratio, .5 * aspect_ratio, 1, 10000);

	
	//render setup
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    glEnable (GL_TEXTURE_2D);
    glEnable(GL_COLOR_MATERIAL);
	glShadeModel (GL_SMOOTH);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);

	//set the backround color
    glClearColor (0.4f, 0.4f, 0.4f, 0.0f);

	//init input
	Input::setUpKeys();
    glfwDisable (GLFW_MOUSE_CURSOR);
    glfwSetKeyCallback(Input::keyHandler);

	RenderText::init();
	
    shader= new Shader("test_vs.glsl", "test_fs.glsl");
}

void InitGameplay()
{
	//gameStart init
    BaseVector bv;
    bv.x=0;
    bv.y=-10;
    bv.z=0;
    Planet * x1 = new Planet(bv, 1000000,100, 20, 20);
    bv.x=300;
    bv.y=300;
    bv.z=300;
    Planet * x2 =new Planet(bv, 1000000,100, 20, 20);
    bv.x=-300;
    bv.y=-300;
    bv.z=-300;
    Planet * x3 =new Planet(bv, 1000000,100, 20, 20);
    bv.y=-10;
    bv.x=125;
    bv.z=0;

	player=new Player(bv);
	Camera::init();
    shader->bind();
}


void MenuLoop(void)
{
	RenderText * userStatic = new RenderText(USED_FONT, "UserName:", 30, 5, 20,0);
	RenderText * passStatic = new RenderText(USED_FONT, "Password:", 30, 5, 10,0);
	RenderText * userName = new RenderText(USED_FONT, "", 30, 30, 20,1);
	RenderText * pass = new RenderText(USED_FONT, "", 30, 30, 10,1);
	RenderText * status = new RenderText(USED_FONT, "Status:", 30, 5, 0,0);
	int stageWidth, stageHeight;
	glfwGetWindowSize(&stageWidth, &stageHeight);

	Button okButton("ok.tga",70,100,80,10);
	Button createAccButton("ok.tga",70,100,80,10);
	Mouse m("mouse.tga",40,40,stageWidth/2,stageHeight/2);
	
	Image i("backround.tga",stageHeight,stageWidth,0,0);

	Input::mouse=&m;
	LoginResponse * waitRequest=new LoginResponse(5.0f);
    // this just loops as long as the program runs
    while(!waitRequest->success||!waitRequest->complete)
    {
        Input::checkMouseMovement();
        Input::checkMouseWheel();
        Input::checkMouseButtons();
		if(Input::enter.state){
			okButton.clicked=1;
		}
		if(okButton.clicked){
			if(!waitRequest->waitingForReply){
				//fix all this
				waitRequest->sendReq(userName->text, pass->text);
				status->text="Please Wait ...";
			}
			okButton.clicked=0;
		}
		if(waitRequest->waitingForReply){
			if(waitRequest->complete==true&&waitRequest->success==false){
				ServerResponse::removeResp(waitRequest);
				waitRequest->waitingForReply=false;
				status->text="Username or Password is incorrect";
			}

			if(waitRequest->checkTimeOut()){
				status->text="Server request timed out close program and try again later";
			}
		}
		
		//run at a constant fps
        Global::frameRun();

        // clear the buffer
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		
		m.draw();
		okButton.draw();
		status->draw();
		userStatic->draw();
		passStatic->draw();
		userName->draw();
		pass->draw();
		i.draw();
		

        // swap back and front buffers limits fps by refresh rate
        glfwSwapBuffers();
    }
	ServerResponse::removeAndDeleteResp(waitRequest);
	delete userStatic;
	delete passStatic;
	delete userName;
	delete pass;
	delete status;
}


void Main_Loop(void)
{
	RenderText * textShown = new RenderText(USED_FONT, "HudText", 90, 5, 5, 0);
	bool run = true;
    // this just loops as long as the program runs
    while(run)
    {
        Input::checkMouseMovement();
        Input::checkMouseWheel();
        Input::checkMouseButtons();
		if(Input::q.state){
			run=false;
		}

		//run at a constant fps
        Global::frameRun();

        // clear the buffer
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        // draw the figure
        player->enterFrame();
        Camera::enterFrame();
		Projectile::move();
        Draw();

		//display text
		shader->unbind();
		glLoadIdentity();
		textShown->draw();
		shader->bind();

        // swap back and front buffers limits fps by refresh rate
        glfwSwapBuffers();

    }
	delete textShown;
}

void Draw(void)
{
    GLfloat blueSpecularMaterial[] = {0.03f, 0.07f, 0.15f};
    GLfloat whiteSpecularMaterial[] = {0.5f, 0.5f, 0.5f};
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,blueSpecularMaterial);
    for (vector<Planet*>::iterator i = Planet::planets.begin(); i != Planet::planets.end(); ++i){
        (*i)->planetModel->draw();
    }
    Projectile::draw();
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,whiteSpecularMaterial);
    player->body->draw();
}


void unloadGamePlay()
{
	Planet::unloadPlanets();
	Projectile::unloadProjectiles();
	delete player;
	delete shader;
}
void killit(int return_code)
{
	Input::unloadKeys();
	shader->unbind();
	glfwTerminate();
	//exit(return_code);
}







