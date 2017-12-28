int lifetime = 350;
int lifeCounter;
fluid[] obs;
Target target;

RedVBlue redvblue;


void setup()
{
  size(780,900);
  lifeCounter = 0;
  lifetime = 300;
  redvblue = new RedVBlue();
}
   
void draw()
{
  
  background(255);
  redvblue.run();
  redvblue.display();
}

void mousePressed() {
  target.loc.x = mouseX;
  target.loc.y = mouseY;
}