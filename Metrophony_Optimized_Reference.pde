//Loading XML data from Chicago Public Transit API  
// modeled after XMLYahooWeather Example

import oscP5.*; //used for comm with Max/Msp
import netP5.*; //used for retrieving data  


OscP5 oscP5;

String[] trainLines = {   //All the lines that are retrieved in this order
  "Red", "Blue", "Brn", "G", "P", "Pink", "Y", "Org"
};

public boolean sendDataToMax = true;
public int maxTrains = 25; // the maximum amount of trains (size of array)
public TrainObj[][] myTrain = new TrainObj[trainLines.length][maxTrains]; // first dimension is each line, second dimension is a train 
public float myLatReal = 41.881134025841824; // projectLatitude //monroe and dearborn   //41.8723158;   mydorn
public float myLonReal = -87.6301084757506;  // projectLongitude //-87.6274733;
public float myAngleReal = 90.0; // direction in which project is facing
public float maxDistance = 6; // maximum relative distance for checking trains
int drawMode = 3;  //processing visuals of trains, 0 = diagram, 1 = circular visualization
public boolean cartesian = false;
float drawWidth = 250; //250;
float drawHeight = drawWidth * 0.8;
float widthOffset = 100;
float heightOffset = 100;

public float mapLon1 = -87.674635;
public float mapLon2 = -87.611078;
public float mapLat1 = 41.896879;
public float mapLat2 = 41.867340;


//greetingManager
IntList trains1; 
IntList trains2;

ArrayList <circleFade> circles;

PImage map;



//thread
TimerThread pollThread;
TimerThread greetingThread;
TimerThread triggerThread;

NetAddress myBroadcastLocation; // these are the api url details with the key at the end. 
String urlBase = "http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=0a18a0c2169b4fa4bc5e636ba5ee81f6&rt=";

void setup() { 
  size(1689,1042);
  smooth(30);
  frameRate(60);
  map = loadImage("Img/chicagoMap2.png"); 

  
  drawWidth = width;
  drawHeight = height;//width*((mapLat1-mapLat2)/(mapLon2+mapLon1));

  // for incoming messages
  oscP5 = new OscP5(this, 12000);
  // for sending messages
  myBroadcastLocation = new NetAddress("127.0.0.1", 32000);

  //initialize enough train objects
  for (int i = 0; i < trainLines.length; i++) {
    for (int j = 0; j < maxTrains; j++) {
      myTrain[i][j] = new TrainObj();
    }
  }
  // http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=0a18a0c2169b4fa4bc5e636ba5ee81f6&rt=org
   
  //greetingManager
  trains1 = new IntList();
  trains2 = new IntList();
  circles = new ArrayList <circleFade>();    
  //initialize thread
  int pollPerMinute = 30; //amount of checks per minute
  pollThread = new TimerThread(pollPerMinute); 
  pollThread.running = true;
  pollThread.task = 1;
  pollThread.start(); //needs to be called
  
  int checkPerMinute = 120;
  greetingThread = new TimerThread(checkPerMinute);
  greetingThread.running = true;
  greetingThread.task = 2; 
  greetingThread.start();  
  
  int checkTriggerSpeed = 240;
  triggerThread = new TimerThread(checkTriggerSpeed);
  triggerThread.running = true;
  triggerThread.task = 3; 
  triggerThread.start();
  
  //ini path
  
}

void draw() {
 background(0);
 image(map,0,0);
 print("newframe");
 drawData(drawMode);
 drawGreetingCircles();
 
 
 stroke(0);
 noFill();
 strokeWeight(width/2);
 //ellipse(width/2,height/2,height+width/2,1080+width/2);
}// end of draw 

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* get and print the address pattern and the typetag of the received OscMessage */
  // println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  theOscMessage.print();
  String addrPattern = theOscMessage.addrPattern();
 println("new message " + random(100));
  if (addrPattern.equals("trainTrigger")){
  int lineNumber = 0; 
    for (int i = 0; i<trainLines.length;i++) {
        String line = theOscMessage.get(0).stringValue();
          if (line.equals(trainLines[i])){
          lineNumber = i; 
          break;
        }
    }
  int trainNumber = theOscMessage.get(1).intValue();
//  if(theOscMessage.get(1).intValue() == 2){
  myTrain[lineNumber][trainNumber].l = color(255,255,255);
//  }
  }
  
}
 
void keyReleased(){
    if (key == 'q'){
      drawMode += 1; 
      drawMode %= 4;
      drawMode += 1;
      
      fill(150);
      rect(0,0,width,height);
    }
 }
 
void mouseReleased(){
 // greetingManager();
 circles.add(new circleFade(mouseX,mouseY, 250,500,500,125,0));
 myTrain[1][0].trigger();
 
 int[] meetDataInt = {};
 float[] meetDataFloat={45,1.1};
 String[]  meetDataString={"blue","pink"};
 sendExtra("Meet",meetDataInt,meetDataFloat,meetDataString);
 
 
 
}

void exit()
{
    super.exit();
}


