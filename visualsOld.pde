void drawData(int mode){
 if (mode == 1){ 
  int gapSize = 50;
  for (int i = 0; i<trainLines.length; i++){
    for (int j = 0; j<myTrain[i].length;j++){
        if (myTrain[i][j].dead)fill(50);
        else fill(myTrain[i][j].l);
        noStroke();
        rect(30+j*gapSize,30+i*gapSize,10,10);
        textSize(15);
        text(myTrain[i][j].rn,32+j*gapSize,30+i*gapSize);
        text(nf(myTrain[i][j].distance,2,2),32+j*gapSize,55+i*gapSize);
    }
    }
 }
  if (mode == 3 || mode == 1){
       for (int i = 0; i<trainLines.length; i++){
       for (int j = 0; j<myTrain[i].length;j++){
           color fillColor = color(0,0,0); 
           myTrain[i][j].update();
           fillColor = myTrain[i][j].l;
           fill(fillColor);
        if (myTrain[i][j].delay){ stroke(0); strokeWeight(1); }
        else { noStroke();}
        int size = 28;
        ellipse(myTrain[i][j].currentXpos,myTrain[i][j].currentYpos,size,size);
        noFill();
        strokeWeight(1);
        stroke(255);
        ellipse(myTrain[i][j].currentXpos,myTrain[i][j].currentYpos,size*.9,size*.9);
 // calibrate by calculating difference from flipping axis and subtracting the difference twice 
        float heading = (myTrain[i][j].headingClean + 270) % 360;
        float avgAngle = (heading)*(PI/180);
        strokeWeight(1);
        stroke(0);
        noFill();
        arc(myTrain[i][j].currentXpos,myTrain[i][j].currentYpos,size+5,size+5,avgAngle-(PI/8),avgAngle+(PI/8));
        
        textSize(size*.5);
        fill(255);
        textAlign(CENTER,CENTER);
        text(myTrain[i][j].ID,myTrain[i][j].currentXpos,myTrain[i][j].currentYpos);
       }}
     float xOffset = 7;
      float yOffset = 0;
   float myXpos = xOffset + map(myLonReal,mapLon1,mapLon2,(width-drawWidth)/2,width-((width-drawWidth)/2));    
   float myYpos = yOffset + map(myLatReal,mapLat1,mapLat2,(height-drawHeight)/2,height-((height-drawHeight)/2));
   strokeWeight(5);
   stroke(255,0,0);
   fill(255);
   ellipse(myXpos,myYpos,20,20);
   fill(255,0,0);
   ellipse(myXpos,myYpos,5,5);
 
 }


  }
