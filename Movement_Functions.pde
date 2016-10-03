
void setGradient(int x, int y, float w, float h, color c1, color c2, int tubeNumber, int tripodNumber) {
  pushMatrix();
  translate((tubeNumber - 1) * (numLEDsPerTube * rectWidth) + (tubeNumber * 20), tripodNumber * 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
  
  noFill();

  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, b1, inter);
    stroke(c);
    line(i, y, i, y+h);
  }
  popMatrix();
}

void explosionCenter(color c1, color c2, int tubeNumber, int tripodNumber) {
  pushMatrix();
  translate((tubeNumber - 1) * (numLEDsPerTube * rectWidth) + (tubeNumber * 20), tripodNumber * 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber

  float cycleLength = 60;    // total frames for a round trip
  float t = ((frameCount-1)*1./cycleLength) % 1.;
  float a = 0.7;
  float v = AULib.wave(AULib.WAVE_BIAS, t, a);
  float x = v * (tubeLength - rectWidth) / 2;
  color c = lerpColor(c2, c1, v);
  
  fill(c);
  
  fadeToBlackBy(10);
  
  rect(tubeLength/2 - x - rectWidth, 0, rectWidth, rectHeight);
  rect(tubeLength/2 + x, 0, rectWidth, rectHeight);
  
  popMatrix();
}