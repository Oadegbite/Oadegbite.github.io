Target target;
Population saber;
Population saber2;
//fluid f;
int lifetime = 300;
int lifeCounter;

void setup()
{
  size(780,900);
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
  
  if (keyPressed)
    {
      if (key == 'q' || key =='Q'){
        saber.mutuationRate += -0.01;
      }
      if (key == 'W' || key =='w'){
        saber.mutuationRate += 0.01;
      }
      if (key == 'o' || key =='O'){
        saber2.mutuationRate += -0.01;
      }
      if (key == 'P' || key =='p'){
        saber2.mutuationRate += 0.01;
      }
      if (key == 'R' || key =='r'){
        saber.mutuationRate = 0.01;
        saber2.mutuationRate = 0.01;
      }
    }
  
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
  stroke(0);
   fill(255,0,0);
   text("Mutation Rate: Q increase/W decrease", 10, 50);
   stroke(0);
   fill(0,67,255);
   text("Mutation Rate: Q increase/W decrease", width - 180, 20);
   fill(0);
   text("R to reset mutation rates",(width/2)-75,height -50);
}

void mousePressed() {
  target.loc.x = mouseX;
  target.loc.y = mouseY;
}