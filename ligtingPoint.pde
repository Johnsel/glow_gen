class lightPoint {

  int tubeNumberClass, tripodNumberClass, movementDirection, randomSpeed, colorVarationLightPoint, colorVariationLightPoint;
  float xPosition, yPosition, speedPoint, maximumLengthPointTale, lengthPointHead, j, lengthPointTale, noiseColor, lightpointXColor, fadeOutAmount, lenghtPointMain, lenghtPointMainCompensationFade;
  boolean readyToRemoveLightPoint;

  color colorLightPoint;

  lightPoint(int tubeNumber, int tripodNumber) {
    speedPoint = 1;
    maximumLengthPointTale = rectWidth*15;
    lengthPointHead = rectWidth*4;
    lenghtPointMain = rectWidth*10;

    tubeNumberClass = tubeNumber;
    tripodNumberClass = tripodNumber;

    movementDirection = int(random(0, 1.99)); //0-right 1-left

    randomSpeed = int(random(0, 2.99));
    //Determine the starting position of the lightpoint
    if (movementDirection == 0) {
      xPosition = 0 - lengthPointHead - lenghtPointMain;
    }
    if (movementDirection == 1) {
      xPosition = tubeLength + lengthPointHead + lenghtPointMain;
    }

    //Select a random begin for the speed function
    j = random(0, 62);

    //Select one of the options for color schemes of the lightpoint
    colorVariationLightPoint = 1; //Three color schemes implemented right now

    //Select a random begin for the color fading of the lightpoint to begin
    lightpointXColor = random(0, 4);

    println("new point generated, at " + tubeNumber + "," + tripodNumber + " with color variation " + colorVariationLightPoint);
  }

  void move() {

    //println(randomSpeed);
    //calculating movement speed
    j=j+0.002; //Determine how quickly the speed changes 

    switch (randomSpeed) {
    case 0:
      speedPoint = -((sin(3*(j-0.584))*cos(0.8*(j-0.584))+cos(0.5*(j-0.584))*sin (2*(j-0.584))+cos (0.8*(j-0.584)))-2.85)/4;
      break;
    case 1:
      speedPoint = ((sin (2*(j-0.584))*sin(0.5*(j-0.584))+cos(0.5*(j-0.584))*sin(05*(j-0.584))+cos(0.8*(j-0.584)))+2.85)/4;
      break;
    case 2:
      speedPoint = ((sin(3*(j-0.584))*cos(0.8*(j-0.584))+cos(0.5*(j-0.584))*sin(2*(j-0.584))+cos(0.8*(j-0.584)))+2.85)/4;
      break;
    }
    //speedPoint = (sin(3*(j+19.548))*cos(0.5*(j+19.548))+cos(0.5*(j+19.548))*sin(2*(j+19.548))+1.865)/3;
    if (j > 62.8) {
      j = 0;
    }
    //println(speedPoint);


    //Calculating x position of point within tube
    if (movementDirection == 0) {
      xPosition = xPosition + speedPoint;
    }
    if (movementDirection == 1) {
      xPosition = xPosition - speedPoint;
    }
    //println(movementDirection);
  }

  void endTube() {
    if (movementDirection == 0) {
      if (xPosition - lengthPointTale >= tubeLength) {
        tripodNumberClass ++; 
        xPosition = 0 - lengthPointHead - lenghtPointMain ;
      }
    }
    if (movementDirection == 1) {
      if (xPosition <= 0 - lengthPointTale) {
        tripodNumberClass --; 
        xPosition = tubeLength + lengthPointHead + lenghtPointMain;
      }
    }
    if (tripodNumberClass > 40) {
      println("executed");
      tripodNumberClass = 1;
    }
    if (tripodNumberClass < 1) {
      tripodNumberClass = numTripods;
    }
  }

  void display() {
    //Calculate length of tale point with regards to the speed of point
    //1.243 maximum of sinus function
    lengthPointTale = map(speedPoint, 0, 1.243, 20, maximumLengthPointTale);

    lenghtPointMainCompensationFade = lenghtPointMain / 2;
    
    lightpointXColor+=0.001;
    noiseColor = ((sin(lightpointXColor)*cos(6*lightpointXColor)+cos(6*lightpointXColor)*sin(lightpointXColor))/4)+0.5;

    //For looping the animation of color
    if (lightpointXColor > ((5*PI)/2)) {
      lightpointXColor = -1;
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



    pushMatrix();
    translate((tubeNumberClass - 1) * (numLEDsPerTube * rectWidth) + (tubeNumberClass * 20), tripodNumberClass * 21);
    //Movement left
    if (movementDirection == 1) { 
      //gradient to right
      for (float i = xPosition; i <= xPosition+lengthPointTale; i+=rectWidth) {
        pushStyle();
        float inter = map(i, xPosition, xPosition+lengthPointTale, 255, 0);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
          fill(colorLightPoint, inter);
          rect(i, yPosition, rectWidth, rectWidth);
        }
        popStyle();
      }

      //smooth out lightpoint infront
      for (float i = xPosition; i > xPosition-lengthPointHead; i-=rectWidth) {
        pushStyle();
        float inter = map(i, xPosition-lengthPointHead, xPosition, 0, 255);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
          fill(colorLightPoint, inter);
          rect(i, yPosition, rectWidth, rectWidth);
        }
        popStyle();
      }
    }
    //Movement right
    if (movementDirection == 0) {
      //gradient to left
      for (float i = xPosition; i >= xPosition-lengthPointTale-lenghtPointMain; i-=rectWidth) {
        pushStyle();
        float inter = map(i, xPosition-lengthPointTale, xPosition, 0, 255);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
          fill(colorLightPoint, inter);
          rect(i, yPosition, rectWidth, rectWidth);
        }
        popStyle();
      }

      //Center of the point
      for (float i = xPosition; i < xPosition + lenghtPointMain; i+=rectWidth) {
        pushStyle();
        if (i >= 0 - rectWidth && i<=tubeLength) {
          fill (colorLightPoint);
          rect(i, yPosition, rectWidth, rectWidth);
        }
        popStyle();
      }

      //smooth out lightpoint infront
      for (float i = xPosition + lenghtPointMain; i <= xPosition+lengthPointHead+lenghtPointMain; i+=rectWidth) {
        pushStyle();

        float inter = map(i, xPosition + lenghtPointMain, xPosition+lengthPointHead+lenghtPointMain, 255, 0);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
          fill(colorLightPoint, inter-fadeOutAmount);
          rect(i, yPosition, rectWidth, rectWidth);
        }
        popStyle();
      }
    }
    popMatrix();
  }

  void fadeOut() {
    if (readyToRemoveLightPoint) {
      fadeOutAmount++;
    }
  }
}