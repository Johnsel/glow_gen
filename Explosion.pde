
class Explosion {
  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;
  
  private int touchLocation;
  private int startTime;
  
  private boolean _shouldFadeToBlack;
  private int _shouldFadeToBlackSpeed;
  
  Explosion(int startTime, int touchLocation, int tubeNumber) {
    this.touchLocation = touchLocation;
    this.startTime = startTime;
    
    this.tubeNumber = tubeNumber;
    this.tubeModulus = tubeNumber % 3;
    this.tripodNumber = tubeNumber / 3;
  }
  
  void update(int currentTime) {
    if (this.touchLocation == 0) {
      this._shouldFadeToBlack = true;
      this._shouldFadeToBlackSpeed = 10;
    }
    if (this.touchLocation == 1) {
      println("testtl1");
      explosionCenter(c1, c2, this.tubeNumber, this.tripodNumber);
    }
    if (this.touchLocation == 2) {
      explosionCenter(c1, c2, this.tubeNumber, this.tripodNumber);
    }
    if (this.touchLocation == 3) {
      explosionCenter(c1, c2, this.tubeNumber, this.tripodNumber);
    }
  }
  
  void explosionCenter(color c1, color c2, int tubeNumber, int tripodNumber) {
    pushMatrix();
    
    println("explosion render fn" + tubeNumber + tripodNumber);
    
    translate(tubeNumber * (numLEDsPerTube * rectWidth) + (tubeNumber * 20 + 20), tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
  
    float cycleLength = 60;    // total frames for a round trip
    float t = ((frameCount-1)*1./cycleLength) % 1.;
    float a = 0.7;
    float v = AULib.wave(AULib.WAVE_BIAS, t, a);
    float x = v * (tubeLength - rectWidth) / 2;
    color c = lerpColor(c2, c1, v);
    
    fill(c);
    
    //lighteffect.fadeToBlackBy(10);
    
    rect(tubeLength/2 - x - rectWidth, 0, rectWidth, rectHeight);
    rect(tubeLength/2 + x, 0, rectWidth, rectHeight);
    
    popMatrix();
  }
  
  void explosionRight(color c1, color c2, int tubeNumber, int tripodNumber) {
    pushMatrix();
    translate(tubeNumber * (numLEDsPerTube * rectWidth) + (tubeNumber * 20 + 20), tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
  
    float cycleLength = 60;    // total frames for a round trip
    float t = ((frameCount-1)*1./cycleLength) % 1.;
    float a = 0.7;
    float v = AULib.wave(AULib.WAVE_BIAS, t, a);
    float x = v * (tubeLength - rectWidth) / 2;
    color c = lerpColor(c2, c1, v);
    
    fill(c);
    
    //lighteffect.fadeToBlackBy(10);
    
    rect(tubeLength - x - rectWidth, 0, rectWidth, rectHeight);
    
    popMatrix();
  }
  
  void explosionLeft(color c1, color c2, int tubeNumber, int tripodNumber) {
    pushMatrix();
    translate(tubeNumber * (numLEDsPerTube * rectWidth) + (tubeNumber * 20 + 20), tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
  
    float cycleLength = 60;    // total frames for a round trip
    float t = ((frameCount-1)*1./cycleLength) % 1.;
    float a = 0.7;
    float v = AULib.wave(AULib.WAVE_BIAS, t, a);
    float x = v * (tubeLength - rectWidth) / 2;
    color c = lerpColor(c2, c1, v);
    
    fill(c);
    
    //lighteffect.fadeToBlackBy(10);
    
    rect(tubeLength/2 - x - rectWidth, 0, rectWidth, rectHeight);
    rect(tubeLength/2 + x, 0, rectWidth, rectHeight);
    
    popMatrix();
  }
  
  boolean finished() {
     // TODO: determine if the explosion is finished
     
     return false;
  }
  
  int shouldTubeFadeToBlack() {
    if (_shouldFadeToBlack) {
      return _shouldFadeToBlackSpeed;
    }
    else {
      return -1;
    }
  } 
}