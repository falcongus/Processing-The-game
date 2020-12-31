class ParticleSystem{
  ArrayList<Particle> particles;
  ParticleSystem(){
    particles= new ArrayList<Particle>();
  }
  void display(float trX,float trY,Cam2d cam2d){
    try{
      for(Particle i: particles){
        Vec2 po = i.getPos();
        if (cam2d.canDraw(po.x, po.y, i.w, i.h )){
          i.display(particles,trX,trY);
        }
      }
    }catch(Exception e){println(e);}
    
  }
  void addParticle(Particle p){
    particles.add(p);
  }
}