void greetingManager(){
// check the relative angle between all trains 
// if the angle is large enough (>70) (for saying hello properly)
// check the distance between the trains
// if the distance is small enough
// trigger the hello synth

/*
for (every line)
for (train from all trains)
  for every line(// disable if you only want to check a single line
  for (a train from all trains)
       if second train is not first train
         check relative angle between both trains; relAng = abs(abs(ang1)-abs(ang2))
         if larger than 70
           calculate distance between both current positions
           if distance is small enough
             trigger hello sequence 
                 // is triggering hello synth 
                 // and create fading circle around the two trains
                 // circle is an object that slowly fades, input is position, color and fadetime          
*/


float angle1, angle2, relAngle, minAngle, xPos1, xPos2, yPos1, yPos2, maxDist,relPosX, relPosY, relDist, fadeTime;
int Rn1, Rn2;
color l1, l2;
minAngle = 70;
maxDist = 35;
fadeTime = 500; //time the circle takes to fade


//two arrays each with the relation between trains (so [3] corresponds with [3] in the other array) 
//check the first array for the Rn of one of both trains, if found check the other array at that position
//if the value at that position is the same as one of both the trains then it's already there, if not. add it. 

boolean newGreeting = true;


for (int lineNumber = 0; lineNumber<trainLines.length;lineNumber++) {
  for (int i = 0; i<myTrain[lineNumber].length; i++) {
      if (myTrain[lineNumber][i].dead){break;}
         for (int lineNumber2 = 0; lineNumber2<trainLines.length;lineNumber2++) {
            for (int j = 0; j<myTrain[lineNumber2].length; j++) {
              if (lineNumber == lineNumber2 && i == j){ break; }
              else if (myTrain[lineNumber2][j].dead){break;}
              else {
                angle1 = myTrain[lineNumber][i].headingClean;
                angle2 = myTrain[lineNumber2][j].headingClean;
                relAngle = abs(angle1 - angle2);
                if (relAngle >= minAngle){
                    xPos1 = myTrain[lineNumber][i].currentXpos;
                    yPos1 = myTrain[lineNumber][i].currentYpos;
                    xPos2 = myTrain[lineNumber2][j].currentXpos;
                    yPos2 = myTrain[lineNumber2][j].currentYpos;
                    // no square root for speed reasons
                    relPosX  = abs(xPos1 - xPos2);
                    relPosY  = abs(yPos1 - yPos2);
                    relDist = sq(relPosX) + sq(relPosY);
                    Rn1 = myTrain[lineNumber][i].rn;
                    Rn2 = myTrain[lineNumber2][j].rn;
                    if (relDist <= sq(maxDist)){
                       newGreeting = true;
                       for (int q = trains1.size()-1; q>= 0; q--){
                         if (trains1.get(q) == Rn1 || trains1.get(q) == Rn2){
                           if (trains2.get(q) == Rn1 || trains2.get(q) == Rn2){
                             //new greeting
                             newGreeting = false;
                           }
                         }
                       }
                       if (newGreeting){
                       print("we have a new greeting");
                       trains1.append(Rn1);
                       trains2.append(Rn2);
                       float avgXpos = (xPos1 + xPos2)/2;
                       float avgYpos = (yPos1 + yPos2)/2;
                       l1 = myTrain[lineNumber][i].lStored;
                       l2 = myTrain[lineNumber2][j].lStored;
                       circles.add(new circleFade(avgXpos, avgYpos, fadeTime,Rn1,Rn2,l1,l2));
                       //send info to max msp through function sendExtra
                       float avgAngle = angle1;
                       float avgDist = (myTrain[lineNumber][i].distance + myTrain[lineNumber][j].distance)/2;
                       String line1 = myTrain[lineNumber][i].lineName; 
                       String line2 = myTrain[lineNumber][j].lineName; 
                       int[] meetDataInt = {};
                       float[] meetDataFloat={avgAngle, avgDist};
                       String[]  meetDataString={line1,line2};
                       sendExtra("Meet",meetDataInt,meetDataFloat,meetDataString);
                       
                       }
                    }
                    else{
                      for (int p = trains1.size()-1; p>= 0; p--){
                         if (trains1.get(p) == Rn1 || trains1.get(p) == Rn2){
                           if (trains2.get(p) == Rn1 || trains2.get(p) == Rn2){
                         trains1.remove(p);
                         trains2.remove(p);
                           }
                         }
                      }
                    }              
                    }
                }
             }
         }    
      }     
    }         
}

