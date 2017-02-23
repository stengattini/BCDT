
//||||\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\||||\\
//||||****BICYCLE COAST DOWN TEST - BCDT SKETCH****||||\\
//||||/////////////////////////////////////////////||||\\

//v1_
//v2_no multiple wind readings
//Simone_Tengattini_v3_21APR16
//Simone_Tengattini_v4_22APR16
//Simone_Tengattini_v5_18MAY16
//v6_9JUN16_corrected intialization of 1Hz wind measurement vector
//v7_17JUN16
//v8_18JUN16_SRAM space saving improvements
//v9_20JUN16_NoPULLUP&deleted 'LED off' for loop
//v10_22JUN16_NoLed_LCDwarningINSTEAD
//v10.1_29JUN16_AnalogRead & RTC for reading time for pictures

///set analogRead to return much faster
// 16 prescaler
#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif


////////////////////////////////////////////
//CONSTANT VARIABLE DEFINITION & libraries//
////////////////////////////////////////////

//for SD library
//#include <MemoryFree.h>
#include <SPI.h>
#include <SD.h>

//for LCD library
#include <LiquidCrystal.h>

//for RTC - Real time clock
#include <Wire.h>
#include "RTClib.h"

RTC_DS1307 RTC;

//Others
#define FILE_BASE_NAME "BCDE" // Base name must be six characters or less for short file names 8.3fat. maybe change it to include SITE# (e.g. A), DATE OF TEST (mmdd), etc...e.g. 1506A000.csv
Sd2Card card;
File file; //name of the file'entity' needed e.g. for file.print command
LiquidCrystal lcd(8, 9, 4, 5, 6, 7); //pin for LCD communication in order as (RS, Enable, D4, D5, D6, D7)

////////////////////
//GLOBAL VARIABLES//
///////////////////

// Light Beam Sensors PINS
const unsigned char LBSensorPins[] = {A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13};
const unsigned char LBSensorPinsTot = 12;

//Anemometers sensors PINS
const unsigned char ANSensorsPins[] = {A14, A15}; //A14=dir, A15=speed
const unsigned char ANSensorsPinsTot = 2;

//Time varibles
const unsigned long intTime = 1000000; // every 2 sec read wind


//BUTTON PINS
const unsigned char SelectButtonPin = A0; //button select on the LCD screen

//SD CARD PINS
const uint8_t CS_PIN = 53; //communication Pin between card and Arduino

//decleared here because arduino varibales have a SCOPE. So if I define them in the setup() they are not recallable in the loop()
const uint8_t BASE_NAME_SIZE = sizeof(FILE_BASE_NAME) - 1;
char fileName[] = FILE_BASE_NAME "000.csv";

//threshold HIGH-LOW
const int TSH = 200; //about 1V


//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

void setup() {

  ///set analogRead to return much faster
#if FASTADC
  // set prescale to 16
  sbi(ADCSRA, ADPS2) ;
  cbi(ADCSRA, ADPS1) ;
  cbi(ADCSRA, ADPS0) ;
#endif

  pinMode(CS_PIN, OUTPUT); //for ethernet shield through ICSP pins

  //set up communication with PC , LCD shield, SD
  // start laptop communication
  Serial.begin(250000);

  //start LCD communication
  lcd.begin(16, 2); // begin communication with an LCD of 16-by-2 size

  //start RTC communications
  Wire.begin();
  RTC.begin();

  if (! RTC.isrunning()) {
    Serial.println(F("(!) RTC non working"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("(!) RTC is" ));
    lcd.setCursor(0, 1);
    lcd.print(F("out of order"));
    delay(2000);
  }
  // following line sets the RTC to the date & time this sketch was compiled
  // uncomment it & upload to set the time, date and start run the RTC!
  //RTC.adjust(DateTime(__DATE__, __TIME__));


START: //milestone for 'goto' if card not working


  ////////////////////////////
  //SET PINS INPUT or OUTPUT//
  ////////////////////////////


  //cycle to set LBsensors as input
  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    pinMode(LBSensorPins[pin], INPUT);
  }

  //Anemometers sensors PINS
  //cycle to set AnemSensors as input
  for (unsigned char pin = 0; pin < ANSensorsPinsTot; pin++)
  {
    pinMode(ANSensorsPins[pin], INPUT);
  }

  //BUTTON PINS

  pinMode(SelectButtonPin, INPUT); //button select on the LCD screen

  //SD CARD PINS

  //check SD card is OK
  if (!SD.begin(CS_PIN))
  {
    Serial.println(F("(!) SD.begin failed. Fix card & PRESS RESET"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("(!)SD.begin failed"));
    lcd.setCursor(0, 1);
    lcd.print(F("ed. Fix card & PRESS RESET"));
    delay(2000);
    goto START;
  }
}

//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

void loop() {


  /////////////////////////////////////////////////////////////////////////////////////////
  //In this MAIN LOOP, while cycles are used to establish "checkpoints" where
  //authorization by the operator (i.e. who is pressing "RIGHT") is
  //needed in order for the MAIN LOOP to proceed to the next stage. In particoular,
  //there are 5 stages:

  //1. Pre-test (pre-paration);
  //2. Preparation (give name to test);
  //3. Preparation (measurement vectors back to default stage);
  //4. Measurement Phase;
  //5. Data Logging phase.
  ////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////
  //1. Pre-test (pre-paration)//
  /////////////////////////////

  // check SD is ok at beggining of every test
  if (!card.init(SPI_HALF_SPEED, CS_PIN))
  {
    Serial.println(F("(!) SD Initialization failed. Is a card inserted?"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("(!) SD Initialization"));
    lcd.setCursor(0, 1);
    lcd.print(F("failed."));
    return;
  }
  else
  {
    Serial.println(F("() SD working properly"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("() SD working"));
    lcd.setCursor(0, 1);
    lcd.print(F("properly"));
  }

  Serial.println(F("(1/5) Select to authorize TEST PREPARATION"));
  lcd.print(F("(1/5) Select to authorize TEST PREPARATION"));
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(1/5)'RIGHT' for"));
  lcd.setCursor(0, 1);
  lcd.print(F("TEST PREPARATION"));

  while (digitalRead(SelectButtonPin) == HIGH)
  {
    //do nothing, just wait for button to be pushed so that break out of 'while' cycle
  }
  delay(2000); //delay of 2 secs beacuse humans press buttons too slowly: arduino thinks it has 'authorization' to proceed through downstream checkpoints.



  ////////////////////////////////////////
  //2. Preparation (give name to test) //
  ///////////////////////////////////////

  Serial.println(F("(2/5) TEST PREPARATION UNDERGOING")); //print to LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(2/5)TEST PREP"));
  lcd.setCursor(0, 1);
  lcd.print(F("UNDERGOING"));
  delay(2000);
  // Check where BEAM SENSORS ARE read HIGH to check alignment!

BEAM_ALIGN://check point for beam alignment. if not present, maybe 2 beams are misalgined and one is ok but the other not, arduino thinks everything is ok, because of the sequential check of beams of the for() loop
  //as a consequence in the field check them in order, i.e. fix beam 0, then 1, then 2, etc.
  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    while (analogRead(LBSensorPins[pin]) < TSH )
    {

      Serial.print(F("(!) BEAM NOT ALIGNED:"));
      Serial.println(pin);
      Serial.print(F("(!) ALIGN and press RESET"));
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print(F("(!)UNALIGNMENT"));
      lcd.setCursor(0, 1);
      lcd.print(F("#"));
      lcd.setCursor(1, 1);
      lcd.print(pin + 1);
      lcd.setCursor(4, 1);
      lcd.print(F("ALIGN&RESET"));
      delay(50);
      goto BEAM_ALIGN;
    }

  }

  Serial.println(F("() BEAMS ARE ALIGNED"));
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("()BEAMS"));
  lcd.setCursor(0, 1);
  lcd.print(F("ARE ALIGNED"));
  delay(2000);


  //check in the SD card the last file name
  while (SD.exists(fileName))
  {
    if (fileName[BASE_NAME_SIZE + 2] != '9') //increment one unit until unit=9 then go to next condition
    {
      fileName[BASE_NAME_SIZE + 2]++;
    }
    else if (fileName[BASE_NAME_SIZE + 1] != '9') //where unit posed to zero, but decade incremented by one
    {
      fileName[BASE_NAME_SIZE + 2] = '0';
      fileName[BASE_NAME_SIZE + 1]++;
    }
    else if (fileName[BASE_NAME_SIZE] != '9') //for when need to go from a century to another, e.g. 099 to 100
    {
      fileName[BASE_NAME_SIZE + 2] = '0';
      fileName[BASE_NAME_SIZE + 1] = '0';
      fileName[BASE_NAME_SIZE]++;
    }
    else
    {
      Serial.println(F("(!) Cannot create file name")); //print on LCD!! so modify
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print(F("(!)CAN'T CREATE"));
      lcd.setCursor(0, 1);
      lcd.print("file name");
      return;
    } //now the next file name is found, and it is stored in "fileName"

  }

  Serial.print(F("THIS is 'TEST#'.csv:   "));
  Serial.println(fileName); //print on LCD!! so modify..perhaps write 'press select to continue'
  Serial.println(F("(?) HAVE YOU TAKEN NOTE OF TEST #? - PRESS SELECT to CONTINUE"));
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("'TEST-ID'.csv"));
  lcd.setCursor(0, 1);
  lcd.print(fileName);

  while (digitalRead(SelectButtonPin) == HIGH)
  {
    //do nothing, just wait for button to be pushed so that break out of 'while' cycle
    //time to take note of the TEST NUMBER
  }
  delay(2000); //delay of 2 secs beacuse humans press buttons too slowly: arduino thinks it has 'authorization' to proceed through downstream checkpoints.

  //////////////////////////////////////////////////////////////
  //3. Preparation (measurement vectors back to default stage)//
  //////////////////////////////////////////////////////////////

  Serial.println(F("(3/5) VECTORS PREPARATION UNDERGOING"));
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(3/5) VECTORS"));
  lcd.setCursor(0, 1);
  lcd.print(F("PREP UNDERGOING"));
  delay(1000);


  //Vector storing status of Anemometer
  unsigned int AN_Dir_SensorRead[LBSensorPinsTot];
  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    AN_Dir_SensorRead[pin] = 9999; //set to initial value of 9999 to distinguish from read values
  }

  unsigned int AN_Vel_SensorRead[LBSensorPinsTot];
  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    AN_Vel_SensorRead[pin] = 9999; //set to initial value of 9999 to distinguish from read values
  }

  unsigned char wr = 1; //index wr 'wind reading' back to zero to store continuous (1Hz) wind measurement
  const unsigned char wrmax = 100; //max number of measuremnt of wind measuremnts. DON'T EXAGGERATE with this, beacuse instability arieses (experienced in beam alignemnt phase) each test is about 2 min. 3 mins for being conservative
  //plous since wr is unsigned char, its maxiumum as this kind can be 255
  unsigned int AN_Dir_SensorRead_1sec[wrmax]; //store 1Hz wind direction
  for (unsigned char i = 0; i <= wrmax; i++)
  {
    AN_Dir_SensorRead_1sec[i] = 9999; //set to initial value of 9999 to distinguish from read values
  };
  unsigned int AN_Vel_SensorRead_1sec[wrmax]; //store 1Hz wind speed
  for (unsigned char i = 0; i <= wrmax; i++)
  {
    AN_Vel_SensorRead_1sec[i] = 9999; //set to initial value of 9999 to distinguish from read values
  };
  unsigned long WindTime[wrmax]; //store time of wind measurments
  for (unsigned char i = 0; i <= wrmax; i++)
  {
    WindTime[i] = 0; //set to initial value of 0 to distinguish from read values
  };

  //Time variables
  unsigned long ReadTime[LBSensorPinsTot]; //storing times of broken beams
  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    ReadTime[pin] = 0; //set to initial to 0 to distinguish from read values
  };

  // DateTime
  DateTime now;

  Serial.println(F("(4/5) MEASUREMENT PHASE. Press Select to START")); //print to LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(4/5)MSRMT PHASE"));
  lcd.setCursor(0, 1);
  lcd.print(F("'RIGHT' to START"));

  while (digitalRead(SelectButtonPin) == HIGH)
  {
    //do nothing, just wait for button to be pushed so that break out of 'while' cycle
    //time to check bicyclist is ready to start
  }
  delay(2000); //delay of 2 secs beacuse humans press buttons too slowly: arduino thinks it has 'authorization' to proceed through downstream checkpoints.

  Serial.println(F("(4/5) NOW UNDER TESTING"));
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(4/5) NOW UNDER"));
  lcd.setCursor(0, 1);
  lcd.print(F("TESTING..."));
  delay(1500);
  lcd.clear();

  ///////////////////////////
  // 4. Measurement Phase///
  //////////////////////////

  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++) //check SELECT so that if someone is gong to slow to reach last sensor, data can be saved anyways
  {
    //delay(200);
    while (analogRead(LBSensorPins[pin]) >= TSH && digitalRead(SelectButtonPin) == HIGH )
    {

      if ((WindTime[wr] - WindTime[wr - 1]) >= intTime && wr < wrmax) //WRITE IN HERE 1Hz anemometer readings
      {
        WindTime[wr] = micros();
        AN_Dir_SensorRead_1sec[wr] = analogRead(ANSensorsPins[0]);
        AN_Vel_SensorRead_1sec[wr] = analogRead(ANSensorsPins[1]);
        wr++;
      }
      WindTime[wr] = micros();

      //Serial.println(wr);
      //Serial.println(pin);
    }

    ReadTime[pin] = micros();
    AN_Dir_SensorRead[pin] = analogRead(ANSensorsPins[0]);
    AN_Vel_SensorRead[pin] = analogRead(ANSensorsPins[1]);
    //lcd.setCursor(pin, 0);
    lcd.print(pin + 1);
    //Serial.print("freeMemory()=");
    //Serial.println(freeMemory());

    if (pin == 2) //print time when picture is taken - between 2nd and 3rd beam
    {
      now = RTC.now();
    }

  }

  delay(2000); //delay in case SELECT is pressed in the WHILE() to skip last beams, and not to think authorization is grated for downstream checkpoints

  Serial.println(F("(4/5) ALL BEAMS WERE BROKEN")); //print to LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(4/5) ALL BEAMS"));
  lcd.setCursor(0, 1);
  lcd.print(F("WERE BROKEN :)"));
  delay(1000);

  //print time broken and anemometer readings to get a feeling if the test run properly
  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    Serial.println(pin + 1);
    Serial.print(F(","));
    Serial.print((ReadTime[pin] - ReadTime[0]) / 1000000);
    Serial.print(F(","));
    Serial.print(AN_Dir_SensorRead[pin]);
    Serial.print(F(","));
    Serial.print(AN_Vel_SensorRead[pin]);
    Serial.print(F("\n"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("#"));
    lcd.setCursor(1, 0);
    lcd.print(pin + 1);
    lcd.setCursor(3, 0);
    lcd.print(F("Time:"));
    lcd.setCursor(8, 0);
    lcd.print((ReadTime[pin] - ReadTime[0]) / 1000000);
    lcd.setCursor(0, 1);
    lcd.print(F("WD"));
    lcd.setCursor(2, 1);
    lcd.print(float(AN_Dir_SensorRead[pin]) * 360 / 1023, 2);
    lcd.setCursor(8, 1);
    lcd.print(F("WV"));
    lcd.setCursor(10, 1);
    lcd.print(float(AN_Vel_SensorRead[pin]) * 100 / 1023, 2);
    delay(750);
  }

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(now.year(), DEC);
  lcd.print(F("/"));
  lcd.print(now.month(), DEC);
  lcd.print(F("/"));
  lcd.print(now.day(), DEC);
  lcd.print(F("/"));
  lcd.setCursor(0, 1);
  lcd.print(now.hour(), DEC);
  lcd.print(F(":"));
  lcd.print(now.minute(), DEC);
  lcd.print(F(":"));
  lcd.print(now.second(), DEC);
  delay(1000);

  Serial.println(F("(4/5) SELECT to LOG DATA")); //print to LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(4/5)Press RIGHT"));
  lcd.setCursor(0, 1);
  lcd.print(F("to LOG DATA"));


  ///////////////////////////
  // 5. Data Logging phase//
  //////////////////////////

  while (digitalRead(SelectButtonPin) == HIGH)
  {
    //do nothing
  }
  delay(2000); //delay of 2 secs beacuse humans press buttons too slowly: arduino thinks it has 'authorization' to proceed through downstream checkpoints.

  //write on file
  Serial.println(F("(5/5) LOGGING DATA TO SD")); //print to LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(5/5)LOGGING DATA"));
  lcd.setCursor(0, 1);
  lcd.print(F("TO SD-card..."));

  //create the new file to write

CHECK_SD:
  if (!card.init(SPI_HALF_SPEED, CS_PIN))
  {
    Serial.println(F("(!) SD Initialization failed. Is a card inserted?"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("(!) SD Initialization"));
    lcd.setCursor(0, 1);
    lcd.print(F("failed."));
  }
  else
  {
    Serial.println(F("() SD working properly"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("() SD working"));
    lcd.setCursor(0, 1);
    lcd.print(F("properly"));
  }

  //retry to open file as it failed
  file = SD.open(fileName, FILE_WRITE);

  if (!file) //if file created is not there for any reason, WARNING!
  {
    Serial.println(F("(!) File CREATION failed. Waiting for SD to be fixed. If Doesn't fix, RESET and PERFORM TEST AGAIN"));
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print(F("(!)File CREATION"));
    lcd.setCursor(0, 1);
    lcd.print(F("failed! check SD"));
    file.close();
    goto CHECK_SD;
  }

  // if the file is available, write the collected data in it:

  //Print as .csv beam broken and times


  file.print(fileName);
  file.print(F(","));
  file.print(now.year());
  file.print(F(","));
  file.print(now.month());
  file.print(F(","));
  file.print(now.day());
  file.print(F(","));
  file.print(now.hour());
  file.print(F(","));
  file.print(now.minute());
  file.print(F(","));
  file.print(now.second());
  file.print(F("\n"));
  file.print(F("Beam#"));
  file.print(F(","));
  file.print(F("Time_microsec"));
  file.print(F(","));
  file.print(F("Wind_Dir_deg_0isN"));
  file.print(F(","));
  file.print(F("Wind_Vel_m/s"));
  file.print(F("\n"));

  for (unsigned char pin = 0; pin < LBSensorPinsTot; pin++)
  {
    file.print(pin + 1);
    file.print(F(","));
    file.print(ReadTime[pin]);
    file.print(F(","));
    file.print(float(AN_Dir_SensorRead[pin]) * 360 / 1023, 6); //conv. to sexagesimal degrees; 6 decimal places
    file.print(F(","));
    file.print(float(AN_Vel_SensorRead[pin]) * 100 / 1023, 6); //conv. to m/s; 6 decimal places
    file.print(F("\n"));
  }

  //print wind continouos measurment

  file.print(fileName);
  file.print(F("\n"));
  file.print(F("Time_microsec"));
  file.print(F(","));
  file.print(F("Wind_Dir_deg_0isN"));
  file.print(F(","));
  file.print(F("Wind_Vel_m/s"));
  file.print(F("\n"));

  for (unsigned char i = 1; i < wr; i++)
  {
    file.print(WindTime[i]);
    file.print(F(","));
    file.print(float(AN_Dir_SensorRead_1sec[i]) * 360 / 1023, 6); //conv. to sexagesimal degrees; 6 decimal places
    file.print(F(","));
    file.print(float(AN_Vel_SensorRead_1sec[i]) * 100 / 1023, 6); //conv. to m/s; 6 decimal places
    file.print(F("\n"));
  }

  file.close();

  Serial.println(F("(5/5) LOGGING SUCCESSFUL. START OVER TO (1/5) WITH RESET, i.e. NEW TEST"));
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(F("(5/5)TEST OK!"));
  lcd.setCursor(0, 1);
  lcd.print(F("'RESET' 4 NEW"));

  while (CS_PIN == 53) // condition always true so that to start over, one needs to push RESET so that micros reset
  {
    //do nothing, just wait for button to be pushed so that break out of 'while' cycle
  }
  delay(2000); //delay of 2 secs beacuse humans press buttons too slowly: arduino thinks it has 'authorization' to proceed through downstream checkpoints.
}
