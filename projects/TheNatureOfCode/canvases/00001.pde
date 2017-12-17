Target target;
Population saber;
Population saber2;
//fluid f;
int lifetime = 300;
int lifeCounter;

void setup()
{
  size(780,800);
  lifeCounter = 0;
  target = new Target(new PVector(width/2,50), 50);
  lifetime = 300;
  saber = new Population(25, target,0);
  saber2 = new Population(25, target,1);
  //f = new fluid(width/2,height/2, 50,50,0.1);

}

void draw()
{
  background(255);
  target.display();
  saber.display();
  saber2.display();
  //f.display();
 if (lifeCounter < lifetime)
 {
   saber.run();
   saber2.run();
   lifeCounter++;
 }
 else {
  lifeCounter = 0;
  saber.fitness();
  saber.monteSelect();
  saber.reproduce();

  lifeCounter = 0;
  saber2.fitness();
  saber2.monteSelect();
  saber2.reproduce();
 }

}

class DNA
{
  PVector[] genes = new PVector[lifetime];
  float maxforce = 0.5;


  DNA()
  {
    //genes = new PVector[lifetime];
    for (int i = 0; i < genes.length; i++) {
      float angle = random(TWO_PI);
      genes[i] = new PVector(cos(angle), sin(angle));
      genes[i].mult(random(0, maxforce));
    }

  }

  DNA crossOver(DNA partner)
  {
    DNA child = new DNA();

    for (int i = 0; i < genes.length; i++)
      {
        float r = random(1);
        if (r > 0.50) child.genes[i] = genes[i];
        else child.genes[i] = partner.genes[i];
      }

    return child;
  }


  void mutate(float m)
  {
    for (int i = 0; i < genes.length; i++)
    {
     if (random(1) < m)
     {
        genes[i] = PVector.random2D();
        genes[i].mult(random(0,maxforce));
     }
    }
  }

}

class Population
{
 float mutuationRate = 0.015;
 Rocket[] population;
 ArrayList<Rocket> matingPool;
 PVector origin;
 float popFit;
 int popSize;
 int generation;
 int popC; //for population color 0 = red, 1 = blue
 Target target;

 Population(int popSize_, Target tar, int popC_)
 {
   population = new Rocket[popSize_];
   origin = new PVector(width/2,height - 20);
   matingPool = new ArrayList<Rocket>();
   target = tar;
   popC = popC_;
   generation = 0;
   for (int i = 0; i < population.length; i++)
   {
    population[i] = new Rocket(origin);
   }
   popSize = popSize_;
 }

 void run()
 {
  for (Rocket r : population)
  {
    if ( popC == 0)   r.run();
    else r.runB();
    r.hitCheck(target);
  }
 }

 void fitness()
 {
   float total = 0;
   for ( Rocket r : population)
   {
     r.fitness(target);
     total += r.fitness;
   }
   popFit = total/population.length;
 }

 void monteSelect()
{
   matingPool.clear();
  while (matingPool.size() < population.length)
  {

    for (int i = 0; i < population.length; i++) {


    float m = random(1) * 100;

    float propb = m;

    float n = population[i].fitness * 100;


    if ( n > propb)
    {
      matingPool.add(population[i]);

    }

    }

  }
}


 void selection()
 {
   matingPool.clear();
   for ( int i = 0; i < population.length; i++)
   {

   }

 }

 void reproduce()
 {
   int a;
   int b;
   for (int i = 0; i < population.length; i++)
   {
   do
   {
     a = int(random(matingPool.size()));
     b = int(random(matingPool.size()));
   }
   while ( a==b);

   Rocket parentA = matingPool.get(a);
   Rocket parentB = matingPool.get(b);

   Rocket child = new Rocket(origin);
   DNA cDNA = parentA.dna.crossOver(parentB.dna);
   cDNA.mutate(mutuationRate);

   child.dna = cDNA;

   population[i] = child;

 }

 generation++;
 }

 void display()
 {
   if(popC == 0)
 {
   stroke(0);
   fill(255,0,0);
   text("Generation #: ", 10, 20);
   text(generation, 100, 20);
   text("Population Fitness #: ", 10, 40);
   text(popFit, 130, 40);
   text("Cycles Left #: ", 10, 60);
   text(lifetime - lifeCounter, 100, 60);
   text("Population Size #: ", 10, 80);
   text(popSize, 120, 80);
   text("Mutuation Rate #: ", 10, 100);
   text(mutuationRate, 120, 100);
 }

 else
 {
   stroke(0);
   fill(0,67,255);
   text("Generation #: ", width - 180, 20);
   text(generation, width - 95, 20);
   text("Population Fitness #: ", width - 180, 40);
   text(popFit, width - 55, 40);
   text("Cycles Left #: ", width - 180, 60);
   text(lifetime - lifeCounter, width - 95, 60);
   text("Population Size #: ", width - 180, 80);
   text(popSize, width - 65, 80);
   text("Mutuation Rate #: ", width - 180, 100);
   text(mutuationRate, width - 70, 100);
 }

 }

}

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

class Target
{
 PVector loc;
 float radius;

 Target(PVector w, float r)
 {
   loc = w;
   radius = r;
 }

  void display()
  {
    fill(0);
    ellipse(loc.x,loc.y,radius,radius);
    text("Target",loc.x-20,loc.y+50);
  }

}
