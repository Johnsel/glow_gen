

class Explosions {
  Explosions() {
    
  }
  
  void update(int position, int tubeNumber, int tripodNumber) {
    if (position == 1) {
      explosionCenter(c1, c2, tubeNumber, tripodNumber);
    }
    if (position == 2) {
      explosionCenter(c1, c2, tubeNumber, tripodNumber);
    }
    if (position == 3) {
      explosionCenter(c1, c2, tubeNumber, tripodNumber);
    }
  }
  
  void explosionCenter(color c1, color c2, int tubeNumber, int tripodNumber) {
    pushMatrix();
    translate(tubeNumber * (numLEDsPerTube * rectWidth) + (tubeNumber * 20 + 20), tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
  
    float cycleLength = 60;    // total frames for a round trip
    float t = ((frameCount-1)*1./cycleLength) % 1.;
    float a = 0.7;
    float v = AULib.wave(AULib.WAVE_BIAS, t, a);
    float x = v * (tubeLength - rectWidth) / 2;
    color c = lerpColor(c2, c1, v);
    
    fill(c);
    
    lighteffect.fadeToBlackBy(10);
    
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
    
    lighteffect.fadeToBlackBy(10);
    
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
    
    lighteffect.fadeToBlackBy(10);
    
    rect(tubeLength/2 - x - rectWidth, 0, rectWidth, rectHeight);
    rect(tubeLength/2 + x, 0, rectWidth, rectHeight);
    
    popMatrix();
  }
}