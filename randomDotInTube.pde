class RandomDotInTube {

  int tubeModulus, tripodNumber, opacity, frameCountStart, livingTimeDot, delayTime;
  float xPosition, time, interimOpacity, endTimeDot;
  
  color startColor = color(255,234,0);
  color endColor = color(255,80,0);
  color colorDot;
  
  float interimColor;
  int frameCountStartExplosion, durationExplosion;

  RandomDotInTube(int tubeModulus, int tripodNumber, int xPosition, int frameCountStartExplosion, int durationExplosion) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    this.xPosition = xPosition;

    this.delayTime = int(random(0, 20));

    frameCountStart = frameCount + delayTime;

    livingTimeDot = 60;

    endTimeDot = frameCountStart + livingTimeDot + this.delayTime;
    
    this.frameCountStartExplosion = frameCountStartExplosion;
    
    this.durationExplosion = durationExplosion;

    println(this.tubeModulus, this.tripodNumber);
  }

  void display() {

    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21); 

    time = map(frameCount, frameCountStart, endTimeDot, 0, 1);

    interimOpacity = AULib.wave(AULib.WAVE_SYM_VAR_BLOB, time, 0.2);

    opacity = int(map(interimOpacity, 0, 1, 0, 255));


    pushStyle();
    interimColor = map(frameCount, this.frameCountStartExplosion, this.frameCountStartExplosion + this.durationExplosion, 0, 1);
    colorDot = lerpColor(startColor, endColor, interimColor);
    fill(colorDot, opacity);
    rect(xPosition, 0, rectWidth, rectHeight);

    popStyle();
    popMatrix();
  }

  boolean finished() {
    if (frameCount > frameCountStart + livingTimeDot) {
      return true;
    } else {
      return false;
    }
  }
}