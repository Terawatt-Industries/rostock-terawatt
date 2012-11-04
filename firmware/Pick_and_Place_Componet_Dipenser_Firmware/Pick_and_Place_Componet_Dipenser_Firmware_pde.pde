// Utlitimaker Pick and Place Componet Dispenser Firmware
// by Caleb Cotter 

#include <SoftwareServo.h>

SoftwareServo servo1;  // create servo object to control servo 1 
SoftwareServo servo2;  // create servo object to control servo 2
SoftwareServo servo3;  // create servo object to control servo 3
SoftwareServo servo4;  // create servo object to control servo 4
int incomingByte; // variable to store the the incoming value from the serial port 
int pos1 = 0;  // a set variable that sets the minimum degree for all servos
int pos2 = 90; // a set variable that sets the maximum degree for all servos

void setup()
{ 
  servo1.attach(2);  // attaches the servo on pin 2 to the servo object 
  servo2.attach(3);  // attaches the servo on pin 3 to the servo object
  servo3.attach(4);  // attaches the servo on pin 4 to the servo object
  servo4.attach(5);  // attaches the servo on pin 5 to the servo object
  Serial.begin(9600);  // begins serial connection to the Motherboard at 9600 baud
  servo1.write(pos1);     // set servo1 to position pos1 which is 0
  servo2.write(pos1);     // set servo2 to position pos1 which is 0
  servo3.write(pos1);     // set servo3 to position pos1 which is 0
  servo4.write(pos1);     // set servo4 to position pos1 which is 0
} 
 
void loop() 
{ 
  if (Serial.available() > 0) { // check incoming serial data
    
    incomingByte = Serial.read(); // store the incoming byte in the variable incomingByte
    
    if (incomingByte == '1') {    // if byte stored is == 1 then
        servo1.write(pos2);         // move the servo1 to pos2
        delay(15);
        delay(650);               // wait 650 ms
        servo1.write(pos1);          // move servo1 to pos1
    } 
    
    if (incomingByte == '2') {    // if byte stored is == 2 then
        servo2.write(pos2);         // move the servo2 to pos2
        delay(15);
        delay(650);               // wait 650 ms
        servo2.write(pos1);         // move servo2 to pos1
    
    }
    
    if (incomingByte == '3') {    // if byte stored is == 3 then
        servo3.write(pos2);         // move servo3 to pos2
        delay(15);
        delay(650);               // wait 650 ms
        servo3.write(pos1);         // move servo3 to pos1
   }
    
    if (incomingByte == '4') {    // if byte stored is == 4 then
        servo4.write(pos2);         // move servo4 to pos2
        delay(15);
        delay(650);               // wait 650 ms
        servo3.write(pos1);         // move servo4 to pos1
        
      } 
        
        SoftwareServo::refresh();   // refresh all software servos
   }
}
