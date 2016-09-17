/*
 * 
 */

int rectWidth = 9;
int rectHeight = 9;
int x;
int y;

int numTripods = 40;
int numTubes = numTripods * 3;
int numLEDsPerTube = 56;

color b1, b2, c1, c2;
   
void setup() {
  size(1600, 900);
  background(0);
  noStroke();
    
  defineColors(); // we can use defineColors later on to change colors (periodically or with input)
  
  drawRaster(); // drawRaster helps us with the LED mapping in ELM
}

void draw() { 
  setGradient(x, y, numLEDsPerTube * rectWidth, rectHeight, c2, c1, 1, 1); // draws a rectangle with gradient on position x, y, with width ... height, from color c2 to color c1, for tube 1 of tripod 1

  /* the idea is that something in the draw function creates a rectangle coming in from the left, or right. So with movement
  the setGradient feature is made to give an idea how this can be done for each tube.
  */
}

void keyPressed() { 
/* this function can be used as an input later on
 * so if we type in 1, 2, or 3 (which is sensor 1, 2, or 3 of one tube) something will happen with the corrosponding tube
 * maybe we can build in something to select a certain tube we want to give input to using the arrows up and down
*/

  int keyIndex = -1;
  if (key == '1') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
}