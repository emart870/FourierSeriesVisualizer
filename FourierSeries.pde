import java.util.*;

float time = 0;
Deque<Float> wave = new ArrayDeque<Float>();

PGraphics canvas;

void setup() 
{
  size(1500, 800);
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}


void draw() 
{
  image(canvas, 0, 0);
  translate(width/3, height/2);
  
  //Number of epicircels
  int numCircles = 1;
  
  //Various variables needed
  float x = 0, y = 0, r = 0, prevX, prevY, prevR;
  float wavePlace = 0;
  
  //The main for loop
  for(int i = 1; i <= numCircles; i++)
  {
    prevX = x;
    prevY = y;
    prevR = r;
    
    //Calculating the coefficient for the Fourier Series
    FourierCoef CoefCalc = new FourierCoef();
    
    //CoefCalc functions returns a float array with 2 values
    //values[0] = n and values[1] = coef
    float[] values = CoefCalc.square(i);
    
    int n = (int) values[0]; 
    float coef = values[1];
    
    if(n > 0)
    {
      wavePlace = -numCircles*3;
    }
    else
    {
      wavePlace = numCircles*3;
    }
    
    
    
    //Scaling the radius of each circle to fit on the screen
    r = (0.3 * Math.min(width, height) * coef);
    
    //moving the circles 
    translate(-prevR * wavePlace, 0);
    
    //Drawing the circle
    stroke(255);
    noFill();
    circle(prevX, prevY, r*2);
    
    
    //Moving to the end of the circle's radius to start calculating the next circle
    x += (float) (r * cos(n * time));
    y += (float) (r * sin(n * time));
    
    fill(255);
    //Drawing the radius of the circle
    line(prevX, prevY, x, y);
    //Drawing the center of the circle
    ellipse(x,y,8,8);
    
    //moivng the circles back
    translate(r * wavePlace, 0);
  }
  
  
  translate(-r * wavePlace, 0);
  wave.addFirst(y);
  
  int curveOffset = 500;
  line(x, y, curveOffset, wave.peek());
  
  beginShape();
  int index = 0;
  noFill();
  for(float f : wave)
  {
    vertex(curveOffset + index, f);
    index++;
  }
  endShape();
  
  while(wave.size() > 500)
  {
    wave.removeLast();
  }
  
  time += .01;
}
