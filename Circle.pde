class Circle {
  Body body;
  float r;float speed=50;
  float density = 1;
  float friction = 0.3;
  float restitution = .5;
  Fixture fixture;
  Circle (float x,float y,float r_){
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
    if(frameCount%60==0){
      setRadius(random(50,100));
    }
    popMatrix();
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
    setShape(r);
    body.setUserData(this);
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
    fixtureDef.filter.categoryBits = 0x2;
    fixtureDef.filter.maskBits = 0x4;
    // Setting fixtureDef as body's fixture
    fixture=body.createFixture(fixtureDef);
  }
}