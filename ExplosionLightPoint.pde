class explosionLightPoint {

  int tubeModulus, tripodNumber, frameCountStart, yPosition;
  float xPosition, distanceExplosionRight, totalDistanceExplosionRight, time, multiplierSpeed, speedExplosion, movedDistance, distanceTubeOneExplosionRight, distanceTubeOneExplosionLeft, totalDistanceExplosionLeft, distanceExplosionLeft, durationExplosion;

  float fadeAmount = 255;

  boolean animationRunning = true;
  
  color startColorExplosion, endColorExplosion, colorExplosion;

  private ArrayList<RandomDotInTube> RandomDotInTubes = new ArrayList<RandomDotInTube>();

  //colorVariationConstruction = 1;

  explosionLightPoint(int tubeModulus, int tripodNumber, float xPosition, color startColorExplosion) {
    this.xPosition = xPosition;

    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;
    
    this.startColorExplosion = startColorExplosion;
    endColorExplosion = color(255,255,255);

    distanceTubeOneExplosionRight = tubeLength -  this.xPosition;

    distanceTubeOneExplosionLeft =  this.xPosition;

    totalDistanceExplosionRight = (tubeLength -  this.xPosition) + tubeLength;

    totalDistanceExplosionLeft = this.xPosition + tubeLength;

    frameCountStart = frameCount;

    durationExplosion = 60*1.5;

    RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber, int(this.xPosition), frameCountStart, int(durationExplosion));
    RandomDotInTubes.add(newRandomDotInTube);

    // numberOfPoints = 60;

    //for (int i = 0; i <= 20; i ++) {
    //  //println(tubeModulus, tripodNumber);
    //  RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber, int(random(0, tubeLength)), int(random(5, 30)));
    //  RandomDotInTubes.add(newRandomDotInTube);
    //}

    //for (int i = 0; i <= 20; i ++) {
    //  //println(tubeModulus, tripodNumber);
    //  RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber+1, int(random(0, tubeLength)), int(random(5, 30)));
    //  RandomDotInTubes.add(newRandomDotInTube);
    //}

    //for (int i = 0; i <= 20; i ++) {
    //  //println(tubeModulus, tripodNumber);
    //  RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber-1, int(random(0, tubeLength)), int(random(5, 30)));
    //  RandomDotInTubes.add(newRandomDotInTube);
    //}

    //colorVariationConstruction = 0;
  }

  void move() {

    time = map(frameCount, frameCountStart, frameCountStart + durationExplosion, 0, 1);

    if (animationRunning) {
      multiplierSpeed = AULib.wave(AULib.WAVE_BIAS, time, 0.8);
      //multiplierSpeed = AULib.ease(AULib.EASE_OUT_BACK, time);
    }

    //println(multiplierSpeed);

    distanceExplosionRight = map(multiplierSpeed, 0, 1, 0, totalDistanceExplosionRight);
    distanceExplosionLeft = map(multiplierSpeed, 0, 1, 0, totalDistanceExplosionLeft + rectWidth);


    //println(distanceExplosionRight);
  }

  void display() {
    
    //create the dots in the explosion with the movement of the explosion
    if (animationRunning) {
      if (distanceExplosionRight > distanceTubeOneExplosionRight) {
        if (frameCount % int(random(4, 9)) == 0) {
          RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber + 1, int(distanceExplosionRight - distanceTubeOneExplosionRight), frameCountStart, int(durationExplosion));
          RandomDotInTubes.add(newRandomDotInTube);
        }
      } else {
        if (frameCount % int(random(2, 4)) == 0) {
          RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber, int(distanceExplosionRight + this.xPosition), frameCountStart, int(durationExplosion));
          RandomDotInTubes.add(newRandomDotInTube);
        }
      }

      if (distanceExplosionLeft > distanceTubeOneExplosionLeft) {
        if (frameCount % int(random(4, 9)) == 0) {
          RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber - 1, int(tubeLength - (distanceExplosionLeft - this.xPosition)), frameCountStart, int(durationExplosion));
          RandomDotInTubes.add(newRandomDotInTube);
        }
      } else {
        if (frameCount % int(random(2, 4)) == 0) {
          RandomDotInTube newRandomDotInTube  = new RandomDotInTube(tubeModulus, tripodNumber, int(this.xPosition - distanceExplosionLeft), frameCountStart, int(durationExplosion));
          RandomDotInTubes.add(newRandomDotInTube);
        }
      }
    }
    
    
    //Create the fading animation of color of explosion
    colorExplosion = lerpColor(startColorExplosion, endColorExplosion, map(time, 0, 0.6, 0, 1));
    
    


    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeModulus and tripodNumber

    //Explosion to right    
    //println(this.xPosition + " , " + distanceExplosionRight);

    // + rectWidth for fixing the overlapping rectangle in the middle of the explosion
    for (float i = this.xPosition + 1; i <= distanceExplosionRight + this.xPosition; i+=1) {
      pushStyle();      
      fill(colorExplosion, fadeAmount);
      rect(i, yPosition, 1, rectWidth);
      popStyle();
      if ( i >= distanceTubeOneExplosionRight + this.xPosition) {
        break;
      }
    }

    if (tripodNumber < 39) {
      if (distanceExplosionRight > distanceTubeOneExplosionRight) {
        for (float i = 0; i <= distanceExplosionRight - distanceTubeOneExplosionRight; i+=1) {
          pushStyle();      
          fill(colorExplosion, fadeAmount);      
          rect(i, yPosition + 21, 1, rectWidth);
          popStyle();
        }
      }
    }

    //explosion to left
    for (float i = this.xPosition; i >= this.xPosition - distanceExplosionLeft; i-=1) {
      pushStyle();      
      fill(colorExplosion, fadeAmount);
      rect(i, yPosition, 1, rectWidth);
      popStyle();
      if ( i <= 0) {
        break;
      }
    }

    if (tripodNumber > 0) {
      if (distanceExplosionLeft >= distanceTubeOneExplosionLeft) {
        for (float i = tubeLength; i > (tubeLength - (distanceExplosionLeft - this.xPosition)); i-=1) {
          pushStyle();      
          fill(colorExplosion, fadeAmount);      
          rect(i, yPosition - 21, 1, rectWidth);
          popStyle();
        }
      }
    }

    popMatrix();

    for (int i = RandomDotInTubes.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      RandomDotInTube newRandomDotInTube = RandomDotInTubes.get(i);
      newRandomDotInTube.display();

      if (newRandomDotInTube.finished()) {
        RandomDotInTubes.remove(i);
      }
    }
  }

  boolean endExplosion() {
    if (multiplierSpeed > 0.6) {
      fadeAmount = map(multiplierSpeed, 0.6, 0.99, 255, 0);
    }

    if (multiplierSpeed > 0.99) {
      animationRunning = false;
    }

    if (RandomDotInTubes.size() == 0) {
      return true;
    } else {
      return false;
    }
  }
}