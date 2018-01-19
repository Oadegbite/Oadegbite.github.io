int[]  blocks;
int sortSize;
int pixWidth;
int swaps;
boolean running;
boolean clicked;
boolean done;
void setup(){
  pixWidth = 25;
  size(550,200);
  sortSize = width;
  blocks = new int[sortSize];
  create();
  swaps = 0;
  running = false;
  clicked = false;
  done = false;
}

void draw(){
  background(255);
  fill(0);
  if (done) text("Click to restart", 5, 40);
  display(blocks);
  if (!running)
  {
    //thread("insertionSort"); 
    thread("bubbleSort"); 
  }
}

  void display(int arr[])
  {
    fill(0);
    for(int i = 0; i < arr.length; i++)
    {
      line(i,height,i,height-arr[i]); // draw a from botton towards top of screen depending on number at i each index of i representing a pixel across the x-axis
    } 
    text("Swaps: " + swaps, 5, 20); 
  }

 void swap(int[] arr, int f, int s)
  {
    int temp = arr[f];
     arr[f] = arr[s];
     arr[s] = temp;
     swaps++;
  }
  
void insertionSort()
{
   running = true;
   fill(0);
   for(int i = 1; i < blocks.length; i++)
     {
       if(clicked) return;
       println("I:"+i);
       for(int j = i; j > 0 && (blocks[j-1] > blocks[j]); j--)
       {   
        if(clicked) return;
         swap(blocks,j,j-1);
         redraw();
         delay(1);
         }        
       }
   done = true;  
}
     
void bubbleSort()
{
     running = true;
     done = false;
     while(!done) 
     {
       boolean swapped = false;
         for(int i = 0; i < blocks.length-1; i++)
         {
           if(blocks[i] >blocks[i+1]) // If block to the right is less then current swap 
           {
             swap(blocks, i, i+1);
             swapped = true;
             redraw();
             delay(1);
           }
          
         }
          if( !swapped ) done = true;
     }
     done = true;
}     

void create()
{
  for(int i = 0; i < sortSize; i++)
  {
    blocks[i] = int(random(0,height)); // fill random ints from 0 to height in an array each index represnting a pixel on the y-axis.
  }
}

void mergeSort(int[] array)
{
  text("Merge Sort", 5, 20); 
 
}


void heapSort()
{
  
}




void mousePressed() {
  if (done){
  clicked = true;
  setup();
  }
}