import processing.serial.*;
import eeml.*;

Serial myPort;
String inString;
String inString0;
String inString1;
String inString2;
String list;
int lf=10;

DataOut dOut;
float lastUpdate;

void setup(){
  myPort = new Serial(this, Serial.list()[0],9600); 
  myPort.bufferUntil(lf);
  // set up DataOut object; requires URL of the EEML you are updating, and your Pachube API key  
    dOut = new DataOut(this, "YOUR SENSOR FEED HERE e.g (https://api.pachube.com/v2/feeds/39533.xml)", "YOUR API KEY HERE");  

    //  and add and tag a datastream   
    dOut.addData(0,"humidity");
    //  and add and tag a datastream   
    dOut.addData(1,"temperature");
     //  and add and tag a datastream   
    dOut.addData(2,"photocell");
     //  and add and tag a datastream   
}

void draw()
{
    // update once every 5 seconds (could also be e.g. every mouseClick)
    if ((millis() - lastUpdate) > 5000){
        println("ready to POST: ");
        dOut.update(0, inString0); // update the datastream
        dOut.update(1, inString1); // update the datastream
        dOut.update(2, inString2); // update the datastream
        int response = dOut.updatePachube(); // updatePachube() updates by an authenticated PUT HTTP request
        println(response); // should be 200 if successful; 401 if unauthorized; 404 if feed doesn't exist
        lastUpdate = millis();
    }  
}

void serialEvent(Serial p){
  inString = (myPort.readString());
  String[] list = split(inString, ',');
  inString0 = list[0];
  inString1 = list[1];
  inString2 = list[2];
}

