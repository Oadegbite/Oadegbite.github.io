class Target
{
 PVector loc;
 float radius;
 
 Target(PVector w, float r)
 {
   loc = w;
   radius = r;
 }

Target(PVector w)
 {
   loc = w;
 }

  void display()
  {
    fill(0);
    text("Click/Tap to move",loc.x-50,loc.y+60);
    ellipse(loc.x,loc.y,radius,radius);
    text("Target",loc.x-20,loc.y+40);
  }
  
}