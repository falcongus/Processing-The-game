class Player {
  Body body;
  float r;float speed=500;float tormoz=5;
  float density = 1;
  float friction = 0.3;
  float restitution = .5;
  Fixture fixture;
  Player (float x,float y,float r_){
    r=r_;
    makeBody(new Vec2(x, y),r_);
  }
  // Drawing the circle
  void display(float trX,float trY) {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    
    pushMatrix();
    translate(pos.x+trX, pos.y+trY);
    rotate(-a);
    fill(175);
    stroke(0);
    ellipse(0,0, r,r);
    if(frameCount%60==89){
      setRadius(random(50,100));
    }
    popMatrix();
    //TODO:
    //vd();
  }
  void move(float xo, float yo) {
    Vec2 v=body.getLinearVelocity();
    if(sqrt(pow(v.x,2)+pow(v.y,2))<sqrt(speed)){
      body.applyForce(new Vec2(xo*speed,yo*speed), body.getWorldCenter());
    }
    else{
      //body.applyForce(new Vec2(abs(v.x)/v.x*this.tormoz,abs(v.y)/v.y*this.tormoz), body.getWorldCenter());
    }
    float s=.99;
    body.setLinearVelocity(new Vec2(v.x*s,v.y*s));
    //body.setLinearVelocity(new Vec2(xo*speed,yo*speed));
  }
  Vec2 getPos(){
     return box2d.getBodyPixelCoord(body);
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
    fixtureDef.filter.maskBits = 0x4 | 0x2;
    // Setting fixtureDef as body's fixture
    fixture=body.createFixture(fixtureDef);
  }
  void vd(){
    EdgeShapesCallback callback = new EdgeShapesCallback();
 
  float m_angle = frameCount * 0.01f;
  float radius = 20.0f;
  Vec2 point1 = new Vec2(0.0f, 10.0f);
  Vec2 p1p2 = new Vec2(radius * cos(m_angle), -radius * abs(sin(m_angle)));
  Vec2 point2 = point1.add(p1p2);
 
  callback.m_fixture = null;
  box2d.world.raycast(callback, point1, point2);
 
  strokeWeight(1);
  stroke(0);
  noFill();
  if (callback.m_fixture != null) {
    Vec2 head = callback.m_normal.mul(2).addLocal(callback.m_point);
    points(callback.m_point, 25);
    lines(point1, callback.m_point);
    lines(callback.m_point, head);
  } else {
    lines(point1, point2);
  }
    
  }
  void points(Vec2 p1, float size){
  Vec2 px_p1= box2d.coordWorldToPixels(p1);
  ellipse(px_p1.x, px_p1.y, size, size);
}
 
void lines(Vec2 p1, Vec2 p2){
  Vec2 px_p1 = box2d.coordWorldToPixels(p1);
  Vec2 px_p2 = box2d.coordWorldToPixels(p2);
  line(px_p1.x,px_p1.y, px_p2.x, px_p2.y);
}
 
}