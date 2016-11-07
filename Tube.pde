/* The Lighteffect class is the mediator of the entire code
 lighteffect.update is the only function that is CONSTANTLY running
 .update checks the tubes that are active, decides what light-effect they should show and exectues the corrosponding functions
 */

import toxi.util.events.*;

class Tube implements ExplosionEndedListener {
  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;

  //For getting the xPosition of the lightPoint
  private float xPosition;

  private color colorLightPoint;
  
  private int interimTouchLocation;

  private boolean effectRunningTouchLocation0 = false;
  private boolean effectRunningTouchLocation1 = false;

  private ArrayList<Explosion> explosions = new ArrayList<Explosion>();

  private ArrayList<lightPoint> lightPoints = new ArrayList<lightPoint>();

  private ArrayList<createNewLightPoint> createNewLightPoints = new ArrayList<createNewLightPoint>();

  private ArrayList<explosionLightPoint> explosionLightPoints = new ArrayList<explosionLightPoint>();

  private ArrayList<TouchAnimation> TouchAnimations = new ArrayList<TouchAnimation>();

  //private ArrayList<RandomDotInTube> RandomDotInTubes = new ArrayList<RandomDotInTube>();

  Tube(int tubeNumber) {
    this.tubeNumber = tubeNumber;
    this.tubeModulus = tubeNumber % 3;
    this.tripodNumber = tubeNumber / 3;

    //if (this.touchLocation == TouchLocations.LEFT)
  }

  void isTouched(int touchLocation) {

    if (touchLocation == 0) {
      TouchAnimation newTouchAnimation  = new TouchAnimation(this.tubeModulus, this.tripodNumber, 0);
      TouchAnimations.add(newTouchAnimation);
    }

    if (touchLocation == 1) {
      TouchAnimation newTouchAnimation  = new TouchAnimation(this.tubeModulus, this.tripodNumber, 1);
      TouchAnimations.add(newTouchAnimation);
    }

    for (int i = lightPoints.size()-1; i >= 0; i--) { 
      lightPoint lightpoint = lightPoints.get(i);

      if (touchLocation == 0 && lightpoint.xPosition < tubeLength / 2 && effectRunningTouchLocation0 == false) {
        lightpoint.lightPointGrowing = true;
        effectRunningTouchLocation0 = true;
      }

      if (touchLocation == 1 && lightpoint.xPosition > tubeLength / 2 && effectRunningTouchLocation1 == false) {
        lightpoint.lightPointGrowing = true;
        effectRunningTouchLocation1 = true;
      }
    }

    if (touchLocation == 0 && effectRunningTouchLocation0 == false) {
      createNewLightPoint newcreateNewLightPoint  = new createNewLightPoint(this.tubeModulus, this.tripodNumber, 0);
      createNewLightPoints.add(newcreateNewLightPoint);
      effectRunningTouchLocation0 = true;
    }

    if (touchLocation == 1 && effectRunningTouchLocation1 == false) {
      createNewLightPoint newcreateNewLightPoint  = new createNewLightPoint(this.tubeModulus, this.tripodNumber, 1);
      createNewLightPoints.add(newcreateNewLightPoint);
      effectRunningTouchLocation1 = true;
    }
  }

  void isUnTouched(int touchLocation) {

    for (int i = lightPoints.size()-1; i >= 0; i--) { 
      lightPoint lightpoint = lightPoints.get(i);
      if (touchLocation == 0 && lightpoint.xPosition < tubeLength / 2 && effectRunningTouchLocation0) {
        lightpoint.lightPointGrowing = false;
        lightpoint.lightPointReleased = true;

        effectRunningTouchLocation0 = false;
      }

      if (touchLocation == 1 && lightpoint.xPosition > tubeLength / 2 && effectRunningTouchLocation1) {
        lightpoint.lightPointGrowing = false;
        lightpoint.lightPointReleased = true;

        effectRunningTouchLocation1 = false;
      }
    }


    for (int i = createNewLightPoints.size()-1; i >= 0; i--) { 
      createNewLightPoint createnewlightpoints = createNewLightPoints.get(i);

      if (createnewlightpoints.touchLocation == touchLocation) {
        createnewlightpoints.fadeOut = true;

        //if (touchLocation == 0) {
        //  effectRunningTouchLocation0 = false;
        //  lightPoint newLightPoint  = new lightPoint(this.tubeModulus, this.tripodNumber, 0, int(random(0, 2.99)), random(0, 62), random(0, 4), false, 0, 1);
        //  lightPoints.add(newLightPoint);
        //}
        //if (touchLocation == 1) {
        //  effectRunningTouchLocation1 = false;
        //  lightPoint newLightPoint  = new lightPoint(this.tubeModulus, this.tripodNumber, 1, int(random(0, 2.99)), random(0, 62), random(0, 4), false, 0, 1);
        //  lightPoints.add(newLightPoint);
        //}
      }
    }

    for (int i = TouchAnimations.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      TouchAnimation newTouchAnimation = TouchAnimations.get(i);
      if (newTouchAnimation.touchLocation == touchLocation) {
        TouchAnimations.remove(i);
      }
    }

    //if (touchLocation == 0) {
    //  TouchAnimation newTouchAnimation  = new TouchAnimation(this.tubeModulus, this.tripodNumber, 0);
    //  TouchAnimations.remove(newTouchAnimation);
    //}

    //if (touchLocation == 1) {
    //  TouchAnimation newTouchAnimation  = new TouchAnimation(this.tubeModulus, this.tripodNumber, 1);
    //  TouchAnimations.remove(newTouchAnimation);
    //}

    //for (int i = createNewLightPoints.size()-1; i >= 0; i--) { 
    //  // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    //  createNewLightPoint createnewlightpoints = createNewLightPoints.get(i);
    //  if (createnewlightpoints.touchLocation == 1) {
    //    createNewLightPoints.remove(i);
    //  }
    //}
  }

  /* this function will be called on each cycle */
  void update() {
    //int currentTime = millis(); // TODO: should be refactored to the main draw loop in glow_gen 

    //for (int i = 0; i < explosions.size(); i++) {
    //  Explosion explosion = explosions.get(i);

    //  //explosion.update(currentTime);

    //  int fadeToBlackSpeed = explosion.shouldTubeFadeToBlack();

    //  if (fadeToBlackSpeed > -1) {
    //    this.fadeToBlackBy(fadeToBlackSpeed);
    //  }

    //  //if (explosion.finished()) {
    //  //  explosions.remove(i);
    //  //}
    //}

    for (int i = lightPoints.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      lightPoint lightpoint = lightPoints.get(i);
      lightpoint.endTube();
      if (lightpoint.lightPointGrowing == false) {
        lightpoint.move();
      }
      lightpoint.growingAndCharging();
      lightpoint.display();
      if (lightpoint.endTube()) {
        lightPoints.remove(i);
      }
      if (lightpoint.explode()) {
        if (this.xPosition < tubeLength/2) {
          effectRunningTouchLocation0 = false;
        }

        if (this.xPosition > tubeLength/2) {
          effectRunningTouchLocation1 = false;
        }

        this.xPosition = lightpoint.xPosition;

        this.colorLightPoint = lightpoint.colorLightPoint;

        lightPoints.remove(i);

        explosionLightPoint newExplosionLightPoint  = new explosionLightPoint(this.tubeModulus, this.tripodNumber, this.xPosition, this.colorLightPoint);
        explosionLightPoints.add(newExplosionLightPoint);
      }
    }

    for (int i = explosionLightPoints.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      explosionLightPoint explosionlightpoint = explosionLightPoints.get(i);
      explosionlightpoint.move();
      explosionlightpoint.display();
      if (explosionlightpoint.endExplosion()) {
        explosionLightPoints.remove(i);
      }
    }

    for (int i = createNewLightPoints.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      createNewLightPoint createnewlightpoints = createNewLightPoints.get(i);
      if (createnewlightpoints.fadeOut == false) {
        createnewlightpoints.move();
      } else {
        createnewlightpoints.fadeOut();
      }
      
      if (createnewlightpoints.fadeOutDone()){
        interimTouchLocation = createnewlightpoints.touchLocation;
        
        
        if (interimTouchLocation == 0) {
          effectRunningTouchLocation0 = false;
          lightPoint newLightPoint  = new lightPoint(this.tubeModulus, this.tripodNumber, 0, int(random(0, 2.99)), random(0, 62), random(0, 4), true, 0, 1);
          lightPoints.add(newLightPoint);
        }
        if (interimTouchLocation == 1) {
          effectRunningTouchLocation1 = false;
          lightPoint newLightPoint  = new lightPoint(this.tubeModulus, this.tripodNumber, 1, int(random(0, 2.99)), random(0, 62), random(0, 4), true, 0, 1);
          lightPoints.add(newLightPoint);
        }
        
        createNewLightPoints.remove(i);
      }
      
      createnewlightpoints.display();
    }

    //TouchAnimations.add(newRandomDotInTube);

    for (int i = TouchAnimations.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      TouchAnimation newTouchAnimation = TouchAnimations.get(i);
      newTouchAnimation.display();
    }

    //for (int i = RandomDotInTubes.size()-1; i >= 0; i--) { 
    //  // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    //  RandomDotInTube newRandomDotInTube = RandomDotInTubes.get(i);
    //  newRandomDotInTube.display();

    //  if (newRandomDotInTube.finished()) {
    //    RandomDotInTubes.remove(i);
    //  }
    //}
    /*
    for (int i = 0; i < numTubes; i ++) { // refresh all active tubes every frame
     int startTimeNow = startTime[i];
     if (startTimeNow > 0 && currentTime - startTimeNow > cycleTime) {
     
     int tube = activeTube[i];
     position = touchState[tube];
     tubeNumber = tube % 3;
     tripodNumber = tube / 3;
     
     // now simply run explosions, but deciding functions should be added here              array.append
     explosions.update(position, tubeNumber, tripodNumber);
     } */
  }

  void explosionEnded(/* enum<EffectTypes> type,*/ int tubeToDeactivate) {
    explosions.remove(tubeToDeactivate);
  }

  void fadeToBlackBy(int fadeAmount) {
    pushMatrix();
    translate(tubeModulus * (numLEDsPerTube * rectWidth) + (tubeModulus * 20 + 20), tripodNumber * 21 + 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber

    pushStyle();
    fill(b1, fadeAmount); // gray, alpha

    rect(-10, 0, tubeLength + 20, rectHeight * 1.5);

    popStyle();
    popMatrix();
  }

  void addLightPoint(int movementDirection, int randomSpeed, float j, float lightPointXColor, boolean lightPointReleased, int timeCountSpeedMultiplier, int lenghtPointMain) {
    lightPoint newLightPoint  = new lightPoint(this.tubeModulus, this.tripodNumber, movementDirection, randomSpeed, j, lightPointXColor, lightPointReleased, timeCountSpeedMultiplier, lenghtPointMain);
    lightPoints.add(newLightPoint);
  } 

  void addExplosionLightPoint(int xPosition) {
    explosionLightPoint newExplosionLightPoint  = new explosionLightPoint(this.tubeModulus, this.tripodNumber, xPosition, colorLightPoint);
    explosionLightPoints.add(newExplosionLightPoint);
  }

  void removeAllLightPoints() {
    for (int i = lightPoints.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      lightPoint lightpoint = lightPoints.get(i);
      lightPoints.remove(i);
    }
  }
}