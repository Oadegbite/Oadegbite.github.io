class Population
{
 float mutuationRate = 0.01;
 Rocket[] population;
 ArrayList<Rocket> matingPool;
 PVector origin;
 float popFit;
 int generation;
 int popC; //for population color 0 = red, 1 = blue
 Target target; 
  
 Population(int popSize, Target tar, int popC_)
 {
   population = new Rocket[popSize];
   origin = new PVector(width/2,height - 20);
   matingPool = new ArrayList<Rocket>();
   target = tar;
   popC = popC_;
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
 }
 
 }
 
}