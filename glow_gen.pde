import AULib.*;

/*
 * 
 */

int numTripods = 40;
int numTubes = numTripods * 3;
int numLEDsPerTube = 56;

int rectWidth = 9;
int rectHeight = 9;
int tubeLength = rectWidth * numLEDsPerTube;

int x;
int y;

color b1, b2, c1, c2;

int activeTubes = 20;

int activeTube[] = new int[activeTubes];      // this should be made dynamic in length, can only handle max 20 interactive tubes now
int numIndex = 0;
int touchState[] = new int[numTubes];
int  startTime[] = new int[numTubes];
int[] nums = new int[10];

boolean alreadyReceived = false; // only needed for key-triggered simulation stuff

Lighteffect lighteffect;

Explosions explosions;
   
void setup() {
  size(800, 450, P2D);
  background(0);
  noStroke();
  font = createFont("Arial Bold",48);
  
  lighteffect = new Lighteffect();
  
  explosions = new Explosions();
    
  defineColors(); // we can use defineColors later on to change colors (periodically or with input)
  
  drawRaster(); // drawRaster helps us with the LED mapping in ELM
}

void draw() {
     // def: (int x, int y, float w, float h, color c1, color c2, int tubeNumber, int tripodNumber)
  //setGradient(x, y, numLEDsPerTube * rectWidth, rectHeight, c2, c1, 2, 10);
  
  lighteffect.update();
  
  ShowFrameRate();
  
  //drawRaster();
  
  /* the idea is that something in the draw function creates a rectangle coming in from the left, or right. So with movement
  the setGradient feature is made to give an idea how this can be done for each tube.
  */
}

void keyPressed() { 
/* this function can be used as an input later on
 * so if we type in 1, 2, or 3 (which is sensor 1, 2, or 3 of one tube) something will happen with the corrosponding tube
 * maybe we can build in something to select a certain tube we want to give input to using the arrows up and down
*/
  int receivedFromTube = 6;
  
  if (alreadyReceived == false) {
    if (key > '0' && key < '4') {
      touchState[receivedFromTube] = key - 48;   //log touchState of tube
      startTime[receivedFromTube] = millis();    //log start time of tube <----- when no light effect should be shown, set to value -1

      for (int i = 0; i < activeTubes - 1; i ++) {
        activeTube[i + 1] = activeTube[i];      //add.toarray
      }
      
      activeTube[0] = receivedFromTube;         //add tube to activeTube[] array 
    } 
    else {
      touchState[receivedFromTube] = 0;
    }
    alreadyReceived = true;
  }
}

void keyReleased() {
  // this simulates receiving sensordata "0" zero, indicating that the touch has stopped.
  int receivedFromTube = 6;
  
  touchState[receivedFromTube] = 0;
 
  alreadyReceived = false;
}