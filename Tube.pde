/* The Lighteffect class is the mediator of the entire code
 lighteffect.update is the only function that is CONSTANTLY running
 .update checks the tubes that are active, decides what light-effect they should show and exectues the corrosponding functions
 */

import toxi.util.events.*;

//Move lightPoint
interface moveLightPointListener {
  void moveLightPoint(int tubeNumber, int movementDirection);
}



class Tube implements ExplosionEndedListener, moveAndRemoveLightPointListener {

  tubes.listeners.addListener(new moveListener());

  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;

  ArrayList<Explosion> explosions = new ArrayList<Explosion>();

  ArrayList<lightPoint> lightPoints = new ArrayList<lightPoint>();

  public EventDispatcher<moveLightPointListener> listeners = new EventDispatcher<moveLightPointListener>();

  Tube(int tubeNumber) {
    this.tubeNumber = tubeNumber;
    this.tubeModulus = tubeNumber % 3;
    this.tripodNumber = tubeNumber / 3;

    //if (this.touchLocation == TouchLocations.LEFT)
  }

  void isTouched(int touchLocation /* TODO: Make an ENUM for this */) {
    // create a new effect
    int currentTime = millis();
    Explosion newExplosion = new Explosion(currentTime, touchLocation, this.tubeNumber);

    explosions.add(newExplosion);
    newExplosion.update(currentTime);


    println("new explosion started, new size: " + explosions.size());
  }

  void isUntouched() {
    // TODO: do something more sensible here

    for (int i = explosions.size() - 1; i >= 0; i--) {
      explosions.remove(i);
    }
  }

  /* this function will be called on each cycle */
  void update() {
    int currentTime = millis(); // TODO: should be refactored to the main draw loop in glow_gen 

    for (int i = 0; i < explosions.size(); i++) {
      Explosion explosion = explosions.get(i);

      //explosion.update(currentTime);

      int fadeToBlackSpeed = explosion.shouldTubeFadeToBlack();

      if (fadeToBlackSpeed > -1) {
        this.fadeToBlackBy(fadeToBlackSpeed);
      }

      //if (explosion.finished()) {
      //  explosions.remove(i);
      //}
    }

    for (int i = lightPoints.size()-1; i >= 0; i--) { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      lightPoint lightpoint = lightPoints.get(i);
      lightpoint.move();
      lightpoint.display();
      lightpoint.endTube();
      //if (lightpoint.finished()) {
      //  // Items can be deleted with remove()
      //  lightPoints.remove(i);
      //}
    }

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

  void moveAndRemoveLightPoint(int tubeNumber, int movementDirection) {
    lightPoints.remove(tubeNumber); 

    for (moveLightPointListener l : listeners) {
      l.moveLightPoint(tubeNumber, movementDirection);
    }
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

  void addLightPoint() {
    lightPoint newLightPoint  = new lightPoint(this.tubeModulus, this.tripodNumber);
    lightPoints.add(newLightPoint);
  }
}