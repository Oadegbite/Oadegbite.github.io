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