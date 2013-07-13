#include "input.h"
int Input::mouseDeltaX = 0;
int Input::mouseDeltaY = 0;
int Input::mouseCurX = 0;
int Input::mouseCurY = 0;
int Input::mouseDeltaScroll = 0;
int Input::mouseCurScroll = 0;
int Input::mouseLeft = 0;

Mouse * Input::mouse=0;

vector<Key*> Input::keys;


Key Input::space;
Key Input::up;
Key Input::down;
Key Input::left;
Key Input::right;
Key Input::one;
Key Input::two;
Key Input::q;
Key Input::enter;
Key Input::shift;
void Input::setUpKeys(){
    space.create("space",' ',&keys);
    up.create("up",'W',&keys);
    down.create("down",'S',&keys);
    left.create("left",'A',&keys);
    right.create("right",'D',&keys);
    one.create("one",'1',&keys);
    two.create("two",'2',&keys);
	q.create("q",'Q',&keys);
	enter.create("enter",294,&keys);
	shift.create("shift",287,&keys);
}

void Input::unloadKeys(){
    
}

void Input::mouseHandler(int x, int y){
mouseDeltaX=x-mouseCurX;
mouseDeltaY=y-mouseCurY;
mouseCurX=x;
mouseCurY=y;
}

void Input::checkMouseMovement(){
	int x=0,y=0;
	static int first = 1;
	if(first){
		glfwGetMousePos(&mouseCurX,&mouseCurY);
		first=0;
	}
	glfwGetMousePos(&x,&y);
	mouseDeltaX=x-mouseCurX;
	mouseDeltaY=y-mouseCurY;
	mouseCurX=x;
	mouseCurY=y;

	if(mouse!=0){
		mouse->x+=mouseDeltaX;
		mouse->y-=mouseDeltaY;
		//printf("%d %d\n",mouse->x,mouse->y);
	}
}

void Input::checkMouseButtons(){
	mouseLeft = glfwGetMouseButton( GLFW_MOUSE_BUTTON_LEFT );
	static bool clickDown = false;
	if(glfwGetMouseButton( GLFW_MOUSE_BUTTON_LEFT )){
		if(!clickDown){
			mouseLeft = true;
			clickDown = true;
		}else{
			mouseLeft=false;
		}
		
	}else{
		clickDown = false;
		mouseLeft = false;
	}
	if(mouseLeft){
		deque<Button *>::iterator it;
		for(it=Button::buttons.begin() ; it < Button::buttons.end(); it++){
			//printf("%d %d %d %d\n",mouse->x, mouse->y,(*it)->x,(*it)->y);
			if(mouse->x>=(*it)->x&&mouse->x<=(*it)->x+(*it)->width&&mouse->y>=(*it)->y&&mouse->y<=(*it)->y+(*it)->length){
				(*it)->clicked=1;
			}
		}

		deque<RenderText *>::iterator rit;
		for(rit=RenderText::selectedInputs.begin() ; rit < RenderText::selectedInputs.end(); rit++){
			//printf("%d %d %d %d\n",mouse->x, mouse->y,(*rit)->x,(*rit)->y);
			if(mouse->x>=(*rit)->x&&mouse->x<=(*rit)->x+(*rit)->dispText.size()*(*rit)->pixelSize&&mouse->y>=(*rit)->y&&mouse->y<=(*rit)->y+(*rit)->pixelSize){
				RenderText * temp = *rit;
				while(RenderText::selectedInputs[0]!=temp){
					RenderText::selectedInputs.push_back(RenderText::selectedInputs[0]);
					RenderText::selectedInputs.pop_front();
					printf("hit\n");
				}
				break;
			}
		}
	}
}

void Input::checkMouseWheel(){
    int scroll = glfwGetMouseWheel();
     mouseDeltaScroll = scroll - mouseCurScroll;
    mouseCurScroll = scroll;
    //printf("%d\n",  mouseDeltaScroll);
}

void Input::keyHandler(int key, int action)
{
    vector<Key*>::iterator it;
    if(action == GLFW_RELEASE){
        for(it=keys.begin() ; it < keys.end(); it++){
            if(key == (*it)->button){
                (*it)->state = 0;
            }
        }
    }else if(action == GLFW_PRESS){
        for(it=keys.begin() ; it < keys.end(); it++){
            if(key == (*it)->button){
                (*it)->state = 1;
            }
        }
		if(RenderText::selectedInputs.size()>0){
			//printf("%d\n\n", key);
			if(key==293 && RenderText::selectedInputs.size()>0){
				RenderText::selectedInputs.push_back(RenderText::selectedInputs[0]);
				RenderText::selectedInputs.pop_front();
			} else if(key==295){
				if(RenderText::selectedInputs[0]->text.length()!=0){
				RenderText::selectedInputs[0]->text = RenderText::selectedInputs[0]->text.substr(0, RenderText::selectedInputs[0]->text.length()-1);
				}
			}else{
				if(key>=32&&key<=126){
					if(key>=65&&key<=90){
						key+=32;
					}
					if(shift.state){
						if(key>=97 && key<= 122){
							key-=32;
						}
					}
					RenderText::selectedInputs[0]->text=RenderText::selectedInputs[0]->text+(char)key;
				}
			}
		}
    }
}
