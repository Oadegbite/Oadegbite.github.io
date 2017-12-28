class DNA
{
  PVector[] genes = new PVector[lifetime];
  float maxforce = 0.8;


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

}int lifetime = 350;
int lifeCounter;
fluid[] obs;
Target target;

RedVBlue redvblue;


void setup()
{
  size(780,900);
  lifeCounter = 0;
  lifetime = 300;
  redvblue = new RedVBlue();
}

void draw()
{

  background(255);
  redvblue.run();
  redvblue.display();
}

void mousePressed() {
  target.loc.x = mouseX;
  target.loc.y = mouseY;
}class fluid
{
   PVector loc;
 float radius;
 float c;

 fluid(PVector w)
 {
   loc = w;
   radius = random(100,200);
 }

  void display()
  {
    fill(74, 247, 17,30);
    ellipse(loc.x,loc.y,radius,radius);
    text("obstacle", loc.x, loc.y);
  }

  boolean collsionCheck(Target l2)
  {
    float d = dist(l2.loc.x, l2.loc.y, loc.x, loc.y);
     if (d < l2.radius) {
      return true;
    }
    return false;
  }

}class Population
{
 float mutuationRate = 0.01;
 Rocket[] population;
 ArrayList<Rocket> matingPool;
 PVector origin;
 float popFit;
 float maxFit;
 int popSize;
 int generation;
 int popC; //for population color 0 = red, 1 = blue
 Target target;

 Population(int popSize_, Target tar, int popC_)
 {
   population = new Rocket[popSize_];
   origin = new PVector(width/2,850);
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
    r.run(popC);
    r.hitCheck(target);
    r.hitCheck();
  }
 }

 void fitness()
 {
   float total = 0;
   maxFit = 0;
   for ( Rocket r : population)
   {
     r.fitnessR(target);
     total += r.fitness;
     if (r.fitness > maxFit) maxFit = r.fitness;
   }
   popFit = total/population.length;
 }

 void monteSelect()
{
   matingPool.clear();
   fitness();

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


  // Generate a mating pool
  void selection() {
    // Clear the ArrayList
    matingPool.clear();

    // Calculate total fitness of whole population
    maxFit = 0;

    // Calculate fitness for each member of the population (scaled to value between 0 and 1)
    // Based on fitness, each member will get added to the mating pool a certain number of times
    // A higher fitness = more entries to mating pool = more likely to be picked as a parent
    // A lower fitness = fewer entries to mating pool = less likely to be picked as a parent
    for (int i = 0; i < population.length; i++) {
      float fitnessNormal = map(population[i].fitness,-1,maxFit,0,1);
      int n = (int) (fitnessNormal * 100);  // Arbitrary multiplier
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
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
   int yCoord = 20;
   if(popC == 0)
 {
   stroke(0);
   fill(255,0,0);
   //text("Generation #: ", 10, yCoord + 80); code for indiviudal generation display
   //text(generation, 100, yCoord + 80); code for indiviudal generation display
   text("Population Fitness #: ", 10, yCoord);
   text(popFit, 150, yCoord);
   text("Life Left #: ", 10, yCoord + 20);
   text(lifetime - lifeCounter, 100, yCoord + 20);
   text("Population Size #: ", 10, yCoord + 40);
   text(popSize, 120, yCoord + 40);
   text("Mutuation Rate #: ", 10, yCoord + 60);
   text(mutuationRate, 120, yCoord + 60);
 }
 else
 {
   stroke(0);
   fill(0,67,255);
   //text("Generation #: ", width-180, yCoord + 80); code for indiviudal generation display
   //text(generation, width - 95, yCoord + 80); code for indiviudal generation display
   text("Population Fitness #: ", width - 180, yCoord);
   text(popFit, width - 55, yCoord);
   text("Life Left #: ", width - 180, yCoord + 20);
   text(lifetime - lifeCounter, width - 95, yCoord + 20);
   text("Population Size #: ", width - 180, yCoord + 40);
   text(popSize, width - 65, yCoord + 40);
   text("Mutuation Rate #: ", width - 180, yCoord + 60);
   text(mutuationRate, width - 70, yCoord + 60);
 }

   stroke(0);
   fill(0);
   text("Generation #: ", width/2 - 65, 20);
   text(generation, width/2 + 25 , 20);

 }

}class RedVBlue
{
   Population[] sRockets;


  RedVBlue()
  {
   target = new Target(new PVector(width/2,70), 50);
   makePop();
   makeObs();
  }

  /*
   Make the population of rockets red and blue putting them in an array for easy use and expandabilty
  */
  void makePop()
  {
    Population redPop = new Population(15, target,0);
    Population bluePop = new Population(15, target,1);
    sRockets = new Population[2];
    sRockets[0] = redPop;
    sRockets[1] = bluePop;
  }


  /*
  Make an array of obsticles called fluid because they were supposed to be patchs that would slow down the ships
  */
  void makeObs()
  {
    PVector check;
    obs = new fluid[5];
    for(int i = 0; i < obs.length; i++)
       {
         if (i % 2 == 0)
         {
           check = new PVector(random(width/2,width),height/2);
         }
         else
         {
           check = new PVector(random(0,width/2),height/2);
         }
         obs[i] = new fluid(check);
      }
  }

  void run()
  {

      if (keyPressed)
    {
      if (key == 'q' || key =='Q'){
        sRockets[0].mutuationRate += -0.01;
      }
      if (key == 'W' || key =='w'){
        sRockets[0].mutuationRate += 0.01;
      }
      if (key == 'o' || key =='O'){
        sRockets[1].mutuationRate += -0.01;
      }
      if (key == 'P' || key =='p'){
        sRockets[1].mutuationRate += 0.01;
      }
      if (key == 'R' || key =='r'){

        for( Population p : sRockets)
       {
         p.mutuationRate = 0.01;
       }
      }
      if (key == 'V' || key =='v'){
        PVector check;
            for(int i = 0; i < obs.length; i++)
             {
               if (i % 4 == 0)
               {
                 check = new PVector(random(width/2,width),height/2);
               }
               else if (i % 4 == 1)
               {
                 check = new PVector(random(0,width/2),height/2);
               }
               else if (i % 4 == 2){

                 check = new PVector(random(0,width/2),height/2);
               }
               else
               {
                 check = new PVector(random(width/2,width),height/2);
               }
               obs[i] = new fluid(check);
            }
      }
    }

    if (lifeCounter < lifetime)
     {
       for( Population p : sRockets)
       {
         p.run();
       }
       lifeCounter++;
     }

         else
         {
          lifeCounter = 0;
          for( Population p : sRockets)
            {
                p.fitness();
                p.monteSelect();
                p.reproduce();
             }
         }
  }


  void display()
  {
    target.display();
    for(Population p : sRockets)
    {
      p.display();
    }
    for(fluid f : obs)
    {
      f.display();
    }
    stroke(0);
    fill(255,0,0);
    text("Mutation Rate: W increase/Q decrease", 10, height -50);
    stroke(0);
    fill(0,67,255);
    text("Mutation Rate: P increase/O decrease", width - 250, height -50);
    fill(0);
    text("R to reset mutation rates",(width/2)-75,height -50);
    fill(0);
    text("V to shuffle obstacles",(width/2)-60,height - 75);
  }



}class Rocket {

  //[full] A rocket has three vectors: location, velocity, acceleration.
  PVector location;
  PVector velocity;
  PVector acceleration;
  float fitness;
  DNA dna;
  float r = 3;
  int geneCount = 0;
  boolean hit;
  boolean fhit;
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

  void run(int popC){
   if (!hit && !fhit)
   {
     applyForce( dna.genes[lifeCounter] );
     checkEdges();
     update();
   }
   display(popC);
  }


  void hitCheck(Target tar)
  {
     float d = dist(location.x, location.y, tar.loc.x, tar.loc.y);
    if (d < tar.radius/2) {
      hit = true;
    }

  }

 void hitCheck()
 {
   for (fluid f : obs)
   {
     float d = dist(location.x, location.y, f.loc.x, f.loc.y);
    if (d < f.radius/2) {
      fhit = true;
    }

   }

 }

   void checkEdges()
  {
    if (location.x > width){
      location.x = 0;
    }
    if (location.x < 0){
      location.x = width;
    }
    /*
    if ( location.y > height){
      location.y = 0;
    }
    if (location.y < 0)
    {
      location.y = height;
    }
    */
  }

  void display(int popC)
  {
    float theta = velocity.heading() + PI/2;
    if (popC == 0) fill(255,0,0);
    else fill(0,67,255);
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

   void fitnessR(Target tar)
  {
    float dist = PVector.dist(location,tar.loc);
    fitness = pow(1/dist,2);
    fitness = map(fitness, 0, 1, 0, 5);
    if(hit) fitness += 1000;
    if ( location.y > height/2 ){
      fitness -= pow(1/dist,2);
    }
    else if(fhit) fitness -= pow(1/dist,2);

  }
  /*
  void fitness(Target tar)
  {
    println("start");
    float dist = PVector.dist(location,tar.loc);
    println("dist:" + dist);
    fitness = pow(1/dist,2);
    if(hit) fitness = 1;
   // if(fhit) fitness -= 1;
    println("hit:" + hit);
    println("fhit:" + fhit);
     System.out.println("B map "+fitness);
    fitness = map(fitness, 0, 1, 0, 1);
    System.out.println("A map "+fitness);
  }
  */

}class Target
{
 PVector loc;
 float radius;

 Target(PVector w, float r)
 {
   loc = w;
   radius = r;
 }

Target(PVector w)
 {
   loc = w;
 }

  void display()
  {
    fill(0);
    text("Click/Tap to move",loc.x-50,loc.y+60);
    ellipse(loc.x,loc.y,radius,radius);
    text("Target",loc.x-20,loc.y+40);
  }

}






class DNA
{
  PVector[] genes = new PVector[lifetime];
  float maxforce = 0.8;


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
int lifetime = 350;
int lifeCounter;
fluid[] obs;
Target target;

RedVBlue redvblue;


void setup()
{
  size(780,900);
  lifeCounter = 0;
  lifetime = 300;
  redvblue = new RedVBlue();
}

void draw()
{

  background(255);
  redvblue.run();
  redvblue.display();
}

void mousePressed() {
  target.loc.x = mouseX;
  target.loc.y = mouseY;
}
class fluid
{
   PVector loc;
 float radius;
 float c;

 fluid(PVector w)
 {
   loc = w;
   radius = random(100,200);
 }

  void display()
  {
    fill(74, 247, 17,30);
    ellipse(loc.x,loc.y,radius,radius);
    text("obstacle", loc.x, loc.y);
  }

  boolean collsionCheck(Target l2)
  {
    float d = dist(l2.loc.x, l2.loc.y, loc.x, loc.y);
     if (d < l2.radius) {
      return true;
    }
    return false;
  }

}
class Population
{
 float mutuationRate = 0.01;
 Rocket[] population;
 ArrayList<Rocket> matingPool;
 PVector origin;
 float popFit;
 float maxFit;
 int popSize;
 int generation;
 int popC; //for population color 0 = red, 1 = blue
 Target target;

 Population(int popSize_, Target tar, int popC_)
 {
   population = new Rocket[popSize_];
   origin = new PVector(width/2,850);
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
    r.run(popC);
    r.hitCheck(target);
    r.hitCheck();
  }
 }

 void fitness()
 {
   float total = 0;
   maxFit = 0;
   for ( Rocket r : population)
   {
     r.fitnessR(target);
     total += r.fitness;
     if (r.fitness > maxFit) maxFit = r.fitness;
   }
   popFit = total/population.length;
 }

 void monteSelect()
{
   matingPool.clear();
   fitness();

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


  // Generate a mating pool
  void selection() {
    // Clear the ArrayList
    matingPool.clear();

    // Calculate total fitness of whole population
    maxFit = 0;

    // Calculate fitness for each member of the population (scaled to value between 0 and 1)
    // Based on fitness, each member will get added to the mating pool a certain number of times
    // A higher fitness = more entries to mating pool = more likely to be picked as a parent
    // A lower fitness = fewer entries to mating pool = less likely to be picked as a parent
    for (int i = 0; i < population.length; i++) {
      float fitnessNormal = map(population[i].fitness,-1,maxFit,0,1);
      int n = (int) (fitnessNormal * 100);  // Arbitrary multiplier
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
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
   int yCoord = 20;
   if(popC == 0)
 {
   stroke(0);
   fill(255,0,0);
   //text("Generation #: ", 10, yCoord + 80); code for indiviudal generation display
   //text(generation, 100, yCoord + 80); code for indiviudal generation display
   text("Population Fitness #: ", 10, yCoord);
   text(popFit, 150, yCoord);
   text("Life Left #: ", 10, yCoord + 20);
   text(lifetime - lifeCounter, 100, yCoord + 20);
   text("Population Size #: ", 10, yCoord + 40);
   text(popSize, 120, yCoord + 40);
   text("Mutuation Rate #: ", 10, yCoord + 60);
   text(mutuationRate, 120, yCoord + 60);
 }
 else
 {
   stroke(0);
   fill(0,67,255);
   //text("Generation #: ", width-180, yCoord + 80); code for indiviudal generation display
   //text(generation, width - 95, yCoord + 80); code for indiviudal generation display
   text("Population Fitness #: ", width - 180, yCoord);
   text(popFit, width - 55, yCoord);
   text("Life Left #: ", width - 180, yCoord + 20);
   text(lifetime - lifeCounter, width - 95, yCoord + 20);
   text("Population Size #: ", width - 180, yCoord + 40);
   text(popSize, width - 65, yCoord + 40);
   text("Mutuation Rate #: ", width - 180, yCoord + 60);
   text(mutuationRate, width - 70, yCoord + 60);
 }

   stroke(0);
   fill(0);
   text("Generation #: ", width/2 - 65, 20);
   text(generation, width/2 + 25 , 20);

 }

}
class RedVBlue
{
   Population[] sRockets;


  RedVBlue()
  {
   target = new Target(new PVector(width/2,70), 50);
   makePop();
   makeObs();
  }

  /*
   Make the population of rockets red and blue putting them in an array for easy use and expandabilty
  */
  void makePop()
  {
    Population redPop = new Population(15, target,0);
    Population bluePop = new Population(15, target,1);
    sRockets = new Population[2];
    sRockets[0] = redPop;
    sRockets[1] = bluePop;
  }


  /*
  Make an array of obsticles called fluid because they were supposed to be patchs that would slow down the ships
  */
  void makeObs()
  {
    PVector check;
    obs = new fluid[5];
    for(int i = 0; i < obs.length; i++)
       {
         if (i % 2 == 0)
         {
           check = new PVector(random(width/2,width),height/2);
         }
         else
         {
           check = new PVector(random(0,width/2),height/2);
         }
         obs[i] = new fluid(check);
      }
  }

  void run()
  {

      if (keyPressed)
    {
      if (key == 'q' || key =='Q'){
        sRockets[0].mutuationRate += -0.01;
      }
      if (key == 'W' || key =='w'){
        sRockets[0].mutuationRate += 0.01;
      }
      if (key == 'o' || key =='O'){
        sRockets[1].mutuationRate += -0.01;
      }
      if (key == 'P' || key =='p'){
        sRockets[1].mutuationRate += 0.01;
      }
      if (key == 'R' || key =='r'){

        for( Population p : sRockets)
       {
         p.mutuationRate = 0.01;
       }
      }
      if (key == 'V' || key =='v'){
        PVector check;
            for(int i = 0; i < obs.length; i++)
             {
               if (i % 4 == 0)
               {
                 check = new PVector(random(width/2,width),height/2);
               }
               else if (i % 4 == 1)
               {
                 check = new PVector(random(0,width/2),height/2);
               }
               else if (i % 4 == 2){

                 check = new PVector(random(0,width/2),height/2);
               }
               else
               {
                 check = new PVector(random(width/2,width),height/2);
               }
               obs[i] = new fluid(check);
            }
      }
    }

    if (lifeCounter < lifetime)
     {
       for( Population p : sRockets)
       {
         p.run();
       }
       lifeCounter++;
     }

         else
         {
          lifeCounter = 0;
          for( Population p : sRockets)
            {
                p.fitness();
                p.monteSelect();
                p.reproduce();
             }
         }
  }


  void display()
  {
    target.display();
    for(Population p : sRockets)
    {
      p.display();
    }
    for(fluid f : obs)
    {
      f.display();
    }
    stroke(0);
    fill(255,0,0);
    text("Mutation Rate: W increase/Q decrease", 10, height -50);
    stroke(0);
    fill(0,67,255);
    text("Mutation Rate: P increase/O decrease", width - 250, height -50);
    fill(0);
    text("R to reset mutation rates",(width/2)-75,height -50);
    fill(0);
    text("V to shuffle obstacles",(width/2)-60,height - 75);
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
  boolean fhit;
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

  void run(int popC){
   if (!hit && !fhit)
   {
     applyForce( dna.genes[lifeCounter] );
     checkEdges();
     update();
   }
   display(popC);
  }


  void hitCheck(Target tar)
  {
     float d = dist(location.x, location.y, tar.loc.x, tar.loc.y);
    if (d < tar.radius/2) {
      hit = true;
    }

  }

 void hitCheck()
 {
   for (fluid f : obs)
   {
     float d = dist(location.x, location.y, f.loc.x, f.loc.y);
    if (d < f.radius/2) {
      fhit = true;
    }

   }

 }

   void checkEdges()
  {
    if (location.x > width){
      location.x = 0;
    }
    if (location.x < 0){
      location.x = width;
    }
    /*
    if ( location.y > height){
      location.y = 0;
    }
    if (location.y < 0)
    {
      location.y = height;
    }
    */
  }

  void display(int popC)
  {
    float theta = velocity.heading() + PI/2;
    if (popC == 0) fill(255,0,0);
    else fill(0,67,255);
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

   void fitnessR(Target tar)
  {
    float dist = PVector.dist(location,tar.loc);
    fitness = pow(1/dist,2);
    fitness = map(fitness, 0, 1, 0, 5);
    if(hit) fitness += 1000;
    if ( location.y > height/2 ){
      fitness -= pow(1/dist,2);
    }
    else if(fhit) fitness -= pow(1/dist,2);

  }
  /*
  void fitness(Target tar)
  {
    println("start");
    float dist = PVector.dist(location,tar.loc);
    println("dist:" + dist);
    fitness = pow(1/dist,2);
    if(hit) fitness = 1;
   // if(fhit) fitness -= 1;
    println("hit:" + hit);
    println("fhit:" + fhit);
     System.out.println("B map "+fitness);
    fitness = map(fitness, 0, 1, 0, 1);
    System.out.println("A map "+fitness);
  }
  */

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

Target(PVector w)
 {
   loc = w;
 }

  void display()
  {
    fill(0);
    text("Click/Tap to move",loc.x-50,loc.y+60);
    ellipse(loc.x,loc.y,radius,radius);
    text("Target",loc.x-20,loc.y+40);
  }

}
