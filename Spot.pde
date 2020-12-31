class Spot{
  float intensity=25,r;
  Vec2 pos;
  color Color;
  Spot(Vec2 poss,float ra,float k){
    this.pos=poss;
    this.r=ra;
    this.intensity=k;
    this.Color=color(250,250,255,0);
  }
  void setIntensity(float i){
    if(abs(i)>255 || i<0){
      i=255;
    }
    this.intensity=i;
  }
  float r(){
    return red(Color);
  }
  float g(){
    return green(Color);
  }
  float b(){
    return blue(Color);
  }
  float a(){
    return alpha(Color);
  }
}