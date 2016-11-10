class TouchAnimation {

  int tubeModulus, tripodNumber, touchLocation;
  float seedY;


  TouchAnimation(int tubeModulus, int tripodNumber, int touchLocation) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    this.touchLocation = touchLocation;

    seedY = random(0, 30);
    
    
  }

  void display() {
    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeModulus and tripodNumber
    pushStyle();

    float y = map(noise(0, seedY), 0, 1, 0, 20);
    fill(155, 241, 255, y);
    seedY += 0.1;

    if (this.touchLocation == 0) {
      rect(0, 0, tubeLength/2, rectHeight);
    }

    if (this.touchLocation == 1) {
      rect(tubeLength/2, 0, tubeLength/2, rectHeight);
    }
    popStyle();
    popMatrix();
  }
}