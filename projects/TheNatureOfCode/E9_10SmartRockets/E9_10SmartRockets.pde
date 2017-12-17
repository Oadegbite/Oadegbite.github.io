Target target;
Population saber;
Population saber2;
fluid f;
int lifetime = 300;
int lifeCounter;

void setup()
{
  size(780,580);
  lifeCounter = 0;
  target = new Target(new PVector(width/2,50), 20);
  lifetime = 300;
  saber = new Population(50, target,0);
  saber2 = new Population(50, target,1);
  f = new fluid(width/2,height/2, 50,50,0.1);
 
}

void draw()
{
  background(255);
  target.display();
  saber.display();
  saber2.display();
  f.display();
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