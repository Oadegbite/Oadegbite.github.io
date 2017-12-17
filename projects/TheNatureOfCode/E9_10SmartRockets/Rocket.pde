class Rocket {

  //[full] A rocket has three vectors: location, velocity, acceleration.
  PVector location;
  PVector velocity;
  PVector acceleration;
  float fitness;
  DNA dna;
  float r = 3;
  int geneCount = 0;
  boolean hit;
  
  //[end]

  Rocket(PVector origin)
  {
   dna = new DNA();
   velocity = new PVector(0,0);
   acceleration = new PVector(0,0);
   location = origin.get();
   hit = false;
  }

  //[full] Accumulating forces into acceleration (Newton’s 2nd law)
  void applyForce(PVector f) {
    acceleration.add(f);
  }
  //[end]

  // Our simple physics model (Euler integration)
  void update() {
    // Velocity changes according to acceleration.
    velocity.add(acceleration);
    // Location changes according to velocity.
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void run(){
   if (!hit)
   {
     applyForce( dna.genes[lifeCounter] );
     update();
   }
    
   displayR();
  }
  
   void runB(){
   if (!hit)
   {
     applyForce( dna.genes[lifeCounter] );
     update();
   }
   displayB();
  }
  
  void hitCheck(Target tar)
  {
     float d = dist(location.x, location.y, tar.loc.x, tar.loc.y);
    if (d < tar.radius/2) {
      hit = true;
    } 
  }
  
  void displayR()
  {
    float theta = velocity.heading() + PI/2;
    fill(255,0,0);
    stroke(0);
    pushMatrix();
    
    translate(location.x,location.y);
    rotate(theta);
    
    beginShape(TRIANGLES);
    vertex(0,-r*2);
    vertex(-r,r*2);
    vertex(r,r*2);
    endShape();
    
    popMatrix();
  }
  
  void drag(fluid f)
  {
    
  }
  
  void displayB()
  {
    float theta = velocity.heading() + PI/2;
    fill(0,67,255);
    stroke(0);
    pushMatrix();
    
    translate(location.x,location.y);
    rotate(theta);
    
    beginShape(TRIANGLES);
    vertex(0,-r*2);
    vertex(-r,r*2);
    vertex(r,r*2);
    endShape();
    
    popMatrix();
  }
  
  void fitness(Target tar)
  {
    float dist = PVector.dist(location,tar.loc);
    fitness = pow(1/dist,2);
    fitness = map(fitness, 0, 1, 0, 1000);
    if(hit) fitness += 1000;
  }
  
  
}