class circleFade{
  float fullSize = 200; //size of the circle 
  float xPos = 0;  
  float yPos = 0; 
  float time = 10;  //time the circle takes to fade
  float allTime = 10;
  int counter = 0;
  int counter2 = 0;
  int countercounter = 0;
  boolean done = false;
  
  //connection details
  int Rn1 = 0;
  int Rn2 = 0;
  color l1, l2;
  
  
  circleFade(float tempXpos, float tempYpos, float tempTime, int rn1, int rn2, color tempL1, color tempL2){
    xPos = tempXpos; 
    yPos = tempYpos;
    time = tempTime;
    allTime = tempTime;
    
    Rn1 = rn1; 
    Rn2 = rn2;
    
    l1 = tempL1;
    l2 = tempL2;

  }
  
  void draw(){
   //draw circle at pos and fade according to time
  // make arraylist in greetingmanager and update the circleFade's 
  noFill();
  float fade = (255/allTime)*time;
  stroke(255,fade);
  strokeWeight(6);
  float size = fullSize;
  if (time >= allTime*(2/3)){size = (fullSize/allTime)*(allTime-time);}
  else{ size = (fullSize/allTime)*(time);}
 //int size = 50
  ellipse(xPos,yPos,size,size);
  float arclength = PI/2;
  strokeWeight(3);
  stroke(l1,fade);
  arc(xPos,yPos,size+10,size+10,(PI/180)*(counter2)+PI,(PI/180)*(counter2)+PI+arclength); //outer ring
  

  size = (fullSize/allTime)*time;
  stroke(255,fade);
  ellipse(xPos,yPos,size,size);
  
  arclength = PI/2;
  stroke(l2,fade);
  arc(xPos,yPos,size+10,size+10,(PI/180)*counter,(PI/180)*counter+arclength); //inner ring
  
  }
  
  void update(){
    time--;
    countercounter++;
    counter++;
    counter = counter%360;
    if (countercounter >= 3){
      countercounter = 0;
      counter2++;
      counter2 = counter2%360;
    }
    if (time <= 0){
      done = true;
    }
  }
}
  
