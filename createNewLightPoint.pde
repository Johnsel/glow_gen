//TODO Add smooth animation from fade to new lightpoint

class createNewLightPoint {

  int tubeModulus, tripodNumber, touchLocation, randomAnimationSpeed, endLocationFade, distanceFadeInTube;
  float maxDistanceInTube, j, interimEndLocationFade, maxFadeDistanceInTube, minFadeDistanceInTube;

  int durationFadeIn, durationFadeOut, livingTime;

  int colorVariationLightPoint;
  float lightpointXColor, noiseColor;
  color colorLightPoint;


  boolean fadeOut = false;
  float timeInterim, interimDistanceFadeInTube;

  float time = 1;

  float distanceFadeInTubeStart;
  int startFadeOutFrameCount;
  boolean getStartValues = true;


  createNewLightPoint(int tubeModulus, int tripodNumber, int touchLocation) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    this.touchLocation = touchLocation;

    maxFadeDistanceInTube = 250;
    minFadeDistanceInTube = 30;

    //maxFadeDistanceInTubeTouch1 = tubeLength - (tubeLength / 2);
    //maxFadeDistanceInTubeTouch0 = tubeLength / 2;

    randomAnimationSpeed = int(random(0, 2.99));

    //Defined in frames
    durationFadeIn = 30;

    colorVariationLightPoint = 1;

    durationFadeOut = 40;

    println(touchLocation);
  }

  void move() {

    livingTime ++;

    j+=0.05;

    switch (randomAnimationSpeed) {
    case 0:
      interimEndLocationFade= (-((sin (3*(j-0.584))*cos (0.8*(j-0.584))+cos (0.5*(j-0.584))*sin(2*(j-0.584))+cos (0.8*(j-0.584)))-2.85)/4.8);
      break;
    case 1:
      interimEndLocationFade = (((sin (2*(j-0.584))*sin(0.5*(j-0.584))+cos(0.5*(j-0.584))*sin(05*(j-0.584))+cos(0.8*(j-0.584)))+2.85)/4.8);
      break;
    case 2:
      interimEndLocationFade = (((sin(3*(j-0.584))*cos(0.8*(j-0.584))+cos(0.5*(j-0.584))*sin(2*(j-0.584))+cos(0.8*(j-0.584)))+2.85)/4.8);
      break;
    }
    if (livingTime < durationFadeIn) {
      distanceFadeInTube = int(map(livingTime, 0, durationFadeIn, 0, int(map(interimEndLocationFade, 0, 1, minFadeDistanceInTube, maxFadeDistanceInTube))));
    } else {
      //distanceFadeInTube ++
      distanceFadeInTube = constrain(int(map(interimEndLocationFade, 0, 1, minFadeDistanceInTube, maxFadeDistanceInTube)), int(minFadeDistanceInTube), int(maxFadeDistanceInTube));
    }
    //println(distanceFadeInTube + "," + this.touchLocation);
  }



  void display() {

    if (fadeOut == false) {

      this.lightpointXColor += 0.01;

      noiseColor = ((sin(this.lightpointXColor)*cos(6*this.lightpointXColor)+cos(6*this.lightpointXColor)*sin(this.lightpointXColor))/4)+0.5;

      //For looping the animation of color
      if (this.lightpointXColor > ((5*PI)/2)) {
        this.lightpointXColor = -1;
      }

      if (colorVariationLightPoint == 0) {
        colorLightPoint = lerpColor(e1, e1_1, noiseColor);
      }
      if (colorVariationLightPoint == 1) {
        colorLightPoint = lerpColor(e2, e2_1, noiseColor);
      }
      if (colorVariationLightPoint == 2) {
        colorLightPoint = lerpColor(e3, e3_1, noiseColor);
      }
    }

    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeModulus and tripodNumber

    if (this.touchLocation == 0) {
      for (int i = 0; i < distanceFadeInTube; i++) {
        pushStyle(); 
        int opacity = int(map(i, 0, distanceFadeInTube, 255, 0));
        fill(colorLightPoint, opacity);
        rect(i, 0, 1, rectHeight);

        popStyle();
      }
    }

    if (this.touchLocation == 1) {
      for (int i = tubeLength; i > tubeLength - distanceFadeInTube; i--) {
        pushStyle();

        int opacity = int(map(i, tubeLength, tubeLength - distanceFadeInTube, 255, 0));
        fill(colorLightPoint, opacity);
        rect(i, 0, 1, rectHeight);


        popStyle();
      }
    }
    popMatrix();
  }

  void fadeOut() {

    if (getStartValues) {
      distanceFadeInTubeStart = distanceFadeInTube;
      startFadeOutFrameCount = frameCount;
      getStartValues = false;
    }

    time = map(frameCount, startFadeOutFrameCount, startFadeOutFrameCount + durationFadeOut, 1, 0);

    interimDistanceFadeInTube = AULib.wave(AULib.WAVE_BIAS, time, 0.7);
    //multiplierSpeed = AULib.ease(AULib.EASE_OUT_BACK, time);

    distanceFadeInTube = int(map(interimDistanceFadeInTube, 1, 0, distanceFadeInTubeStart, 0));
  }

  boolean fadeOutDone() {
    if (time < 0.1) {
      return true;
    } else {
      return false;
    }
  }
}