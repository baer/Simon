//SimonGUI globals
import controlP5.*;
ControlP5 controlP5;
ControlWindow controlWindow;
Textarea myTextarea;

String message = "";
String keypad = "";

Boolean retFlag = false;
Boolean initCanvas = true;


void initGUI() {
  size(240,430);  
  frameRate(25);
  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);
  background(color(0));
  
  // Text Area
  myTextarea = controlP5.addTextarea(
  "Screen",message,36,20,168,96);
  myTextarea.setColorBackground(color(100));
  
  //Buttons
  int buttonMarginRight = 20;
  int buttonMarginLeft = 20;
  int buttonMarginTop = 146;
  int buttonWidth = 60;
  int buttonHeight = 60;
  int buttonMarginBottom = 20;
  controlP5.addButton("one",1,buttonMarginLeft,buttonMarginTop,buttonWidth,buttonHeight);
  controlP5.addButton("two",2,buttonMarginLeft+buttonWidth+10,buttonMarginTop,buttonWidth,buttonHeight);
  controlP5.addButton("three",3,buttonMarginLeft+(buttonWidth*2)+20,buttonMarginTop,buttonWidth,buttonHeight);
  controlP5.addButton("four",4,buttonMarginLeft,buttonMarginTop+buttonHeight+10,buttonWidth,buttonHeight);
  controlP5.addButton("five",5,buttonMarginLeft+buttonWidth+10,buttonMarginTop+buttonHeight+10,buttonWidth,buttonHeight);
  controlP5.addButton("six",6,buttonMarginLeft+(buttonWidth*2)+20,buttonMarginTop+buttonHeight+10,buttonWidth,buttonHeight);
  controlP5.addButton("seven",7,buttonMarginLeft,buttonMarginTop+(buttonHeight*2)+20,buttonWidth,buttonHeight);
  controlP5.addButton("eight",8,buttonMarginLeft+buttonWidth+10,buttonMarginTop+(buttonHeight*2)+20,buttonWidth,buttonHeight);
  controlP5.addButton("nine",9,buttonMarginLeft+(buttonWidth*2)+20,buttonMarginTop+(buttonHeight*2)+20,buttonWidth,buttonHeight);
  controlP5.addButton("star",'*',buttonMarginLeft,buttonMarginTop+(buttonHeight*3)+30,buttonWidth,buttonHeight);
  controlP5.addButton("zero",0, buttonMarginLeft+buttonWidth+10,buttonMarginTop+(buttonHeight*3)+30,buttonWidth,buttonHeight);
  controlP5.addButton("pound",'#',buttonMarginLeft+(buttonWidth*2)+20,buttonMarginTop+(buttonHeight*3)+30,buttonWidth,buttonHeight);
}

void drawCanvas(int width) {
  controlWindow = controlP5.addControlWindow("controlP5window",100,100,width,200);
  controlWindow.hideCoordinates();
  controlWindow.setBackground(color(40));
  controlWindow.setTitle("Canvas");
  initCanvas = true;
}
void clearKeypad() {
  keypad = "";
}
String getKeypad() {
  return keypad;
}
String getMessage() {
  return message;
}
boolean getRetFlag() {
  return retFlag;
}
void resetKeypad() {
  retFlag = false;
  keypad = "";
}
void setMessage(String newMessage) {
  message = newMessage;
  myTextarea.setText(message);
}
