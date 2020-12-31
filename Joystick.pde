class Joystick {
  float r[],x[],y[];
  int mouse_action_mask;
  boolean over = false;
  boolean pressed = false;
  int tId,am;
  //float bg_color[];
  //bg_color=new float[4];
  color bg_color=color(0,255,0,55);
  color pad_color=color(0,200,200,255);
  
  
  Joystick(int x,int y, int r,int r1){
    this.r=new float[2];
    this.x=new float[2];
    this.y=new float[2];
    for(int i=0;i<2;i++){this.x[i]=x;this.y[i]=y;}
    this.r[0]=r;
    this.r[1]=r1;
    
  }
  
  void display(){
    //rect(this.x-this.w/2,this.y-this.h/2,this.w,this.h);
    fill(bg_color);
    ellipse(this.x[0],this.y[0],this.r[0],this.r[0]);
    fill(pad_color);
    ellipse(this.x[1],this.y[1],this.r[1],this.r[1]);
    text(this.tId,0,this.y[0]);
  }
  
  
  
/*
  am-actionMask
  ACTION_DOWN=0
  ACTION_UP=1
  ACTION_POINTER_DOWN=5
  ACTION_POINTER_UP=6
*/
 
  void setPos(float x,float y){
    float xx=this.x[1]-this.x[0],yy=this.y[1]-this.y[0];
    this.x[0]=x;
    this.y[0]=y;
    this.x[1]=x+xx;
    this.y[1]=y+yy;
  }
  void action_down(){
    this.pressed = true;
  }
  void action_up(){
    this.pressed = false;
    this.x[1]=this.x[0];
    this.y[1]=this.y[0];

  }
  void pressed(float x,float y,int am,int id,int count) {
    if (overEllipse(x,y,1)) {
      press(am,id,count,x,y); 
    }
    else if( overEllipse(x,y,1)==false && this.pressed && this.tId==id && (am==1 || am==6 )){
      action_up();   
    }
    else if(this.pressed && this.tId==id){
      press(am,id,count,x,y);
    }
  }
  void press(int am,int id,int count,float x, float y){
    this.mouse_action_mask=am;
    if (am==2 || am==0){
      if (this.pressed==false){
        this.tId=id;
        action_down();
      }
      else{
        if (this.tId==id){
          action_move(x,y);
        }
      }
    }
    else if ( this.pressed && this.tId==id){
      if (am-this.am==1){
        action_up();
      }
    }
  }
  void action_move(float x,float y){
    float c=sqrt(sqr(x-this.x[0])+sqr(y-this.y[0]));
    if (c>(this.r[0]-this.r[1])/2){
      x=this.x[0]+((x-this.x[0])/(c/(this.r[0]-this.r[1])))/2;
      y=this.y[0]+((y-this.y[0])/(c/(this.r[0]-this.r[1])))/2;
    }
    this.x[1]=x;
    this.y[1]=y;
   
  }
  float getXd(){
    return (this.x[1]-this.x[0])/this.r[0];
  }
  float getYd(){
    return (this.y[1]-this.y[0])/this.r[0];
  }
  boolean overEllipse (float x, float y, int n) {
    if (sqrt(sqr(this.x[n]-x)+sqr(this.y[n]-y))< this.r[n]/2) {
      return true;
    } else {
      return false;
    }
  }
  float sqr(float a){
    return a*a;
  }
}

