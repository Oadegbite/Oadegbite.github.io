Target target;
Population saber;
Population saber2;
int lifetime = 300;
int lifeCounter;

void setup()
{
  size(780,580);
  lifeCounter = 0;
  target = new Target(new PVector(width/2,50), 20);
  lifetime = 300;
  saber = new Population(50, target);

}

void draw()
{
  background(255);
  target.display();
  saber.display();
 if (lifeCounter < lifetime)
 {
   saber.run();
   lifeCounter++;
 }
 else {
  lifeCounter = 0;
  saber.fitness();
  saber.monteSelect();
  saber.reproduce();

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

  //[end]

  Rocket(PVector origin)
  {
   dna = new DNA();
   velocity = new PVector(0,0);
   acceleration = new PVector(0,0);
   location = origin.get();
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
   applyForce( dna.genes[lifeCounter] );
   update();
   display();
  }

  void hitCheck(Target tar)
  {

  }

  void display()
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

  void fitness(Target tar)
  {
    float dist = PVector.dist(location,tar.loc);
    fitness = pow(1/dist,2);
    fitness = map(fitness, 0, 1, 0, 1000);
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
 float mutuationRate = 0.02;
 Rocket[] population;
 ArrayList<Rocket> matingPool;
 PVector origin;
 float popFit;
 int generation;

 Target target;

 Population(int popSize, Target tar)
 {
   population = new Rocket[popSize];
   origin = new PVector(width/2,height - 20);
   matingPool = new ArrayList<Rocket>();
   target = tar;
   generation = 0;
   for (int i = 0; i < population.length; i++)
   {
    population[i] = new Rocket(origin);
   }

 }

 void run()
 {
  for (Rocket r : population)
  {
    r.run();
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
   stroke(0);
   text("Generation #: ", 10, 20);
   text(generation, 90, 20);
   text("Population Fitness #: ", 10, 40);
   text(popFit, 120, 40);
   text("Cycles Left #: ", 10, 60);
   text(lifetime - lifeCounter, 90, 60);
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
  }

}
