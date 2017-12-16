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