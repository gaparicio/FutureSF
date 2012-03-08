/ Sensor sketch based on ladyada DHT (http://www.ladyada.net/learn/sensors/dht.html) and Photocell (http://www.ladyada.net/learn/sensors/cds.html) code samples
// DHT library Written by ladyada (https://github.com/adafruit/DHT-sensor-library)

#include "DHT.h"

#define DHTPIN 2     // what pin we're connected to

#define DHTTYPE DHT22   // DHT 22  (AM2302)

int photocellPin = 0;
int photocellReading;

// Connect pin 1 (on the left) of the sensor to +5V
// Connect pin 2 of the sensor to whatever your DHTPIN is
// Connect pin 4 (on the right) of the sensor to GROUND
// Connect a 10K resistor from pin 2 (data) to pin 1 (power) of the sensor

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600); 
  dht.begin();
}

void loop() {
  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  float t = dht.readTemperature();
 
  photocellReading = analogRead(photocellPin);

  // check if returns are valid, if they are NaN (not a number) then something went wrong!
  if (isnan(t) || isnan(h)) {
    Serial.println("Failed to read from DHT");
  } else {
    Serial.print(h); //humidity
    Serial.print(",");
    Serial.print(t); //temperature
    Serial.print(",");
    Serial.println(photocellReading);//photocell
  }
}

