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