class Cam2d{
  float w,h,x,y,W,H;
  Cam2d(int w,int h){
    this.w=w/2;
    this.h=h/2;
    this.x=w/2;
    this.y=h/2;
    this.W=displayWidth/2;
    this.H=displayHeight/2;
    
  }
  void upd(float xd,float yd){
    this.x=this.W-xd;
    this.y=this.H-yd;
  }
  Vec2 lookAt(Vec2 p,float w,float h){
    float x=this.W-p.x;
    float y=this.H-p.y;
    Vec2 pos= new Vec2(x,y);
    return pos;
  }
  float getXmin(){
    return this.x-this.w;
  }
  float getYmin(){
    return this.y-this.h;
  }
  float getXmax(){
    return this.x+this.w;
  }
  float getYmax(){
    return this.y+this.h;
  }
  void lookAt(int x,int y){
    this.x=x;
    this.y=y;
  }
  boolean canDraw(float x,float y,float w,float h){
    float y1=abs(y-this.y)-(h+this.h);
    float x1=abs(x-this.x)-(w+this.w);
    if ((x1<0) && (y1<0)){
      return true;
    }
    else{
      return false;
    }
  }
}