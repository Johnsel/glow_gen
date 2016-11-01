class explosionLightPoint {

  int tubeModulus, tripodNumber, frameCountStart, yPosition, fadeAmount;
  float xPosition, distanceExplosionRight, totalDistanceExplosionRight, time, multiplierSpeed, speedExplosion, movedDistance, distanceTubeOneExplosionRight, distanceTubeOneExplosionLeft, totalDistanceExplosionLeft, distanceExplosionLeft, durationExplosion;

  explosionLightPoint(int tubeModulus, int tripodNumber, float xPosition) {
    this.xPosition = tubeLength / 2;

    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    distanceTubeOneExplosionRight = tubeLength - xPosition;

    distanceTubeOneExplosionLeft = xPosition;

    totalDistanceExplosionRight = (tubeLength - xPosition) + tubeLength;

    totalDistanceExplosionLeft = this.xPosition + tubeLength;

    println(totalDistanceExplosionLeft);

    frameCountStart = frameCount;

    durationExplosion = 60*3;
    
    println("explosion added at " + this.tubeModulus + " , " + this.tripodNumber);
  }

  void move() {      

    time = map(frameCount, frameCountStart, frameCountStart + durationExplosion, 0, 1);

    multiplierSpeed = AULib.wave(AULib.WAVE_BIAS, time, 0.85);
    //multiplierSpeed = AULib.ease(AULib.EASE_OUT_BACK, time);

    //println(multiplierSpeed);

    distanceExplosionRight = map(multiplierSpeed, 0, 1, this.xPosition, totalDistanceExplosionRight);
    distanceExplosionLeft = map(multiplierSpeed, 0, 1, 0, totalDistanceExplosionLeft + rectWidth);

    //println(distanceExplosionLeft);
  }

  void display() {

    pushMatrix();
    translate((tubeModulus - 1) * (numLEDsPerTube * rectWidth) + (tubeModulus * 20), tripodNumber * 21);

    //Explosion to right    
    for (float i = this.xPosition; i <= distanceExplosionRight; i+=rectWidth) {
      pushStyle();      
      fill(255 - fadeAmount);
      rect(i, yPosition, rectWidth, rectWidth);
      popStyle();
      if ( i >= distanceTubeOneExplosionRight) {
        break;
      }
    }

    if (distanceExplosionRight > tubeLength) {
      for (float i = 0; i <= distanceExplosionRight - distanceTubeOneExplosionRight; i+=rectWidth) {
        pushStyle();      
        fill(255 - fadeAmount);      
        rect(i, yPosition + 21, rectWidth, rectWidth);
        popStyle();
      }
    }

    //explosion to left
    for (float i = this.xPosition; i >= this.xPosition - distanceExplosionLeft; i-=rectWidth) {
      pushStyle();      
      fill(255  - fadeAmount);
      rect(i, yPosition, rectWidth, rectWidth);
      popStyle();
      if ( i <= 0) {
        break;
      }
    }

    if (distanceExplosionLeft >= distanceTubeOneExplosionLeft) {
      for (float i = tubeLength; i > (tubeLength - (distanceExplosionLeft - this.xPosition)); i-=rectWidth) {
        pushStyle();      
        fill(255 - fadeAmount);      
        rect(i, yPosition - 21, rectWidth, rectWidth);
        popStyle();
      }
    }

    popMatrix();
  } 

  boolean endExplosionLightPoint() {
    if (time > 0.8) {
      fadeAmount = int(map(time, 0.8, 1.0, 0, 255));
    }
    if (fadeAmount >= 255) {
      return true;
    } else {
      return false;
    }
  }
}