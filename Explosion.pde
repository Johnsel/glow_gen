import toxi.util.events.*;

interface ExplosionEndedListener {
  void explosionEnded(int tubeNumber);
}

class Explosion {
  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;
  
  private int touchLocation;
  private int startTime;
  
  private boolean _shouldFadeToBlack;
  private int _shouldFadeToBlackSpeed;
  
  public EventDispatcher<ExplosionEndedListener> dispatcher =new EventDispatcher<ExplosionEndedListener>();
  
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
      explosionCenter(c1, c2, this.tubeModulus, this.tripodNumber);
    }
    if (this.touchLocation == 2) {
      explosionCenter(c1, c2, this.tubeModulus, this.tripodNumber);
    }
    if (this.touchLocation == 3) {
      explosionCenter(c1, c2, this.tubeModulus, this.tripodNumber);
    }
  }
  
  void explosionCenter(color c1, color c2, int tubeModulus, int tripodNumber) {
    pushMatrix();
    
    translate(tubeModulus * (numLEDsPerTube * rectWidth) + (tubeModulus * 20 + 20), tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
  
    float cycleLength = 60;    // total frames for a round trip
    float t = ((frameCount-1)*1./cycleLength) % 1.;
    float a = 0.7;
    float v = AULib.wave(AULib.WAVE_BIAS, t, a);
    float x = v * (tubeLength - rectWidth) / 2;
    color c = lerpColor(c2, c1, v);
    
    println("explosion render fn" + x + " " + c + " " + v);
    
    fill(c);
    
    _shouldFadeToBlack = true;
    shouldTubeFadeToBlack();
    _shouldFadeToBlackSpeed = 10;
    
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
  
  private void finished() {
     // TODO: determine if the explosion is finished
     
     // now, send an event to each listener   
     for(ExplosionEndedListener l : dispatcher) {
        l.explosionEnded(this.tubeNumber);
      }
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