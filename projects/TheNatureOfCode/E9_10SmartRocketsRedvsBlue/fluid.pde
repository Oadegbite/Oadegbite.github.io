class fluid
{
   PVector loc;
 float radius;
 float c;
 
 fluid(PVector w)
 {
   loc = w;
   radius = random(100,200);
 }

  void display()
  {
    fill(74, 247, 17,30);
    ellipse(loc.x,loc.y,radius,radius);
    text("obstacle", loc.x, loc.y);
  }
 
  boolean collsionCheck(Target l2)
  {
    float d = dist(l2.loc.x, l2.loc.y, loc.x, loc.y);
     if (d < l2.radius) {
      return true;
    } 
    return false;
  }
  
}