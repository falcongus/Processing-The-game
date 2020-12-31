// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// ContactListener to listen for collisions!
// Add a listener to listen for collisions!

import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;
import processing.core.PApplet;


HashMap<String,ArrayList<PImage>> assets=new HashMap<String,ArrayList<PImage>>();
class CustomListener implements ContactListener {
  PApplet pa;
  CustomListener(PApplet pa) {
    this.pa=pa;
  }

  // This function is called when a new collision occurs
  void beginContact(Contact cp) {
    
  }

  void endContact(Contact cp) {
    // TODO Auto-generated method stub
    // Get both shapes
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();
    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();
   
    // Get our objects that reference these bodies
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();
    //println("\n",o1,o2);
    if((o1 instanceof Bot) && (o2 instanceof Boundary)){
      Boundary p2 = (Boundary) o2;
      Vec2 pos = box2d.getBodyPixelCoord(p2.body);
      Bot p1 = (Bot) o1;
      //p1.cVel(pos);
     // p1.addParticle(new Particle(loadImage("BOOM.png"),5,pos));
    }
    else if((o2 instanceof Bot) && (o1 instanceof Boundary)){
      Boundary p2 = (Boundary) o1;
      Vec2 pos = box2d.getBodyPixelCoord(p2.body);
      Bot p1 = (Bot) o2;
      //p1.cVel(pos);
    }
    else if((o2 instanceof Bot) && (o1 instanceof Player)){
      Player p2 = (Player) o1;
      Vec2 pos = box2d.getBodyPixelCoord(p2.body);
      Bot p1 = (Bot) o2;
      //p1.cVel(pos);
      p1.addParticle(new Particle(pa,loadimage(sketchPath("assets")+"/boom/"+"1.png",256,256),new Vec2(pos.x,pos.y)));
  
    }
  }

  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
  ArrayList<PImage> loadimage(String path,int ww,int hh){
    if(assets.containsKey(path)){
      return assets.get(path);
    }
    else{
      PImage image=pa.loadImage(path);
      ArrayList<PImage> images=new ArrayList<PImage>();
      images=cutImage(image,ww,hh);
      assets.put(path,images);
      return images;
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
}



