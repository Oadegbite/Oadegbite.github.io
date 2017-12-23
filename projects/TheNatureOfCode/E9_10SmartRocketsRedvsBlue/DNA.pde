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