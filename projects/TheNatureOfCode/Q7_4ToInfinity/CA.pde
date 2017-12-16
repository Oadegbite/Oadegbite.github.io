class CA {
  int[] cells;
  int[] ruleset;
  int w = 10;
  ArrayList<int[]> gens;
  // The CA should keep track of how
  // many generations.
  int generation = 0;
  int gen;
  CA() {
    cells = new int[width/w];
    ruleset = new int[]{0,1,0,1,1,0,1,0};
    cells[cells.length/2] = 1;
    gens = new ArrayList<int[]>();
    gens.add(cells);

  }

  void newRules()
  {
    int[] newRules = new int[ruleset.length];
    for (int i = 0; i < newRules.length; i++)
    {
      newRules[i] = (int)random(0,2);
    }
    ruleset = newRules;
  }

  // Function to compute the next generation
  void generate() {
    
    int[] nextgen = new int[cells.length];
    for (int i = 1; i < cells.length-1; i++) {
      int left   = cells[i-1];
      int me     = cells[i];
      int right  = cells[i+1];
      nextgen[i] = rules(left, me, right);
    }
    cells = nextgen;
    
    
   for (int i = 0; i < gens.size(); i++)
   {
     int[] c = gens.get(i);
     gen = gens.indexOf(c);
     display3(c, gen);
     
   }

 // display();
    
    gens.add(cells);
 
    
    if (gens.size()*w >= height) 
    {
      Iterator it = gens.iterator();
      it.next();
    it.remove();
    }
   
  }

  int rules(int a, int b, int c) {
    String s = "" + a + b + c;
    int index = Integer.parseInt(s,2);
    return ruleset[index];
  }
  
void display3(int [] c, int h){
  
  for (int i = 0; i < c.length; i++) {
    if (c[i] == 1) fill(0,30,204);
    else               fill(255);
    // Set the y-location according to the generation.
    ellipse(i*w, (h)*w, w, w);
    
  }
  
  
}


void display(){
  
  for (int j = 0; j < gens.size()-1; j++){
  
    int[] c = gens.get(j);
    int gen = gens.indexOf(c);
    
  for (int i = 0; i < c.length; i++) {
    if (cells[i] == 1) fill(0,30,204);
    else               fill(255);
    // Set the y-location according to the generation.
    ellipse(i*w, (gen)*w, w, w);
    
  }
  
  }
}


void display2(){
  
  for (int i = 0; i < cells.length; i++) {
    if (cells[i] == 1) 
    {
      strokeWeight(5);
      strokeCap(ROUND);
      strokeJoin(MITER);
      stroke(random(255),random(255),random(255));
    }
    else
    {
      strokeWeight(2);
       stroke(255,0,0);
      strokeCap(SQUARE);
    }
    // Set the y-location according to the generation.
   line((i*cells[i])*w, generation*w, (i*cells[i])*w, generation*w);
    
  }
}


}