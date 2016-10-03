class lightPoint {

  int tubeNumberClass, tripodNumberClass, movementDirection, randomSpeed, colorVarationLightPoint, colorVariationLightPoint;
  float xPosition, yPosition, speedPoint, maximumLengthPointTale, lengthPointHead, j, lengthPointTale;
  
  color colorLightPoint;

  lightPoint(int tubeNumber, int tripodNumber) {
    speedPoint = 1;
    maximumLengthPointTale = 350;
    lengthPointHead = 50;

    tubeNumberClass = tubeNumber;
    tripodNumberClass = tripodNumber;

    movementDirection = int(random(0, 1.99)); //0-right 1-left

    randomSpeed = int(random(0, 2.99));
    //Determine the starting position of the lightpoint
    if (movementDirection == 0) {
      xPosition = 0 - lengthPointHead;
    }
    if (movementDirection == 1) {
      xPosition = tubeLength + lengthPointHead;
    }
    
    colorVariationLightPoint = int(random(0,2.99));
    
    if (colorVariationLightPoint == 0){
      colorLightPoint = e1;
    }
    if (colorVariationLightPoint == 1){
      colorLightPoint = e2;
    }
    if (colorVariationLightPoint == 2){
      colorLightPoint = e3;
    }
    
  }

  void move() {
    
    //println(randomSpeed);
    //calculating movement speed
    j=j+0.005; //Determine how quickly the speed changes 

    switch (randomSpeed) {
    case 0:
      speedPoint = -((sin(3*(x-0.584))*cos(0.8*(x-0.584))+cos(0.5*(x-0.584))*sin (2*(x-0.584))+cos (0.8*(x-0.584)))-2.85)/4;
      break;
    case 1:
      speedPoint = ((sin (2*(x-0.584))*sin(0.5*(x-0.584))+cos(0.5*(x-0.584))*sin(05*(x-0.584))+cos(0.8*(x-0.584)))+2.85)/4;
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
        xPosition = 0 - lengthPointHead;
      }
    }
    if (movementDirection == 1) {
      if (xPosition <= 0 - lengthPointTale) {
        tripodNumberClass --; 
        xPosition = tubeLength + lengthPointHead;
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

    pushMatrix();
    noFill();
    translate((tubeNumberClass - 1) * (numLEDsPerTube * rectWidth) + (tubeNumberClass * 20), tripodNumberClass * 21);
    //Movement left
    if (movementDirection == 1) { 
      //gradient to right
      for (float i = xPosition; i <= xPosition+lengthPointTale; i++) {
        pushStyle();
        float inter = map(i, xPosition, xPosition+lengthPointTale, 255, 0);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 && i<=tubeLength) { //keep within raster
          stroke(colorLightPoint, inter);
          line(i, yPosition+rectHeight, i, yPosition);
        }
        popStyle();
      }
      //smooth out lightpoint infront
      for (float i = xPosition; i > xPosition-lengthPointHead; i--) {
        pushStyle();
        float inter = map(i, xPosition-lengthPointHead, xPosition, 0, 255);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 && i<=tubeLength) { //keep within raster
          stroke(colorLightPoint, inter);          
          line(i, yPosition+rectHeight, i, yPosition);
        }
        popStyle();
      }
    }
    //Movement right
    if (movementDirection == 0) {
      //gradient to left
      for (float i = xPosition; i > xPosition-lengthPointTale; i--) {
        pushStyle();
        float inter = map(i, xPosition-lengthPointTale, xPosition, 0, 255);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 && i<=tubeLength) { //keep within raster
          stroke(colorLightPoint, inter);
          line(i, yPosition+rectHeight, i, yPosition);
        }
        popStyle();
      }
      //smooth out lightpoint infront
      for (float i = xPosition; i <= xPosition+lengthPointHead; i++) {
        pushStyle();
        float inter = map(i, xPosition, xPosition+lengthPointHead, 255, 0);
        //color c = lerpColor(c2, b1, inter);

        if (i >= 0 && i<=tubeLength) { //keep within raster
          stroke(colorLightPoint, inter);
          line(i, yPosition+rectHeight, i, yPosition);
        }
        popStyle();
      }
    }

    popMatrix();
  }
  
  void fadeOut(){
    
  }
  
}