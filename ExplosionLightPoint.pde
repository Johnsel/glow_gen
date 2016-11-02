class explosionLightPoint {

  int tubeModulus, tripodNumber, frameCountStart, yPosition;
  float xPosition, distanceExplosionRight, totalDistanceExplosionRight, time, multiplierSpeed, speedExplosion, movedDistance, distanceTubeOneExplosionRight, distanceTubeOneExplosionLeft, totalDistanceExplosionLeft, distanceExplosionLeft, durationExplosion;

  float fadeAmount = 200;

  explosionLightPoint(int tubeModulus, int tripodNumber, float xPosition) {
    this.xPosition = tubeLength / 2;

    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    distanceTubeOneExplosionRight = tubeLength -  this.xPosition;

    distanceTubeOneExplosionLeft =  this.xPosition;

    totalDistanceExplosionRight = (tubeLength -  this.xPosition) + tubeLength;

    totalDistanceExplosionLeft = this.xPosition + tubeLength;

    frameCountStart = frameCount;

    durationExplosion = 60*1.5;
  }

  void move() {      

    time = map(frameCount, frameCountStart, frameCountStart + durationExplosion, 0, 1);

    multiplierSpeed = AULib.wave(AULib.WAVE_BIAS, time, 0.8);
    //multiplierSpeed = AULib.ease(AULib.EASE_OUT_BACK, time);

    //println(multiplierSpeed);

    distanceExplosionRight = map(multiplierSpeed, 0, 1, 0, totalDistanceExplosionRight);
    distanceExplosionLeft = map(multiplierSpeed, 0, 1, 0, totalDistanceExplosionLeft + rectWidth);

    //println(distanceExplosionRight);
  }

  void display() {

    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeModulus and tripodNumber

    //Explosion to right    
    //println(this.xPosition + " , " + distanceExplosionRight);

    // + rectWidth for fixing the overlapping rectangle in the middle of the explosion
    for (float i = this.xPosition + rectWidth; i <= distanceExplosionRight + this.xPosition; i+=rectWidth) {
      pushStyle();      
      fill(255, fadeAmount);
      rect(i, yPosition, rectWidth, rectWidth);
      popStyle();
      if ( i >= distanceTubeOneExplosionRight + this.xPosition) {
        break;
      }
    }

    if (tripodNumber < 39) {
      if (distanceExplosionRight > distanceTubeOneExplosionRight) {
        for (float i = 0; i <= distanceExplosionRight - distanceTubeOneExplosionRight; i+=rectWidth) {
          pushStyle();      
          fill(255, fadeAmount);      
          rect(i, yPosition + 21, rectWidth, rectWidth);
          popStyle();
        }
      }
    }

    //explosion to left
    for (float i = this.xPosition; i >= this.xPosition - distanceExplosionLeft; i-=rectWidth) {
      pushStyle();      
      fill(255, fadeAmount);
      rect(i, yPosition, rectWidth, rectWidth);
      popStyle();
      if ( i <= 0) {
        break;
      }
    }

    if (tripodNumber > 0) {
      if (distanceExplosionLeft >= distanceTubeOneExplosionLeft) {
        for (float i = tubeLength; i > (tubeLength - (distanceExplosionLeft - this.xPosition)); i-=rectWidth) {
          pushStyle();      
          fill(255, fadeAmount);      
          rect(i, yPosition - 21, rectWidth, rectWidth);
          popStyle();
        }
      }
    }

    popMatrix();
  }

  boolean endExplosion() {
    if (multiplierSpeed > 0.4) {
      fadeAmount = map(multiplierSpeed, 0.4, 1.0, 200, 10);
    }

    if (multiplierSpeed > 0.99) {
      return true;
    } else {
      return false;
    }
  }
}