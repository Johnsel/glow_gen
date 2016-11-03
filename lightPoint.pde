
class lightPoint {

  int tubeModulus, tripodNumber, movementDirection, randomSpeed, colorVarationLightPoint, colorVariationLightPoint, countGrowing, lenghtPointMain;
  float xPosition, yPosition, speedPoint, maximumLengthPointTale, lengthPointHead, j, lengthPointTale, noiseColor, lightpointXColor, fadeOutAmount, lenghtPointMainCompensationFade, multiplierGrow, speedGrowing;
  boolean readyToRemoveLightPoint;

  boolean lightPointGrowing = false;
  boolean lightPointReleased = false;

  color colorLightPoint;

  int timeCount, timeCountSpeedMultiplier;
  float time, multiplierSpeed, totalDistanceGrowingRight, distanceGrowingLeft, distanceGrowingRight, timeSpeed;

  lightPoint(int tubeModulus, int tripodNumber, int movementDirection, int randomSpeed, float j, float lightpointXColor, boolean lightPointReleased, int timeCountSpeedMultiplier, int lenghtPointMain) {

    maximumLengthPointTale = rectWidth*0.1;
    lengthPointHead = rectWidth*0.1;

    this.lenghtPointMain = 20*rectWidth;

    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    this.movementDirection = movementDirection; //0-right 1-left

    this.randomSpeed = randomSpeed;
    //Determine the starting position of the lightpoint
    if (this.movementDirection == 0) {
      xPosition = 0 - lengthPointHead - this.lenghtPointMain;
    }
    if (this.movementDirection == 1) {
      xPosition = tubeLength + lengthPointHead + this.lenghtPointMain;
    }

    //Select a random begin for the speed function
    this.j = j;

    //Select one of the options for color schemes of the lightpoint
    colorVariationLightPoint = 0; //Three color schemes implemented right now

    //Select a random begin for the color fading of the lightpoint to begin
    this.lightpointXColor = lightpointXColor;

    this.lightPointReleased = lightPointReleased;

    this.timeCountSpeedMultiplier = timeCountSpeedMultiplier;

    println("new point generated, at " + this.tubeModulus + "," + this.tripodNumber + " with color variation " + colorVariationLightPoint);
  }

  void move() {

    //println(this.randomSpeed);
    //calculating movement speed
    this.j += 0.002; //Determine how quickly the speed changes

    switch (this.randomSpeed) {
    case 0:
      this.speedPoint = (-((sin(3*(this.j-0.584))*cos(0.8*(this.j-0.584))+cos(0.5*(this.j-0.584))*sin (2*(this.j-0.584))+cos (0.8*(this.j-0.584)))-2.85)/2) + multiplierSpeed*5;
      break;
    case 1:
      this.speedPoint = (((sin (2*(this.j-0.584))*sin(0.5*(this.j-0.584))+cos(0.5*(this.j-0.584))*sin(05*(this.j-0.584))+cos(0.8*(this.j-0.584)))+2.85)/2) + multiplierSpeed*5;
      break;
    case 2:
      this.speedPoint = (((sin(3*(this.j-0.584))*cos(0.8*(this.j-0.584))+cos(0.5*(this.j-0.584))*sin(2*(this.j-0.584))+cos(0.8*(this.j-0.584)))+2.85)/2) + multiplierSpeed*5;
      break;
    }
    //this.speedPoint = (sin(3*(this.j+19.548))*cos(0.5*(this.j+19.548))+cos(0.5*(this.j+19.548))*sin(2*(this.j+19.548))+1.865)/3;
    if (this.j > 62.8) {
      this.j = 0;
    }
    //println(this.speedPoint);


    //Calculating x position of point within tube
    if (this.movementDirection == 0) {
      xPosition = xPosition + this.speedPoint;
    }
    if (this.movementDirection == 1) {
      xPosition = xPosition - this.speedPoint;
    }
    //println(this.movementDirection);

    if (lightPointGrowing == false) {
      multiplierGrow = this.speedPoint;
    } else {
      this.speedPoint = multiplierGrow;
    }
  }


  boolean endTube() {
    if (this.movementDirection == 0) {
      if (xPosition - lengthPointTale - (this.lenghtPointMain/2)  >= tubeLength) {
        moveLightPointNextTripod(this.tubeModulus, this.tripodNumber, this.movementDirection, this.randomSpeed, this.j, this.lightpointXColor, this.lightPointReleased, this.timeCountSpeedMultiplier, this.lenghtPointMain);
        return true;
      }
    }
    if (this.movementDirection == 1) {
      if (xPosition <= 0 - lengthPointTale - (lenghtPointMain/2)) {
        moveLightPointNextTripod(this.tubeModulus, this.tripodNumber, this.movementDirection, this.randomSpeed, this.j, this.lightpointXColor, this.lightPointReleased, this.timeCountSpeedMultiplier, this.lenghtPointMain);
        return true;
      }
    }
    return false;

    //if (this.tripodNumber > 40) {
    //  println("executed");
    //  this.tripodNumber = 1;
    //}
    //if (this.tripodNumber < 1) {
    //  this.tripodNumber = numTripods;
    //}
  }

  void display() {
    //Calculate length of tale point with regards to the speed of point
    //1.243 maximum of sinus function
    if (lightPointGrowing) {
      lengthPointTale = map(multiplierGrow, 0, 1.243, rectWidth*10, rectWidth*23);
      //lengthPointHead = map(multiplierGrow, 0, 1.243, rectWidth*5, rectWidth*9);
    } else {
      lengthPointTale = map(this.speedPoint, 0, 1.243, rectWidth*7, maximumLengthPointTale);
      //lengthPointHead = map(this.speedPoint, 1.243, 0, rectWidth*5, rectWidth*9);
    }



    //Includes faster color changing when lightpoint is growing
    if (lightPointGrowing == false) {
      this.lightpointXColor+=0.001;
    } else {
      this.lightpointXColor+=0.02;
    }

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



    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeModulus and tripodNumber
    //Movement left
    if (this.movementDirection == 1) {
      //gradient to right
      //for (float i = xPosition + (this.lenghtPointMain/2); i <= xPosition+lengthPointTale+(this.lenghtPointMain/2); i+=rectWidth) {
      //  pushStyle();
      //  float inter = map(i, xPosition + (this.lenghtPointMain/2), xPosition+lengthPointTale+(this.lenghtPointMain/2), 255, 0);
      //  //color c = lerpColor(c2, b1, inter);

      //  if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
      //    fill(colorLightPoint, inter);
      //    rect(i, yPosition, rectWidth, rectHeight);
      //  }
      //  popStyle();
      //}

      for (float i = xPosition - (this.lenghtPointMain/2); i < xPosition; i+=rectWidth) {
        pushStyle();
        if (i >= 0 - rectWidth && i<=tubeLength) {
          fill (colorLightPoint, 255);
          rect(i, yPosition, rectWidth, rectHeight);
        }
        popStyle();
      }

      for (float i = xPosition; i < xPosition + (this.lenghtPointMain/2); i+=rectWidth) {
        pushStyle();
        if (i >= 0 - rectWidth && i<=tubeLength) {
          fill (colorLightPoint, 255);
          rect(i, yPosition, rectWidth, rectHeight);
        }
        popStyle();
      }

      //smooth out lightpoint infront
      //for (float i = xPosition - (this.lenghtPointMain/2) - rectWidth; i >= xPosition - (this.lenghtPointMain/2) - lengthPointHead; i-=rectWidth) {
      //  pushStyle();
      //  float inter = map(i, xPosition - (this.lenghtPointMain/2) - rectWidth, xPosition - (this.lenghtPointMain/2) - lengthPointHead, 255, 0);
      //  //color c = lerpColor(c2, b1, inter);

      //  if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
      //    fill(colorLightPoint, inter);
      //    rect(i, yPosition, rectWidth, rectHeight);
      //  }
      //  popStyle();
      //}
    }
    //Movement right
    if (this.movementDirection == 0) {
      ////gradient to left
      //for (float i = xPosition - (this.lenghtPointMain/2) - rectWidth; i >= xPosition - lengthPointTale - (this.lenghtPointMain/2); i-=rectWidth) {
      //  pushStyle();
      //  float inter = map(i, xPosition - (this.lenghtPointMain/2) - rectWidth, xPosition - lengthPointTale - (this.lenghtPointMain/2), 255, 0);
      //  //color c = lerpColor(c2, b1, inter);

      //  if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
      //    fill(colorLightPoint, inter);
      //    rect(i, yPosition, rectWidth, rectHeight);
      //  }
      //  popStyle();
      //}

      for (float i = xPosition - (this.lenghtPointMain/2); i < xPosition; i+=rectWidth) {
        pushStyle();
        if (i >= 0 - rectWidth && i<=tubeLength) {
          fill (colorLightPoint, 255);
          rect(i, yPosition, rectWidth, rectHeight);
        }
        popStyle();
      }

      for (float i = xPosition; i < xPosition + (this.lenghtPointMain/2); i+=rectWidth) {
        pushStyle();
        if (i >= 0 - rectWidth && i<=tubeLength) {
          fill (colorLightPoint, 255);
          rect(i, yPosition, rectWidth, rectHeight);
        }
        popStyle();
      }

      //pushStyle();

      //rect(xPosition - (this.lenghtPointMain/2), yPosition, (this.lenghtPointMain/2), rectWidth);
      //rect(xPosition, yPosition, (this.lenghtPointMain/2), rectWidth);

      //popStyle();
      //smooth out lightpoint infront
      for (float i = xPosition + (this.lenghtPointMain/2); i <= xPosition+lengthPointHead+(this.lenghtPointMain/2); i+=rectWidth) {
        pushStyle();

        float inter = map(i, xPosition + (this.lenghtPointMain/2), xPosition+lengthPointHead+(this.lenghtPointMain/2), 255, 0);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 - rectWidth && i<=tubeLength) { //keep within raster
          fill(colorLightPoint, inter);
          rect(i, yPosition, rectWidth, rectHeight);
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

  void growingAndCharging() {
    pushMatrix();
    pushStyle();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);

    if (lightPointGrowing) {
      //Set speed to 0

      if (this.speedPoint != 0) {
        if (this.speedPoint > 0) {
          this.speedPoint -= 0.02;
        } else {
          this.speedPoint += 0.02;
        }
      } else {

        this.j += 0.03; //Determine how quickly the speed changes

        //Same formula used as the moving functions only faster, TODO? Rewrite to make this more efficient
        switch (this.randomSpeed) {
        case 0:
          multiplierGrow = -((sin(3*(this.j-0.584))*cos(0.8*(this.j-0.584))+cos(0.5*(this.j-0.584))*sin (2*(this.j-0.584))+cos (0.8*(this.j-0.584)))-2.85)/4;
          break;
        case 1:
          multiplierGrow = ((sin (2*(this.j-0.584))*sin(0.5*(this.j-0.584))+cos(0.5*(this.j-0.584))*sin(05*(this.j-0.584))+cos(0.8*(this.j-0.584)))+2.85)/4;
          break;
        case 2:
          multiplierGrow = ((sin(3*(this.j-0.584))*cos(0.8*(this.j-0.584))+cos(0.5*(this.j-0.584))*sin(2*(this.j-0.584))+cos(0.8*(this.j-0.584)))+2.85)/4;
          break;
        }
        //this.speedPoint = (sin(3*(this.j+19.548))*cos(0.5*(this.j+19.548))+cos(0.5*(this.j+19.548))*sin(2*(this.j+19.548))+1.865)/3;
        if (this.j > 62.8) {
          this.j = 0;
        }
      }

      //Reset easing animation
      if (this.speedPoint < 0.01 && this.speedPoint > -0.01) {
        this.speedPoint = 0;
      }

      if (this.movementDirection == 0) {
        xPosition = xPosition + this.speedPoint;
      }
      if (this.movementDirection == 1) {
        xPosition = xPosition - this.speedPoint;
      }

      //println("growing");

      timeCount ++;

      if (timeCount > 30) {
        timeCount = 0;
      }

      time = map(timeCount, 0, 30, 0, 1);

      speedGrowing = AULib.wave(AULib.WAVE_BIAS, time, 0.7);

      totalDistanceGrowingRight = tubeLength - xPosition;

      distanceGrowingRight = map(speedGrowing, 0, 1, tubeLength, xPosition);
      distanceGrowingLeft = map(speedGrowing, 0, 1, 0, xPosition);

      fill(255);

      if (distanceGrowingRight >= 0 - rectWidth && distanceGrowingRight<=tubeLength) { //keep dots in tube
        rect(distanceGrowingRight, yPosition, rectWidth, rectWidth);
      }
      if (distanceGrowingLeft >= 0 - rectWidth && distanceGrowingLeft<=tubeLength) { //keep dots in tube
        rect(distanceGrowingLeft, yPosition, rectWidth, rectWidth);
      }


      if (speedGrowing >= 0.98) {
        countGrowing++;

        if (countGrowing == 3) {

          this.lenghtPointMain += rectWidth*2;
          println(this.lenghtPointMain/rectWidth);
          countGrowing = 0;
        }
      }
    }
    popStyle();

    if (this.lightPointReleased) {

      this.timeCountSpeedMultiplier++;

      if (timeCountSpeedMultiplier < 550) {
        timeSpeed = map(this.timeCountSpeedMultiplier, 0, 550, 0, 1);
        multiplierSpeed = AULib.wave(AULib.WAVE_BIAS, timeSpeed, 0.75);
      }

      if (timeCountSpeedMultiplier > 550 && timeCountSpeedMultiplier < 800) {
        timeSpeed = map(this.timeCountSpeedMultiplier, 550, 800, 1, 0);
        multiplierSpeed = AULib.wave(AULib.WAVE_GAIN, timeSpeed, 0.1);
      }

      //println(multiplierSpeed);

      if (timeCountSpeedMultiplier > 800) {
        this.lightPointReleased = false;
        this.timeCountSpeedMultiplier = 0;
      }
    }
    popMatrix();
  }

  boolean explode() {
    if (this.lenghtPointMain >= 25*rectWidth) {
      return true;
    } else {
      return false;
    }
  }
}