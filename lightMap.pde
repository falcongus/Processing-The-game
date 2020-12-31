
class lightMap{
  float cubSize;
  int w,h;
  int count;
  PShader sh;
  ArrayList<Spot> spots;
  lightMap(){
    count=0;
    init();
    
  }
  void init() {
    spots = new ArrayList<Spot>();
    // load and compile shader
    sh = loadShader("frag.glsl");
    sh.set("resolution", float(displayWidth),float(displayHeight));
  }

  void display() {
    // normalize mouse position
    float[][] mas;
    int g=0;
    mas=new float[count+1][2];
    for(Spot spot:spots){
      mas[g][0]=spot.pos.x;
      mas[g][1]=spot.pos.y;
      g++;
    }
    float inpx = mouseX;//(float)width;
    float inpy = width-mouseY;//(float)height;
    // set shader variable
    sh.set("inp",spots.get(0).pos.x,spots.get(0).pos.y);
    sh.set("count",count);
    sh.set("r",spots.get(0).r/displayHeight);
    //rect(0,0,width,height);
    filter(sh);
  }
  Spot addSpot(Spot spot){
    boolean a=true;
    for(Spot s:spots){
      if(s==spot){
        a=false;
        break;
      }
    }
    if(a){
      spots.add(spot);
      count++;
      return spot;
    }
    else{
      return null;
    }
  }
}