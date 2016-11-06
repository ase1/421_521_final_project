/*  GUI for the Toaster Printer
*   Andrew Elsey, Kenny Groszman
*   To run on the Raspberry Pi Display
*/
PFont buttonfont; 
PFont numberfont;
PImage img;

// VARIABLES
// Display size
int display_width = 480;
int display_height = 800;
int[] backgroundcolor = {255, 204, 204};
int cornerrad = 15; //corner radius of the buttons

// Mode Buttons
int[] modecolor = {91,155,213};
int modeX1 = (int)(0.05*display_width);
int modeX2 = (int)(0.55*display_width);
int modeL  = (int)(0.40*display_width);
int modeY  = (int)(0.03*display_height);
int modeH  = (int)(0.10*display_height);

// Image
int imageX = (int)(0.10*display_width);
int imageY = (int)(0.34*display_height);
int imageL = (int)(0.80*display_width);

// Toast Now Button
int[] nowcolor = {112,173,71};
int nowX = (int)(0.15*display_width);
int nowY = (int)(0.91*display_height);
int nowL = (int)(0.20*display_width);

// Toast Later Button
int[] latercolor = {255,192,0};
int laterX = (int)(0.40*display_width);
int laterY = nowY;
int laterL = nowL;

// Later Time Buttons
int timeX = (int)(0.55*display_width);
int timeY = (int)(0.85*display_height);
int timeL = (int)(0.40*display_width);
int timeH = laterL; 

// Bounding Boxes for Adjust Arrows
int adjustL = (int)(0.5*timeL);
int adjustH = (int)(0.5*timeH);
int adjustX1 = timeX;
int adjustX2 = adjustX1+adjustL;
int adjustY1 = timeY;
int adjustY2 = adjustY1+adjustH;

// Adjust Arrow Coordinates (oh my god this is so annoying)


// initialize functions to store button states
boolean mode1B = false; 
boolean mode2B = false; 
boolean nowB = false;
boolean laterB = false;
boolean adjustHUB = false;  // hours up
boolean adjustHDB = false;  // hours down
boolean adjustMUB = false;  // minutes up
boolean adjustMDB = false;  // minutes down
int hour = 0;  //store scheduled hour
int minute = 0;  // store scheduled minute


void setup() {
  //fullScreen();
  size(480, 800);
  img = loadImage("maneatingcarrot.jpg");
  buttonfont = createFont("Garamond", 24);
  numberfont = createFont("Garamond", 48);
}

void draw() {
  checkButtons(mouseX,mouseY);
  background(backgroundcolor[0], backgroundcolor[1], backgroundcolor[2]);
  stroke(0);
  fill(modecolor[0], modecolor[1], modecolor[2]);
  rect(modeX1, modeY, modeL, modeH, cornerrad);
  rect(modeX2, modeY, modeL, modeH, cornerrad);
  
  image(img, imageX, imageY, imageL, imageL);
  
  fill(nowcolor[0], nowcolor[1], nowcolor[2]);
  ellipse(nowX, nowY, nowL, nowL);
  
  fill(latercolor[0], latercolor[1], latercolor[2]);
  ellipse(laterX, laterY, laterL, laterL);
  rect(timeX, timeY, timeL, timeH, cornerrad);
  drawtext();
}

void drawtext()
{
  textFont(buttonfont);
  textAlign(CENTER);
  fill(255);
  text("Toast from image...",(int)(modeX1+modeL/2),(int)(modeY+modeH/2+8));
  text("Toast from data",(int)(modeX2+modeL/2),(int)(modeY+modeH/2+8));
  text("TOAST\nNOW",nowX,nowY-5);
  text("TOAST\nAT:",laterX,laterY-5);
  
  textFont(numberfont);
  text(printtime(hour), adjustX1+adjustL/2,adjustY1+adjustH+14);
  text(printtime(minute), adjustX2+adjustL/2,adjustY1+adjustH+14);
}

void checkButtons(int x, int y) {
  if (overRect(modeX1,modeY,modeL,modeH)) 
  {
    mode1B = true;
  }
  else if (overRect(modeX2,modeY,modeL,modeH)) 
  {
    mode2B = true;
  }
  else if (overCircle(nowX,nowY,nowL))
  {
    nowB = true;
  }
  else if (overCircle(laterX,laterY,laterL))
  {
    laterB = true;
  }
  else if (overRect(adjustX1,adjustY1,adjustL,adjustH)) 
  {
    adjustHUB = true;
  }
  else if (overRect(adjustX1,adjustY2,adjustL,adjustH)) 
  {
    adjustHDB = true;
  }
  else if (overRect(adjustX2,adjustY1,adjustL,adjustH)) 
  {
    adjustMUB = true;
  }
  else if (overRect(adjustX2,adjustY2,adjustL,adjustH)) 
  {
    adjustMDB = true;
  }
  else {
    mode1B = false;
    mode2B = false; 
    nowB = false;
    laterB = false; 
    adjustHUB = false; 
    adjustHDB = false; 
    adjustMUB = false; 
    adjustMDB = false; 
  }
}

void mousePressed() {
  if(mode1B) println("Mode Button 1 pressed!");
  else if(mode2B) println("Mode Button 2 pressed!");
  else if(nowB) println("Print Now Button pressed!");
  else if(laterB) println("Print Later Button pressed!");
  else if(adjustHUB)
  {
    hour++;
    if (hour>23) hour=0;
    println("Hour up button pressed! Current time: " + printtime(hour) + ":" + printtime(minute));
    redraw();
  }
  else if(adjustHDB)
  {
    hour--;
    if(hour<0) hour=23;
    println("Hour down button pressed! Current time: " + printtime(hour) + ":" + printtime(minute));
    redraw();
  }
  else if(adjustMUB)
  {
    minute++;
    if (minute>59)
    {
      minute = 0;
      hour++;
      if (hour>23) hour=0;
    }
    println("Minute up button pressed! Current time: " + printtime(hour) + ":" + printtime(minute));
    redraw();
  }
  else if(adjustMDB)
  {
    minute--;
    if (minute<0)
    {
      minute=59;
      hour--;
      if (hour<0) hour=23;
    }
    println("Minute down button pressed! Current time: " + printtime(hour) + ":" + printtime(minute));
    redraw();
  }
}

// sense if the mouse is over a button, from Button example code
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

String printtime(int time)
{
  if (time<10) return ("0"+time);
  else return (""+time);
}