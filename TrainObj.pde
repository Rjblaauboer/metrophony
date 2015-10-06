class TrainObj{
  float lon = 0;        //longitude
  float lat = 0;        //latitude
  float angle = 0.0;    //relative angle
  float heading = 0.0; //heading direction (degrees)
  float headingClean = 0.0; //direct heading data
  boolean delay = false;
 // float drawAngle = 0.0;
  float distance = 0;   //distance 
 // float drawDistance = 0;
  int ID = 0;           //ID number in the array
  int rn = 0;           //unique routenumber per train on a day 
  int line;             //which line (red,blue,purple) but as an int for the array
  boolean dead = true;  //if this train object is being used  
  color l;              //color corresponding with the line
  color lStored;
  int fullDataCounter = 10;
  int noDataCounter = fullDataCounter;
  String lineName; 
  
  int triggerCounter = 0;
  int fullTriggerCounter = 0;
  
  boolean firstUpdate = true;
  float currentXpos = 0;  //xpos in processing
  float currentYpos = 0;    
  float destXpos = 0;    //xpos in data 
  float destYpos = 0;
  
  float xOffset = 7;
  float yOffset = 0;
  
  float myXpos = xOffset + map(myLonReal,mapLon1,mapLon2,(width-drawWidth)/2,width-((width-drawWidth)/2));    
  float myYpos = yOffset + map(myLatReal,mapLat1,mapLat2,(height-drawHeight)/2,height-((height-drawHeight)/2));
  
  
  float tempPanX = 0;
  float tempPanY = 0;
  float panX = 0; 
  float panY = 0;
  float level = 0;
  
  
  void setTrainData(float tempLon, float tempLat, float tempAngle, float tempDistance, int tempID, int tempLine, int tempRn, float tempHeading, boolean tempDelay){
    lon = tempLon;
    lat = tempLat;
    angle = tempAngle;
    distance = tempDistance;
    ID = tempID;
    line = tempLine;
    if (dead && rn != tempRn){
      firstUpdate = true;
    }
    rn = tempRn;
    heading = abs(tempHeading - 180);
    headingClean = tempHeading;
    delay = tempDelay;
    dead = false;
    setLineColor();
    fullTriggerCounter = 10*int(map(distance,0,maxDistance,12,240));
    
    noDataCounter = fullDataCounter;
    
    destXpos = xOffset + map(lon,mapLon1,mapLon2,(width-drawWidth)/2,width-((width-drawWidth)/2));
    destYpos = yOffset + map(lat,mapLat1,mapLat2,(height-drawHeight)/2,height-((height-drawHeight)/2));
    lineName = trainLines[tempLine];
     
    //println("new ID = " + trainLines[line]  + ID + " x = " + destXpos + " and y = " + destYpos);
    if (firstUpdate){
       currentXpos = destXpos;
      currentYpos = destYpos;
      firstUpdate=false;
    }
  }


void update(){
      currentXpos = lerp(currentXpos,destXpos,0.0005);
      currentYpos = lerp(currentYpos,destYpos,0.0005);
      
      if (l != lStored){
        l = lerpColor(l,lStored,0.001);
      }
}

void setLineColor(){
  switch(line){
      case 0://"Red":
        lStored = color(255,0,0);
       break;
      case 1://"Blue":
        lStored = color(0,0,255);
      break;
      case 2://"Brn":
        lStored = color(100,50,0);
       break;
     case 3://"G":
        lStored = color(0,255,0);
       break;
     case 4://"P":
        lStored = color(125,0,125);
       break;
     case 5://"Pink":
        lStored = color(255,100,255);
       break;
     case 6://"Y":
        lStored = color(255,255,0);
       break; 
     case 7://"Org":
        lStored = color(255,125,0);
        break;
    }
  l = lStored;  
        
  }

void trigger(){
  //trigger visual indication
  l = color(255,255,255);
  if ((currentXpos >= 0 || currentXpos <= width) && (currentYpos >= 0 || currentYpos <= height) && !dead){
  }
}

void triggerReset(){
  triggerCounter = fullTriggerCounter;
}



}
