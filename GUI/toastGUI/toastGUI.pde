/*  GUI for the Toaster Printer
*   Andrew Elsey, Kenny Groszman
*   To run on the Raspberry Pi Display
*/
import java.util.List; 
import java.io.PrintWriter;
PFont buttonfont; 
PFont numberfont;
PImage img;
PrintWriter pathfile;
String imagefilepath;




// Twitter stuff
static String OAuthConsumerKey = "0Tmzx9UE87VeBZBUO7opb1LrL";
static String OAuthConsumerSecret = "lVXCemEC2OcUnEOb37dyfGl4bSNHeaRLbSZrRDZqK4LOGFwCP8";
static String AccessToken = "1636426622-R16coyljuFLDlJwPfGBqlsEWR1jbEXtXZJQa6C8";
static String AccessTokenSecret = "0XUKsVDrAFIHXo8ksmt8lQkr3tbT4KW1ufMeUQjD6hcwc";
TwitterStream twitter = new TwitterStreamFactory().getInstance(); 



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

// Adjust Arrow Coordinates (oh my god this is so annoying I'll do it later)


// Cancel Button
int cancelX = (int)(0.80*display_width);
int cancelY = (int)(0.05*display_width);
int cancelL = (int)(0.15*display_width);

// Mode 1 Setting Buttons
int[] settingcolor = {240,90,75};  //fix this eventually
int m1sX = modeX1;
int m1sL  = (int)(0.90*display_width);
int m1sY1  = (int)(0.16*display_height);
int m1sY2  = (int)(0.24*display_height);
int m1sH  = (int)(0.06*display_height);
String[] m1sText = {"Take a selfie!", "Choose an image from file..."};

// Mode 2 Buttons
int m2sX1 = modeX1;
int m2sX2 = modeX2;
int m2sL = modeL;
int m2sY1 = m1sY1;
int m2sY2 = m1sY2;
int m2sH = m1sH;
String[] m2sText = {"News", "Weather", "Quote", "Tweet"};


// initialize functions to store button states
boolean mode1B = false; 
boolean mode2B = false; 
boolean nowB = false;
boolean laterB = false;
boolean adjustHUB = false;  // hours up
boolean adjustHDB = false;  // hours down
boolean adjustMUB = false;  // minutes up
boolean adjustMDB = false;  // minutes down
boolean m1s1B = false;
boolean m1s2B = false;
boolean m2s1B = false;
boolean m2s2B = false;
boolean m2s3B = false;
boolean m2s4B = false;
boolean cancelB = false;
int hour = 0;  //store scheduled hour
int minute = 0;  // store scheduled minute

int toastmode = 0;  //MODES: 0 = wait for mode selection, 1 = toast from image, 2 = toast from data, 3 = toasting animation

void setup() {
  //fullScreen();
  size(480, 800);
  buttonfont = createFont("Garamond", 24);
  numberfont = createFont("Garamond", 48);
  toastmode = 0; //start by asking what the user would like to toast
  connectTwitter();
  //twitter.addListener(listener);
  pathfile = createWriter("image_path.txt");
  pathfile.println("maneatingcarrot.jpg");
  pathfile.flush();
  pathfile.close();
}

void draw() {
  checkButtons(mouseX,mouseY);
  //rotate(HALF_PI);
  //translate(0,-width);
  background(backgroundcolor[0], backgroundcolor[1], backgroundcolor[2]);
  stroke(0);
  if (toastmode !=3)
  {
    fill(modecolor[0], modecolor[1], modecolor[2]);
    rect(modeX1, modeY, modeL, modeH, cornerrad);
    rect(modeX2, modeY, modeL, modeH, cornerrad);
  }
  
  if (toastmode != 0){
    String[] filepatharray= loadStrings("image_path.txt");
    imagefilepath = filepatharray[0];
    img = loadImage(imagefilepath);
    image(img, imageX, imageY, imageL, imageL);
  }
  
  if (toastmode == 1 || toastmode == 2)
  {
    fill(nowcolor[0], nowcolor[1], nowcolor[2]);
    ellipse(nowX, nowY, nowL, nowL);
  
    fill(latercolor[0], latercolor[1], latercolor[2]);
    ellipse(laterX, laterY, laterL, laterL);
    rect(timeX, timeY, timeL, timeH, cornerrad);
  }
  if (toastmode == 1)
  {
    fill(settingcolor[0], settingcolor[1], settingcolor[2]);
    rect(m1sX, m1sY1, m1sL, m1sH, cornerrad);
    rect(m1sX, m1sY2, m1sL, m1sH, cornerrad);
  }
  if (toastmode == 2)
  {
    fill(settingcolor[0], settingcolor[1], settingcolor[2]);
    rect(m2sX1, m2sY1, m2sL, m2sH, cornerrad);
    rect(m2sX1, m2sY2, m2sL, m2sH, cornerrad);
    rect(m2sX2, m2sY1, m2sL, m2sH, cornerrad);
    rect(m2sX2, m2sY2, m2sL, m2sH, cornerrad);
  }
  if (toastmode == 3)
  {
    fill(settingcolor[0], settingcolor[1], settingcolor[2]);
    rect(cancelX, cancelY, cancelL, cancelL, 0);
  }
  drawtext();
}

void drawtext()
{
  textFont(buttonfont);
  textAlign(CENTER);
  fill(255);
  if (toastmode != 3)
  {
    text("Toast from image...",(int)(modeX1+modeL/2),(int)(modeY+modeH/2+8));
    text("Toast from data",(int)(modeX2+modeL/2),(int)(modeY+modeH/2+8));
    if (toastmode != 0)
    {
      text("TOAST\nNOW",nowX,nowY-5);
      text("TOAST\nAT:",laterX,laterY-5);
      
      textFont(numberfont);
      text(printtime(hour), adjustX1+adjustL/2,adjustY1+adjustH+14);
      text(printtime(minute), adjustX2+adjustL/2,adjustY1+adjustH+14);
    }
  }
  textFont(buttonfont);
  if (toastmode == 1)
  {
    text(m1sText[0],(int)(display_width/2),m1sY1+m1sH/2+6);
    text(m1sText[1],(int)(display_width/2),m1sY2+m1sH/2+6);
  }
  if (toastmode == 2)
  {
    text(m2sText[0],m2sX1+m2sL/2,m2sY1+m1sH/2+6);
    text(m2sText[1],m2sX2+m2sL/2,m2sY1+m1sH/2+6);
    text(m2sText[2],m2sX1+m2sL/2,m2sY2+m1sH/2+6);
    text(m2sText[3],m2sX2+m2sL/2,m2sY2+m1sH/2+6);
  }
  if (toastmode == 3)
  {
    textFont(numberfont);
    text("X",cancelX+cancelL/2,cancelY+cancelL/2+12);
    textFont(buttonfont);
  }
}

void checkButtons(int x, int y) {
  if (overRect(modeX1,modeY,modeL,modeH)) 
  {
    mode1B = true;
  }
  else if (overRect(modeX2,modeY,modeL,modeH) && toastmode != 3) 
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
  else if (overRect(m1sX,m1sY1,m1sL,m1sH) && toastmode == 1)
  {
    m1s1B = true;
  }
  else if (overRect(m1sX,m1sY2,m1sL,m1sH) && toastmode == 1)
  {
    m1s2B = true;
  }
  else if (overRect(m2sX1,m2sY1,m2sL,m2sH) && toastmode == 2)
  {
    m2s1B = true;
  }
  else if (overRect(m2sX2,m2sY1,m2sL,m2sH) && toastmode == 2)
  {
    m2s2B = true;
  }
  else if (overRect(m2sX1,m2sY2,m2sL,m2sH) && toastmode == 2)
  {
    m2s3B = true;
  }
  else if (overRect(m2sX2,m2sY2,m2sL,m2sH) && toastmode == 2)
  {
    m2s4B = true;
  }
  else if(overRect(cancelX,cancelY,cancelL,cancelL) && toastmode==3)
  {
    cancelB = true;
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
    m1s1B = false; 
    m1s2B = false;
    m2s1B = false;
    m2s2B = false;
    m2s3B = false;
    m2s4B = false;  
    cancelB = false;
  }
}

void mousePressed() {
  if (toastmode != 3)
  {
    if(mode1B)
    {
      toastmode = 1;
      println("Toast from image button pressed!");
    }
    else if(mode2B) 
    {
      toastmode = 2;
      println("Toast from data button pressed!");
    }
  }
  if (toastmode == 1 || toastmode == 2)  //only able to interact with these buttons when they exist
  {
    if(nowB)
    {
      toastmode = 3;
      println("TOAST NOW button pressed!");
      launch("python upload_image2.py");
    }
    else if(laterB) 
    {
      toastmode = 3;
      println("TOAST LATER button pressed!");
    }
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
  
  if(toastmode == 1)
  {
    if(m1s1B)
    {
      println(m1sText[0] + " button pressed!");
      exec("/home/pi/421_521_final_project/GUI/selfie/takeselfie.sh");
      imagefilepath = "/home/pi/421_521_final_project/GUI/selfie/selfie.jpg";
      redraw();
    }
    if(m1s2B)
    {
      println(m1sText[1] + " button pressed!");
      selectInput("Select a file to process:", "fileSelected");
      redraw();
    }
  }
  
  if(toastmode == 2)
  {
    if(m2s1B)
    {
      println(m2sText[0] + " button pressed!");  // news
    }
    if(m2s2B)
    {
      println(m2sText[1] + " button pressed!");  // weather
    }
    if(m2s3B)
    {
      println(m2sText[2] + " button pressed!");  // quote
    }
    if(m2s4B)
    {
      println(m2sText[3] + " button pressed!");  // tweet
    }
  }
  
  if (toastmode ==3)
  {
    if (cancelB)
    {
      toastmode = 0;
      println("Cancel button pressed! Returning to main screen. ");
    }
  }
}

// Sense if the mouse is over a button, from Button example code
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

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String filepath = selection.getAbsolutePath();
    println("User selected " + filepath); 
    pathfile = createWriter("image_path.txt");
    pathfile.println(filepath);
    pathfile.flush();
    pathfile.close();
  }
}


// Initial connection
void connectTwitter() {
//twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
AccessToken accessToken = loadAccessToken();
twitter.setOAuthAccessToken(accessToken);
}
// Loading up the access token
private static AccessToken loadAccessToken() {
return new AccessToken(AccessToken, AccessTokenSecret);
}

// This listens for new tweet
StatusListener listener = new StatusListener() {
  public void onStatus(Status status) {
    
  }
  public void onStallWarning(StallWarning stallwarning){}
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
  public void onScrubGeo(long userId, long upToStatusId) {
  System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
};