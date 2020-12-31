class Button {
  int x, y;
  int w, h;
  int mouse_action_mask;
  boolean over = false;
  boolean pressed = false;
  int tId,am;
  
  Button(int x,int y, int w,int h){
    this.x=x;this.y=y;this.w=w;this.h=h;
    
  }
  
  void display(){
    rect(this.x-this.w/2,this.y-this.h/2,this.w,this.h);
    text(this.tId,0,this.y);
  }
/*
  am-actionMask
  ACTION_DOWN=0
  ACTION_UP=1
  ACTION_POINTER_DOWN=5
  ACTION_POINTER_UP=6
*/
  void action_down(){
    this.w*=.75;
    this.h*=.75;
    this.pressed = true;
  }
  void action_up(){
    this.w*=1.33333;
    this.h*=1.33333;
    this.pressed = false;

  }
  void pressed(float x,float y,int am,int id,int count) {
   
    if (overRect(x,y)) {
      this.tId=id;
      press(am,id,count); 
    } else {
      if( overRect(x,y)==false && this.pressed && this.tId==id ){
        action_up();   
      }
    }
  }
  void press(int am,int id,int count){
    this.mouse_action_mask=am;
    if ((am==5 || am==0) && this.pressed==false){
      action_down();
      this.am=am;
    }
    else if ( this.pressed && this.tId==id){
      if (am-this.am==1){
        action_up();
        }
      
    }
  }
  boolean overRect (float x, float y) {
    if (this.x-this.w/2<x && this.x+this.w/2>x && this.y-this.h/2<y && this.y+this.h/2>y) {
      return true;
    } else {
      return false;
    }
  }
}

