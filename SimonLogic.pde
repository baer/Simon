String pwd = "123";
Boolean pwdVerified = false;

//How buttons are processed
void controlEvent(ControlEvent theEvent) {
  //'#' == return
  if (theEvent.controller().value() == '#') { 
    retFlag = true;
  }
  //'*' == backspace
  else if (theEvent.controller().value() == '*') {
    if (!keypad.equals("")) { message = message.substring(0,message.length()-1); }
    myTextarea.setText(message);
    if (!keypad.equals("")) { keypad = keypad.substring(0,keypad.length()-1); }
  }
  else {
    //Hide the text if still verifying password
    if (pwdVerified == false) { message = message + '*'; }
    else { message = message + Integer.toString(int(theEvent.controller().value())); }
    myTextarea.setText(message);
    keypad = keypad + Integer.toString(int(theEvent.controller().value()));
  }
}

void validatePwd() {
  if (getKeypad().equals("")) {
    setMessage("'ello Friend \n" + "Please enter your password: \n");
  }
  if (getRetFlag() == true) {
    if (getKeypad().equals(pwd)) {
      resetKeypad();
      pwdVerified = true;
      initCanvas = false;
    }
    else
  {resetKeypad();}
  }
}

void initCanvas() {
  if (getKeypad().equals("")) { setMessage("Width = "); }
  if (getRetFlag() == true) {
    initCanvas = true;
    drawCanvas(Integer.parseInt(getKeypad()));
    resetKeypad();
  }
}
