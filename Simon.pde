/*
The Simon Drawing Robot
Written by: Eric Baer
2/2/11
*/

boolean initialized = false;

void setup() {
  initGUI();
}

void draw(){
  controlP5.draw();
  if (!initialized) {
    if (!pwdVerified) { validatePwd(); }
    else if (!initCanvas) { initCanvas(); }
    if (pwdVerified && initCanvas) { initialized = true; }
  }
  else { println("oh yea!"); }
}
