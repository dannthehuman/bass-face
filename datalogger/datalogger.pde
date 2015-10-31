import processing.serial.*;

Serial myPort;
String val;
int interval = 0;
int lf = 10;

void setup()
{
  printArray(Serial.list());
  String portName = "COM4";
  myPort = new Serial(this, portName, 1152000);
  myPort.write('r');
  
}

void draw()
{
  if (millis() - interval > 1000) {
    //resend single character to trigger DMP init/start
    // in case the MPU is halted/reset while applet is running
    myPort.write('r');
    interval = millis();
  }
  
  while (myPort.available() > 0) {
    int ch = myPort.read();
    print((char)ch);
//    if (inBuffer != null){
//      println(inBuffer);
//    }
  }
}


