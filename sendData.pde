void sendLine() {
  for (int lineNumber = 0; lineNumber<trainLines.length;lineNumber++) {
    for (int i = 0; i<myTrain[lineNumber].length;i++) {
      if (!myTrain[lineNumber][i].dead && myTrain[lineNumber][i].distance < maxDistance) {
        //  println(myTrain[lineNumber][i].line + "Train no: " + i + " his distance is " + myTrain[lineNumber][i].distance + " Kilometers and his angle is " + myTrain[lineNumber][i].angle);
        sendData(trainLines[myTrain[lineNumber][i].line], myTrain[lineNumber][i].ID, myTrain[lineNumber][i].rn, myTrain[lineNumber][i].distance, myTrain[lineNumber][i].angle,myTrain[lineNumber][i].delay);
      }
    }
  }
}


void sendData(String line, int ID, int rn, float distance, float angle, boolean delay) { 
  OscMessage myOscMessage = new OscMessage(line);
  myOscMessage.add(ID);
  myOscMessage.add(rn);
  myOscMessage.add(distance);
  myOscMessage.add(angle);
  myOscMessage.add(delay);
  oscP5.send(myOscMessage, myBroadcastLocation);
}

void sendExtra(String identifier, int dataInt[], float dataFloat[], String dataString[]){
   OscMessage myOscMessage = new OscMessage(identifier);
  for (int i = 0; i<dataInt.length; i++){
     myOscMessage.add(dataInt[i]);
  }
  for (int i = 0; i<dataFloat.length; i++){
     myOscMessage.add(dataFloat[i]);
  }
  for (int i = 0; i<dataString.length; i++){
     myOscMessage.add(dataString[i]);
  }
  oscP5.send(myOscMessage, myBroadcastLocation);
} 

/*    //send the data per line at once 
 for (int i = 0; i<myTrain[lineNumber].length;i++) {
 if (!myTrain[lineNumber][i].dead && myTrain[lineNumber][i].distance < maxDistance) {
 //  println(myTrain[lineNumber][i].line + "Train no: " + i + " his distance is " + myTrain[lineNumber][i].distance + " Kilometers and his angle is " + myTrain[lineNumber][i].angle);
 sendData(trainLines[myTrain[lineNumber][i].line], myTrain[lineNumber][i].ID,myTrain[lineNumber][i].rn, myTrain[lineNumber][i].distance, myTrain[lineNumber][i].angle);*/
