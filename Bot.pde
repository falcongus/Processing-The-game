class Bot {
  Body body;
  float r,_R;float speed=50;
  float density = 1;
 
  float friction = 0.3;
  float restitution = 1;
  boolean visible=true;
  float last_pos[];
  color Color=color(255,0,0,255);
  ArrayList<SoundFile> sounds;
  ArrayList<Vec2> pos_was;
  ArrayList<Particle> particles;
  int pos_was_count=3;
  Vec2 vel=new Vec2(random(1,10)/10,random(1,10)/10);
  Fixture fixture;
  PApplet papplet;
  Bot (PApplet papplet,float x,float y,float r_){
    r=r_;
    this.papplet=papplet;
    makeBody(new Vec2(x, y),r_);
    this._R=r_;
    this.last_pos=new float[3];
    this.last_pos[0]=x;
    this.last_pos[1]=y;
    this.last_pos[2]=second();
    pos_was = new ArrayList<Vec2>();
    particles= new ArrayList<Particle>();
    sounds = new ArrayList<SoundFile>();
  }
  // Drawing the circle
  void display(float trX,float trY, ParticleSystem ps) {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    mustParticles(ps);
    particle(pos,-a,trX,trY);
    
    pushMatrix();
    translate(pos.x+trX, pos.y+trY);
    rotate(-a);
    fill(Color);
    stroke(0);
    ellipse(0,0, r,r);
    popMatrix();
    
    move(this.vel.x,this.vel.y);
   // if(abs(second()-this.last_pos[2])>5){
   //   body.applyForce(new Vec2(random(-1,1)*speed,random(-1,1)*speed), body.getWorldCenter());
   // }
  }
  void setInvisible(boolean h){
    visible=h;
  }
  void mustParticles(ParticleSystem ps){
    if(particles.size()>0){
      for(Particle p: particles){
        ps.addParticle(p);
        particles.remove(p);
      }
    }
  }
  void addParticle(Particle p){
    particles.add(p);
    playSound(sketchPath("assets")+"/boom/sounds/"+int(random(1,9))+".wav");
  }
  void playSound(String stru){
    //Music
    SoundFile soundfile;
    // Load a soundfile
    soundfile = new SoundFile(papplet, stru);
    // Play the file in a loop
    soundfile.play();
    sounds.add(soundfile);
    
  }
  void particle (Vec2 pos,float a,float trX,float trY){
    if(pos_was.size()>0){
      if(dist(pos_was.get(pos_was.size()-1).x,pos_was.get(pos_was.size()-1).y,pos.x,pos.y)>r/2){
        pos_was.add(pos);
      }
    }
    else{
      pos_was.add(pos);
    }
    if(pos_was.size()>pos_was_count){
      pos_was.remove(pos_was.get(0));
    }
    float Rr=0;
    for(Vec2 POS:pos_was){
      Rr+=r/pos_was.size();
      pushMatrix();
      stroke(0,0);
      translate(POS.x+trX,POS.y+trY);
      rotate(a);
      fill(Color);
      stroke(0);
      ellipse(0,0, Rr,Rr);
      popMatrix();
    }
    
  }
  void cVel(Vec2 pos){
    Vec2 p = box2d.getBodyPixelCoord(body);
    int k=1+int(random(5));
    if(abs(pos.x-p.x)<abs(pos.y-p.y)){
      if(this.vel.x>0){
        this.vel.x=-1;
      }
      else{
        this.vel.x=1;
      }
      this.vel.y=0;
    }
    else{
      if(this.vel.y>0){
        this.vel.y=-1;
      }
      else{
        this.vel.y=1;
      }
      this.vel.x=0;
    }
   
    this.vel=new Vec2(this.vel.x*speed,this.vel.y*speed);
  }
  
  void move(float xo, float yo) {
    Vec2 v=body.getLinearVelocity();
    
    
    //  body.applyForce(new Vec2(xo*speed,yo*speed), body.getWorldCenter());
   // }
   // else{
     // body.applyForce(new Vec2(abs(v.x)/v.x*this.tormoz,abs(v.y)/v.y*this.tormoz), body.getWorldCenter());
   // }
    float s=.99;
    float xx=(v.x+.001)/(abs(v.x)+.001);
    float yy=(v.y+.001)/(abs(v.y)+.001);
    float k=speed/10;
    Vec2 V=new Vec2(box2d.scalarPixelsToWorld(k),box2d.scalarPixelsToWorld(k));
    if(abs(v.x)<V.x){
      v.x+=yy*speed/10;
    }
    if(abs(v.y)<V.y){
      v.y+=yy*speed/10;
    }
    body.setLinearVelocity(v);
    
    if( sqrt(pow(v.x,2)+pow(v.y,2))<sqrt(speed)){
     // body.setLinearVelocity(new Vec2(random(-speed,speed),random(-speed,speed)));
    
    body.applyForce(new Vec2(xx*speed,yy*speed), body.getWorldCenter());
    }
    //body.setLinearVelocity(new Vec2(v.x*s,v.y*s));
    //body.setLinearVelocity(new Vec2(xo*speed,yo*speed));
  }
  void setRadius(float _r){
    this.r=_r;
    body.destroyFixture(fixture);
    // Creating CircleShape object
    CircleShape circleShape = new CircleShape();
    circleShape.m_radius = box2d.scalarPixelsToWorld(r/2);
    
    //Creating Fixture Definition object
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = circleShape;
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    fixtureDef.restitution = restitution;
    fixture=body.createFixture(fixtureDef);

  }
  void makeBody(Vec2 center, float r) {
   
    // Creating the Body Definition
    BodyDef bodyDef = new BodyDef();
    // Set position to Body Definition
    bodyDef.position.set(box2d.coordPixelsToWorld(center));
    // Setting body type to body definition
    bodyDef.type = BodyType.DYNAMIC;
    
    // "Uploading" the ball into the world
    body = box2d.createBody(bodyDef);
    body.setUserData(this);
    setShape(r);
    
    body.setLinearVelocity(new Vec2(10,1));
  }
  void setShape(float r){
    this.r=r;
    // Creating CircleShape object
    CircleShape circleShape = new CircleShape();
    // Setting radius to CircleShape
    circleShape.m_radius = box2d.scalarPixelsToWorld(r/2);
    
   
    //Creating Fixture Definition object
    FixtureDef fixtureDef = new FixtureDef();
    // Setting circleShape as shape of fixture definition
    fixtureDef.shape = circleShape;
    // This defines the heaviness of the body with respect to its area
    fixtureDef.density = density;
    // This defines how bodies slide when they come in contact with each other.
    // Friction value can be set between 0 and 1. Lower value means more slippery bodies.
    fixtureDef.friction = friction;
    // This define how bouncy is the body.
    // Restitution values can be set between 0 and 1.
    // Here higher value means more bouncy body.
    fixtureDef.restitution = restitution;
    fixtureDef.filter.categoryBits = 0x2 | 0x4;
    fixtureDef.filter.maskBits = 0x4;
    // Setting fixtureDef as body's fixture
    fixture=body.createFixture(fixtureDef);
  }
}