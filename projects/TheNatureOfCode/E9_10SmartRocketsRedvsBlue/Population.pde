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