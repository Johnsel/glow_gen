import AULib.*;

/*
 * 
 */

//lightPoint lightPoint;
//lightPoint lightPoint1;
//lightPoint lightPoint2;
//lightPoint lightPoint3;

ArrayList<lightPoint> lightPoints;

int numTripods = 40 ;
int numTubes = numTripods * 3;
int numLEDsPerTube = 56;

int rectWidth = 9;
int rectHeight = 9;
int tubeLength = rectWidth * numLEDsPerTube;

int x;
int y;

void setup() {
  //framerate();
  size(1700, 890, P2D);
  background(255);
  noStroke();

  frameRate(60);

  defineColors(); // we can use defineColors later on to change colors (periodically or with input)

  drawRaster(); // drawRaster helps us with the LED mapping in ELM

  //lightPoint = new lightPoint(1, 6);

  //lightPoint1 = new lightPoint(2, 6);

  //lightPoint2 = new lightPoint(3, 6);

  //lightPoint3 = new lightPoint(1, 20);

  lightPoints = new ArrayList<lightPoint>();

  lightPoints.add(new lightPoint(1, 6));
}

void draw() {
  //println(int(frameRate));
   
  surface.setTitle(int(frameRate) + " fps"); //Display FPS in title
  
  lightUpCompleteConstruction();
  
  // def: (int x, int y, float w, float h, color c1, color c2, int tubeNumber, int tripodNumber)
  //setGradient(x, y, numLEDsPerTube * rectWidth, rectHeight, c2, c1, 2, 10);

  //background(0); //IMPORTANT animate all

  

  //explosionCenter(c1, c2, 1, 1);


  for (int i = lightPoints.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    lightPoint lightpoint = lightPoints.get(i);
    lightpoint.endTube();
    lightpoint.move();
    lightpoint.display();
    //if (lightpoint.finished()) {
    //  // Items can be deleted with remove()
    //  lightPoints.remove(i);
    //}
  }
  
  //println(lightPoints.size());
  
  drawRaster();
  
  selectingSystem();

  /* the idea is that something in the draw function creates a rectangle coming in from the left, or right. So with movement
   the setGradient feature is made to give an idea how this can be done for each tube.
   */
}

void mousePressed() {
  println("mousePressed");
  // A new ball object is added to the ArrayList (by default to the end)
  lightPoints.add(new lightPoint(int(random(1, 3.9)), int(random(1, 39))));
}

void keyPressed() { 
  /* this function can be used as an input later on
   * so if we type in 1, 2, or 3 (which is sensor 1, 2, or 3 of one tube) something will happen with the corrosponding tube
   * maybe we can build in something to select a certain tube we want to give input to using the arrows up and down
   */

  //int keyIndex = -1;
  //if (key == '1') {
  //  keyIndex = key - 'A';
  //} else if (key >= 'a' && key <= 'z') {
  //  keyIndex = key - 'a';
  //}
  
  
  //Movement of the selectingsystem
  if (key == CODED) {
    if (keyCode == LEFT) {
      currentSelectedTube --;
    }
    if (keyCode == RIGHT) {
      currentSelectedTube ++;
    }
    if (keyCode == UP){
      currentSelectedTripod --;
    }
    if (keyCode == DOWN){
      currentSelectedTripod ++;
    }
  }
  //Adding lightpoints at selected tripod/tube
  if (key == ENTER){
    lightPoints.add(new lightPoint(currentSelectedTube, currentSelectedTripod));
  }


}