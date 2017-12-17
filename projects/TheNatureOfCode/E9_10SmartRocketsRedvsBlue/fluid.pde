class fluid{
 float x,y,w,h; //x,y coordiantes width and height
 float c; //drag coefficient 
 
 fluid(float x_, float y_, float w_, float h_, float c_){
   x = x_;
   y = y_;
   w = w_;
   h = h_;
   c = c_;
 }
 
 void display() {
    noStroke();
    fill(175);
    ellipse(x,y,w,h);
  }
}