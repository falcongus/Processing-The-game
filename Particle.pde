static class Particle {
  //@@@@@@@@@@@@@@@Static
  static HashMap<String,PImage> assets=new HashMap<String,PImage>();
  
  //@@@@@@@@@@@@@@@End static
  //@@@@@@@@@@@@@@@Begin 
  ArrayList<PImage> images;
  int current=0,cr=0;
  float angle=0;
  boolean noLoop=true;
  int animationSpeed=1;
  float w,h;
  String path;
  PApplet pa;
  float ghh;
  Vec2 pos;
  Particle(PImage img,int s,Vec2 poss){
    images=new ArrayList<PImage>();
    img.resize((img.width+(img.width%s))/s,img.width/s);//images.add(img);
    for(int i=0;i<s;i++){
      images.add(img);
    }
    pos=poss;
    w=images.get(0).width;
    h=images.get(0).height;
  }
  Particle(PApplet pA,String stri,int ww,int hh,Vec2 poss){
    try{
      pa=pA;
      ghh=pa.second()*10000+pa.millis();
      this.path=stri;
      PImage img=loadimage(stri);
      println("");
      println(stri,(pa.second()*10000+pa.millis()-ghh)/10000);
    images=cutImage(img,ww,hh);
    println(stri,"_",(pa.second()*10000+pa.millis()-ghh)/10000);
    pos=poss;
    w=images.get(0).width;
    h=images.get(0).height;
    }
    catch(Exception e){
      println(e);
    }
  }
  Particle(PApplet pp,ArrayList<PImage> img,Vec2 poss){
    pa=pp;
    images=img;
    pos=poss;
    w=images.get(0).width;
    h=images.get(0).height;
  }
  PImage loadimage(String path){
    if(Particle.assets.containsKey(path)){
      return Particle.assets.get(path);
    }
    else{
      PImage image=pa.loadImage(path);
      Particle.assets.put(path,image);
      return image;
    }
  }
  ArrayList<PImage> cutImage(PImage imag,int ww,int hh){
    ArrayList<PImage> images=new ArrayList<PImage>();
    imag.resize(imag.width+(imag.width%ww),imag.height+(imag.height%hh));
    imag.loadPixels();
   
    
    for(int y=0;y<imag.height/hh;y++){
      for(int x=0;x<imag.width/ww;x++){
        PImage img = pa.createImage(ww,hh,ARGB);
        img.loadPixels();
       // println(green(imag.pixels[50]));
        int n=imag.width/(imag.width/img.width);
        n*=x;
       
        int k=0;
        int op=y*hh*imag.width;
        boolean j=true;
        for (int i = 0; i < img.pixels.length && j; i ++) {
          img.pixels[i] =imag.pixels[n+i+k+op];
         // println((img.pixels[i]));
          if(i%img.width==0 && i!=0){
            //println(i);
            k+=imag.width-img.width;
          }
          if(i==ww*hh-1 && i!=0){
           
            j=false;
          }
        }
        img.updatePixels();
        images.add(img);
      }
    } 
    return images;
  }
  Vec2 getPos(){
    return pos;
  }
  void setPos(float x,float y){
    pos=new Vec2(x,y);
  }
  void display(ArrayList listFrom,float trX,float trY){
    try{
      //println(images.size());
      pa.pushMatrix();
      pa.translate (pos.x-w/2+trX,pos.y-h/2+trY);
      pa.rotate(angle);
      pa.image(images.get(current),0,0);
      cr++;
      if(cr>animationSpeed){
        current++;
        cr=0;
      }
      pa.popMatrix();
      if(current>images.size()-1){
        endF(listFrom);
        current=0;
      }
      
    }
    catch(Exception e){
      println(e);
    }
  }
  void endF(ArrayList l){
    if(this.noLoop){
      delete(l);
    }
  }
  void delete(ArrayList l){
    l.remove(this);
  }
} 