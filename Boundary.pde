// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A fixed boundary class

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
  
  // But we also have to make a body for box2d to know about it
  Body body;

  Boundary(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
   
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    body.setUserData(this);
    // Attached the shape to the body using a Fixture
    //b.createFixture(sd,1);
    FixtureDef fixtureDef = new FixtureDef();
    // Setting circleShape as shape of fixture definition
    fixtureDef.shape = sd;
    fixtureDef.filter.categoryBits = 0x4;
    fixtureDef.filter.maskBits = 0x2;
    body.createFixture(fixtureDef);
    
  } 

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display(float trX,float trY) {
    //b.BodyDef(frameRate%10/10);
    //b.setTransform(b.getWorldCenter(), frameRate-frameRate%360);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    x=pos.x;y=pos.y;
    float a = body.getAngle();
    pushMatrix();
    translate(x+trX,y+trY);
    rotate(-a);
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }

}


