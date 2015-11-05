import processing.serial.*;

Serial myPort;
String val = null;
int interval = 0;
int lf = 10;
PrintWriter output;
int i = 0;

void setup()
{
  printArray(Serial.list());
  String portName = "COM4";
  myPort = new Serial(this, portName, 115200);
  myPort.write('r');
  output = createWriter("values.csv");
  println("Testing...");
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  val = myPort.readStringUntil(lf);
  val = null;
  output.println("Time,X,Y,Z");
  //delay(20);  //Get rid of junk repeated values in the beginning
}

void draw()
{
  if (millis() - interval > 1000) {
   //resend single character to trigger DMP init/start
   // in case the MPU is halted/reset while applet is running
   myPort.write('r');
   interval = millis();
  }
  //println("Going...");
  
  while (myPort.available() > 0) {
    val = myPort.readStringUntil(lf);         // read it and store it in val
  }
  if (val != null)
  {
    output.print(i);
    output.print(",");
    output.print(val);   // Just print, the lf is included in the string
    i += 1;
    print(val);
  }
}

void keyPressed()
{
  output.flush();
  output.close();
  exit();
}