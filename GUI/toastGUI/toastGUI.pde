/*  GUI for the Toaster Printer
*   Andrew Elsey, Kenny Groszman
*   To run on the Raspberry Pi Display
*/

// VARIABLES
// Display size
int display_width = 480;
int display_height = 800;
int[] backgroundcolor = {255, 204, 204};
int cornerrad = 8; //corner radius of the buttons

// Mode Buttons
int[] modecolor = {91,155,213};
int modeX1 = (int)(0.05*display_width);
int modeX2 = (int)(0.55*display_width);
int modeL  = (int)(0.40*display_width);
int modeY  = (int)(0.03*display_height);
int modeH  = (int)(0.10*display_height);

// Image
// filling this with a gray square for now
int[] imagecolor = {100,100,100};
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
int laterY = (int)(0.91*display_height);
int laterL = (int)(0.20*display_width);

// Later Time Buttons
int timeX = (int)(0.55*display_width);
int timeY = (int)(0.85*display_height);
int timeL = (int)(0.40*display_width);
int timeH = laterL; 

void setup() {
  size(480, 800);
}

void draw() {
  background(backgroundcolor[0], backgroundcolor[1], backgroundcolor[2]);
  stroke(0);
  fill(modecolor[0], modecolor[1], modecolor[2]);
  rect(modeX1, modeY, modeL, modeH, cornerrad);
  rect(modeX2, modeY, modeL, modeH, cornerrad);
  
  fill(imagecolor[0], imagecolor[1], imagecolor[2]);
  rect(imageX, imageY, imageL, imageL);
  
  fill(nowcolor[0], nowcolor[1], nowcolor[2]);
  ellipse(nowX, nowY, nowL, nowL);
  
  fill(latercolor[0], latercolor[1], latercolor[2]);
  ellipse(laterX, laterY, laterL, laterL);
  rect(timeX, timeY, timeL, timeH, cornerrad);
  
}