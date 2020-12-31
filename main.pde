
import android.view.MotionEvent;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;

import org.jbox2d.collision.shapes.Shape;
import processing.sound.*;

SoundFile soundfile;



  
// A reference to our box2d world
Box2DProcessing box2d;

ParticleSystem ParticleSystem;
//File[] files = listFiles(dataPath("assets"), "files", "extension=wav");
    
    
// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;
ArrayList<Bot> bots;
ArrayList<Circle> circles;
ArrayList<Player> players;
float translateX, translateY;
MapMaker mapMaker;
Cam2d cam2d;
Joystick[] joysticks;
Button[] buttons;
int buttons_count, joysticks_count;
int TouchEvents;
float xTouch[];
float yTouch[];
lightMap light_map;

void setup() {
  fullScreen(P2D);
  orientation(PORTRAIT);
  fill(0,255,255,255);
  textSize(50);
  text("Loading assets...",displayWidth/100,displayHeight/2);
  textSize(16);
  smooth();
  //Camera2d
  cam2d=new Cam2d(displayWidth,displayHeight);
  
  //ParticleSystem
  ParticleSystem=new ParticleSystem();
  
  //Music
  // Load a soundfile
  soundfile = new SoundFile(this, sketchPath("assets")+"/background/music/streetsound2.aiff");
  soundfile.amp(.2);
  // Play the file in a loop
  soundfile.loop();
  
  
  // Initialize Multitouch x y arrays
  xTouch = new float [10];
  yTouch = new float [10]; // Don't use more than ten fingers!
  
  //Initialize lightMap
  light_map = new lightMap();
  light_map.addSpot(new Spot(new Vec2(width/2,height/2),10.8*205,1));
  //light_map.removeSpot(light_map.spots.get(0));
  //Joystick
  joysticks=new Joystick[5];
  joysticks[joysticks_count]=new Joystick(displayWidth/2,displayHeight-displayHeight/8,displayHeight/5, displayHeight/10);
  joysticks_count++;
  
  //Initialize buttons
  buttons = new Button[200];
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);
  // Turn on collision listening!
  box2d.world.setContactListener(new CustomListener(this));



  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  circles = new ArrayList<Circle>();
  bots = new ArrayList<Bot>();
  //circles.add(new Circle(100,200,25));
  
 
  
  players = new ArrayList<Player>();
  players.add(new Player(150,150,25));
 // boxes.add(new Box(800,300,20,20));
  // Add a bunch of fixed boundaries
 // boundaries.add(new Boundary(width/4,height-5,width/2-50,10));
 // boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10));
  int  w=100;
  int h=100;
  int X=100;
  int Y=100;
  int hh=0;
  int ww=0;
  mapMaker=new MapMaker(200,20);
  for(int y=0;y<mapMaker.h;y++){
    for(int x=0;x<mapMaker.w;x++){
      if(int(random(10))==0){
        bots.add(new Bot(this,X+x*w,Y+y*h,25));
      }
      if(mapMaker.lab[y][x]!=""){
        if (mapMaker.lab[y][x]=="wd"){
          boundaries.add(new Boundary(X+x*w,Y+y*h,10-ww,h-hh));
          boundaries.add(new Boundary(X+x*w+w/2,Y+y*h-h/2,w-ww,10-hh));
        }
        else if (mapMaker.lab[y][x]=="d"){
          boundaries.add(new Boundary(X+x*w,Y+y*h,10-ww,h-hh));
          //world.addPhysicBoxShape(new PhysicBoxShape(x*100+50,y*100-50,100,10));
        }
        else if (mapMaker.lab[y][x]=="w"){
          //world.addPhysicBoxShape(new PhysicBoxShape(x*100,y*100,10,100));
          boundaries.add(new Boundary(X+x*w+w/2,Y+y*h-h/2,w-ww,10-hh));
        }
        
      }
    }
  }
  float ghh=second()*10000+millis();
  
  try{for(int i=1;i<2;i++){
    ParticleSystem.addParticle(new Particle(this,sketchPath("assets")+"/boom/"+"1.png",256,256,new Vec2(i*100,500)));
  }
  println((second()*10000+millis()-ghh)/10000);
  }
  catch(Exception e){
    println(e);
  }
  //boundaries.get(0).body
}

void draw() {
  background(255);
  
  // We must always step through time!
  box2d.step();
  
  //
  Player pl=players.get(0);
  Vec2 pos=cam2d.lookAt(pl.getPos(),pl.r,pl.r);
  translateX=pos.x;
  translateY=pos.y;
  
  
  
  //camera update
  cam2d.upd(translateX, translateY);

  // Display all the boundaries
  for (Boundary b: boundaries) {
    Vec2 po = box2d.getBodyPixelCoord(b.body);
    if (cam2d.canDraw(po.x, po.y, b.w, b.h )){
      b.display(translateX, translateY);
    }
  }
  
  // Display all the circles
  for (Circle b: circles) {
    Vec2 po = box2d.getBodyPixelCoord(b.body);
    if (cam2d.canDraw(po.x, po.y, b.r, b.r )){
      b.display(translateX, translateY);
    }
  }
  
  // Display all the bots
  for (Bot b: bots) {
    Vec2 po = box2d.getBodyPixelCoord(b.body);
    if (cam2d.canDraw(po.x, po.y, b._R, b._R )){
      b.display(translateX, translateY, ParticleSystem);
      b.setInvisible(false);
    }
    else{
      b.setInvisible(true);
    }
  }
  
  // Display all the boxes
  for (Box b: boxes) {
    Vec2 po = box2d.getBodyPixelCoord(b.body);
    if (cam2d.canDraw(po.x, po.y, b.w, b.h )){
      b.display(translateX, translateY);
    }
  }
  
  //Player 
  players.get(0).move(joysticks[0].getXd(), -joysticks[0].getYd());
  for(Player p:players){
    p.display(translateX, translateY);
  }
  
  ParticleSystem.display(translateX, translateY,cam2d);
  
  light_map.display();
  
  
  //Display all joysticks
  for (int i=0;i<joysticks_count;i++){
    joysticks[i].display();
  }
  fill(0);
  
  
  textSize(50);
  text(int(frameRate),450,height/2);
}












public boolean surfaceTouchEvent(MotionEvent event) {
  /*
  This function for handling multitouches
  */
  
  // Number of places on the screen being touched:
  TouchEvents = event.getPointerCount();
 
  // If no action is happening, listen for new events else 
  for (int i = 0; i < TouchEvents; i++) {
    int pointerId = event.getPointerId(i);
    xTouch[pointerId] = event.getX(i); 
    yTouch[pointerId] = event.getY(i);
    float siz = event.getSize(i);
    for (int i1=0;i1<buttons_count;i1++){
      buttons[i1].pressed(event.getX(i),event.getY(i),event.getActionMasked(),pointerId,TouchEvents);
    }
    for (int i1=0;i1<joysticks_count;i1++){
      joysticks[i1].pressed(event.getX(i),event.getY(i),event.getActionMasked(),pointerId,TouchEvents);
    }
  }
  // ACTION_DOWN 
  if (event.getActionMasked() == 0 ) {
    print("Initial action detected. (ACTION_DOWN)");
    print("Action index: " +str(event.getActionIndex()));
    
  } 
  // ACTION_UP 
  else if (event.getActionMasked() == 1) {
    print("ACTION_UP");
    print("Action index: " +str(event.getActionIndex()));
  }
  //  ACTION_POINTER_DOWN 
  else if (event.getActionMasked() == 5) {
    print("Secondary pointer detected: ACTION_POINTER_DOWN");
    print("Action index: " +str(event.getActionIndex()));
  }
  // ACTION_POINTER_UP 
  else if (event.getActionMasked() == 6) {
    print("ACTION_POINTER_UP");
    print("Action index: " +str(event.getActionIndex()));
  }
  // 
  else if (event.getActionMasked() == 4) {
    print("&&&");

  }

  // If you want the variables for motionX/motionY, mouseX/mouseY etc.
  // to work properly, you'll need to call super.surfaceTouchEvent().
  return super.surfaceTouchEvent(event);
}


