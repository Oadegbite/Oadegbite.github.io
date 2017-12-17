class Target
{
 PVector loc;
 float radius;
 
 Target(PVector w, float r)
 {
   loc = w;
   radius = r;
 }

  void display()
  {
    fill(0);
    ellipse(loc.x,loc.y,radius,radius);
  }
  
}