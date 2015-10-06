void getData(){
 //gets the data from the API and sorts it into an array of TrainObj's 
for (int lineNumber = 0; lineNumber<trainLines.length;lineNumber++) { //for loop loops through each train line and gets the data
    // change line to next one
    //create url and get xml array
    // loop through trains and send data
    String line = trainLines[lineNumber];                    //get name of line
    String url = urlBase + line;                             //add name to request

    // load the XML document
    XML xml = loadXML(url);

    //Grab the element we want 
    ArrayList<XML> trains = new ArrayList<XML>();
    XML[] tempTrains = xml.getChildren("route/train"); // sort data into array and then into a list
    for (int i = 0; i<tempTrains.length; i++) {
      trains.add(tempTrains[i]);
    }

    //temp variables for in the loop
    float tempLon, tempLat, tempDist, tempAngle, tempHeading;
    int tempRn, compRn;
    boolean tempDelay;
    XML lonXML, latXML, rnXML, headingXML, delayXML;    
 
    for (int t = 0; t<myTrain[lineNumber].length; t++) { 
      boolean done = false;
      compRn = myTrain[lineNumber][t].rn; // pick the rn of a previously stored train for this line
      for (int j = trains.size()-1; j>= 0; j--) {  // starting from the back, check the first incoming data 
        XML tempXML = trains.get(j);  
        rnXML = tempXML.getChild("rn");  //check its rn
        tempRn = rnXML.getIntContent();
        lonXML = tempXML.getChild("lon"); // get lon and lat of new train
        latXML = tempXML.getChild("lat");
        headingXML = tempXML.getChild("heading");
        delayXML = tempXML.getChild("isDly");
        tempDelay = boolean(delayXML.getIntContent());
        tempLon = lonXML.getFloatContent();
        tempLat = latXML.getFloatContent();
        tempHeading = headingXML.getFloatContent();
        tempDist = haversine(myLonReal, tempLon, myLatReal, tempLat); //calculate the distance 
       // println(tempDist);
        if (tempDist <= maxDistance){// && tempDist<=maxDistance) { // if new rn is equal to rn of checked train
          if (tempRn == compRn){            // and the calculated distance is lower than the maximum, enter data
          tempAngle = calcAngle(myLonReal, tempLon, myLatReal, tempLat);
          myTrain[lineNumber][t].setTrainData(tempLon, tempLat, tempAngle, tempDist, t, lineNumber, tempRn, tempHeading, tempDelay); //update the trainObj
          done = true;
          trains.remove(j); //remove data from pulled data 
        }}
        else{
          trains.remove(j); //also remove data from pulled data when distance is too large
        }
        if (done) break;
      }
      if (!done){
        myTrain[lineNumber][t].noDataCounter--;
        if (myTrain[lineNumber][t].noDataCounter <= 0){
        myTrain[lineNumber][t].dead = true; //if a trainObj has not been updated then declare it dead and remove it. 
        }
      }
    }
    if (trains.size() >= 1) {  //if there's trains in the pulled data after updating the existing trainObj's
      for (int y = trains.size()-1; y>=0; y--) {
        XML tempXML = trains.get(y);
        boolean finished = false;
        for (int u = 0; u <=myTrain[lineNumber].length; u++) {
          if (myTrain[lineNumber][u].dead) {  //update all the 
            rnXML = tempXML.getChild("rn");
            tempRn = rnXML.getIntContent();
            lonXML = tempXML.getChild("lon");
            latXML = tempXML.getChild("lat");
            delayXML = tempXML.getChild("isDly");
            tempDelay = boolean(delayXML.getIntContent());
            tempLon = lonXML.getFloatContent();
            tempLat = latXML.getFloatContent();
            headingXML = tempXML.getChild("heading");
            tempHeading = headingXML.getFloatContent();
            
            tempDist = haversine(myLonReal, tempLon, myLatReal, tempLat);
            tempAngle = calcAngle(myLonReal, tempLon, myLatReal, tempLat);
            myTrain[lineNumber][u].setTrainData(tempLon, tempLat, tempAngle, tempDist, u, lineNumber, tempRn,tempHeading, tempDelay);
            trains.remove(y);
            finished = true;
          }
          if (finished)break;
        }
      }
    }
  }  //end of line for loop
 
}



