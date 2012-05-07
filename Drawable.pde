/*
/*
This code is my Arduino port from Bill Ola Rasmussen's V-Plotter code on www.2e5.com
Thanks Bill!

Tension:  To be effective the control lines have to be in the range of [ m/2, m*1.5 ], where m is the mass of the plotter head. 
          Lines can neither be too slack nor too heavily loaded. The effect of this constraint is to prevent any line from being too close to horizontal or too close to vertical.
Resolution: There is a change in resolution when we map a change of length in one or both of the strings into X and Y coordinates. 
          I.e. Coordinate system conversion causes a non-uniform step resolution. We say that, for each control line, a one unit change causes at most a 1.4 unit change in the X,Y coordinate system. 
          We limit plotting to the area of reasonable resolution. Here our definition of reasonable is a 40% change.
*/

int canvasWidth=600;
int canvasHeight=600;
float backgroundColor = color(0);
float[] v1={1, 1};                //motor1
float[] v2={canvasWidth-1, 1};  //motor2

//Image variables
PImage canvas;
color lightBlue;
color darkBlue;
color orange;
color white;

void setup() {
  //configure non-embedded canvas, to be erased
  size(canvasWidth,canvasHeight);  
  frameRate(25);
  stroke(255);
  background(backgroundColor);
  
  lightBlue = color(58, 95, 189);
  darkBlue = color(72, 118, 255);
  orange = color(255, 127, 36);
  white = color(255, 255, 255);
  canvas = createImage(canvasWidth, canvasHeight, RGB);
  noLoop();
}

void draw(){
  canvas.loadPixels();
  drawValidArea();
  canvas.updatePixels();
  image(canvas, 0, 0);
  drawSVGArea();
}

//Return a pair of line tensions
float[] lineTensions(float angle1, float angle2) {
  float d=cos(angle1)*sin(angle2)+sin(angle1)*cos(angle2);
  float[] retVal = {cos(angle2)/d, cos(angle1)/d};
  return retVal;
}
//Tension check against above constraints
boolean tensionOk(float[] p) {
  //find angles
  float angle1=atan2(p[1]-v1[1], p[0]-v1[0]);
  float angle2=atan2(p[1]-v2[1], v2[0]-p[0]);
  
  //strings tension check
  float[] tensions = lineTensions(angle1,angle2);
  double hi = 1.5;
  double lo = .5;
  return (lo<tensions[0] && tensions[0]<hi) && (lo<tensions[1] && tensions[1]<hi);
}


float[] calcPointB(float a, float b, float c) {
  float alpha=acos((pow(b,2) + pow(c,2) - pow(a,2)) / (2*b*c));
  float[] retVal = {b*cos(alpha)+v1[0], b*sin(alpha)+v1[1]};
  return retVal;
}

float dx(float[] point1, float[] point2) {
  return sqrt(pow((point1[0]-point2[0]), 2) + pow((point1[1]-point2[1]), 2));
}

boolean resolutionOk(float[] p) {
  float max=1.4;
  //law of cosines calculation and nomenclature
  float c=dx(v1,v2);
  float b=dx(v1,p);
  float a=dx(v2,p);

  //calculate mapped differences
  float db=dx(p,calcPointB(a,b+1,c));    //extend left line by 1 unit
  float da=dx(p,calcPointB(a+1,b,c));    //extend right line by 1 unit
  return db<max && da<max;                 //line pull of 1 unit does not move x,y by more than max
}

//Calculate and draw each pixel based on the color code:
//  Orange: poor resolution
//  Light Blue: too little tension in one of the lines
//  Dark Blue: too much tension in one of the lines (and poor resolution)
//  White: drawing area candidate
void calcPixel(float[] p) {
  boolean t = tensionOk(p);
  boolean r = resolutionOk(p);
  //Light Blue = too little tension in one of the lines
  if (t==false && r==false) {
    // set(x, y, color) == pixels[y*width+x]
    canvas.pixels[(int)p[1]*canvasWidth+(int)p[0]] = lightBlue;
  }
  //Dark Blue = too much tension in one of the lines (and poor resolution)
  else if (t==false && r==true) {
    // set(x, y, color) == pixels[y*width+x]
    canvas.pixels[(int)p[1]*canvasWidth+(int)p[0]] = darkBlue;
  }
  //Orange = Poor Resolution
  else if (t==true && r==false) {
    // set(x, y, color) == pixels[y*width+x]
    canvas.pixels[(int)p[1]*canvasWidth+(int)p[0]] = orange;
  }
  //White = Drawable
  else if (true) {
    // set(x, y, color) == pixels[y*width+x]
    canvas.pixels[(int)p[1]*canvasWidth+(int)p[0]] = white;
  }
}

//Loop through image area and draw ze panties
void drawValidArea() {
  for (float y=0; y<(canvasHeight); y++) {
    for (float x=0; x<(canvasWidth); x++) {
      float[] p = {x, y};
      calcPixel(p);
    }
  }
}

//Find the largest possible drawing space given the canvas width and calculated drawable area
void drawSVGArea() {
  int xRatio = 50;
  int yRatio = 9;
  int locationColor = 0;
  
  //Find minimum y coordinate
  int minYPos = 0;
  do {
    locationColor = canvas.pixels[minYPos*canvasWidth+(canvasWidth/2)];
    minYPos++;
  } while(locationColor != color(white));
    
  //Expand x given the ratio until invalid
  int maxYPos = minYPos;
  int maxXPos = 0;
  do {
    maxYPos+=yRatio;
    maxXPos+=xRatio;
    locationColor = canvas.get((canvasWidth/2)-(maxXPos),(maxYPos+yRatio));
  } while(locationColor == color(white) && maxYPos < canvasHeight);
  
  //-------------------------------------------------------------------------------------
  stroke(orange);
  rect((canvasWidth/2)-(maxXPos/2), minYPos, maxXPos, maxYPos);
  //-------------------------------------------------------------------------------------
}
*/
