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

boolean alreadyReceived = false; // only needed for key-triggered simulation stuff

int selectedTube;

Tube[] tubes = new Tube[numTubes];

void setup() {
  size(1600, 880, P2D);
  background(0);
  noStroke();
  font = createFont("Arial Bold", 48);
    
  tubes.listeners.addListener(new moveListener());
  
  

  for (int i=0; i< numTubes; i++) {
    tubes[i] = new Tube(i);
  }

  defineColors(); // we can use defineColors later on to change colors (periodically or with input)

  drawRaster(); // drawRaster helps us with the LED mapping in ELM
}

void draw() {
  // def: (int x, int y, float w, float h, color c1, color c2, int tubeNumber, int tripodNumber)
  //setGradient(x, y, numLEDsPerTube * rectWidth, rectHeight, c2, c1, 2, 10);

  //Background
  lightUpCompleteConstruction();

  for (int i=0; i<numTubes; i++) {
    tubes[i].update();
  }

  ShowFrameRate();

  selectingSystem();

  drawRaster();

  /* the idea is that something in the draw function creates a rectangle coming in from the left, or right. So with movement
   the setGradient feature is made to give an idea how this can be done for each tube.
   */
}

class moveListener implements moveLightPointListener {
  void moveLightPoint(int tubeNumber, int movementDirection) {
    println("moveLightPoint to" + tubeNumber + 1);
  }
} 

void keyPressed() { 
  /* this function can be used as an input later on
   * so if we type in 1, 2, or 3 (which is sensor 1, 2, or 3 of one tube) something will happen with the corrosponding tube
   * maybe we can build in something to select a certain tube we want to give input to using the arrows up and down
   */
  //int sendingTube = 6;

  //if (alreadyReceived == false) {
  //  if (key > '0' && key < '4') {

  //    int touchLocation = key - 48;

  //    println("sending touched to tube on direction " + touchLocation);

  //    tubes[sendingTube].isTouched(touchLocation);
  //  }
  //  alreadyReceived = true;
  //}

  //Selecting system for adding objects
  if (key == CODED) {
    if (keyCode == LEFT) {
      currentSelectedTube --;
    }
    if (keyCode == RIGHT) {
      currentSelectedTube ++;
    }
    if (keyCode == UP) {
      currentSelectedTripod --;
    }
    if (keyCode == DOWN) {
      currentSelectedTripod ++;
    }
  }

  if (key == ENTER) {
    selectedTube = (currentSelectedTripod*3)+currentSelectedTube;
    tubes[selectedTube].addLightPoint();
    println("added lightpoint at" + selectedTube);
  }
}

void keyReleased() {
  //int sendingTube = 6;

  //// this simulates receiving sensordata "0" zero, indicating that the touch has stopped.
  //alreadyReceived = false;

  //println("sending untouched to tube");

  //tubes[sendingTube].isUntouched();
}