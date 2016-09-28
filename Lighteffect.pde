/* The Lighteffect class is the mediator of the entire code
   lighteffect.update is the only function that is CONSTANTLY running
   .update checks the tubes that are active, decides what light-effect they should show and exectues the corrosponding functions
*/

private int tube;
private int tubeNumber;
private int tripodNumber;
private int position;

class Lighteffect {
  Lighteffect() {
    
  }
  
  void update() {
    int currentTime = millis(); 
    for (int i = 0; i < numTubes; i ++) { // refresh all active tubes every frame
      int startTimeNow = startTime[i];
      if (startTimeNow > 0 && currentTime - startTimeNow > cycleTime) {
        
        int tube = activeTube[i];
        position = touchState[tube];
        tubeNumber = tube % 3;
        tripodNumber = tube / 3;
        
        // now simply run explosions, but deciding functions should be added here              array.append
        explosions.update(position, tubeNumber, tripodNumber);
    }
  }
  
  void deactivateTube(int tubeToDeactivate) {
    // maybe this can be implemented in the for-loop in lighteffect.update
    // this will eliminate the first for-loop and if-statement
    
    for (int i = 0; i < activeTubes; i ++) {
      if (activeTube[i] == tubeToDeactivate) {
        for (int j = i; j < activeTubes - 1; j ++) { 
          activeTube[j] = activeTube[j + 1];      //remove active tube from activeTube[] array
        }
      }
    }
  }
  
  void fadeToBlackBy(int fadeAmount) {
    pushStyle();
    fill(b1,fadeAmount); // gray, alpha
    
    rect(-10, 0, tubeLength + 20, rectHeight * 1.5);
    
    popStyle();
  }
}