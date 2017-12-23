Target target;
Population saber;
Population saber2;
fluid[] obs;
//fluid f;
int lifetime = 400;
int lifeCounter;

void setup()
{
  size(780,900);
  lifeCounter = 0;
  target = new Target(new PVector(width/2,50), 50);
  //lifetime = 300;
  saber = new Population(15, target,0);
  saber2 = new Population(15, target,1);
  //f = new fluid(width/2,height/2, 50,50,0.1);
  obs = new fluid[8];
 
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
  
  for (fluid f : obs)
  {
  f.display();
  }
 if (lifeCounter < lifetime) 
 {
   saber.run(obs);
   saber2.run(obs);
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
   text("Mutation Rate: Q increase/W decrease", 10, height -50);
   stroke(0);
   fill(0,67,255);
   text("Mutation Rate: Q increase/W decrease", width - 250, height -50);
   fill(0);
   text("R to reset mutation rates",(width/2)-75,height -50);
   fill(0);
   text("V to shuffle obstacles",(width/2)-60,height - 75);
}

void mousePressed() {
  target.loc.x = mouseX;
  target.loc.y = mouseY;
}