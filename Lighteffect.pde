private int tube;
private int tubeNumber;
private int tripodNumber;
private int position;

class Lighteffect {
  Lighteffect() {
    
  }
  
  void update(int tube) {
    //position = touchState[tube];
    position = 1;
    tubeNumber = tube % 3;
    tripodNumber = tube / 3;
    
    explosions.update(position, tubeNumber, tripodNumber);
    
    if (tube < numTubes - 1) {
      tube ++;
    }
    else { 
      tube = 0;
    }
    
  }
  
  void fadeToBlackBy(int fadeAmount) {
    pushStyle();
    fill(b1,fadeAmount); // gray, alpha
    
    rect(-10, 0, tubeLength + 20, rectHeight * 1.5);
    
    popStyle();
  }
  
  void setGradient(int x, int y, float w, float h, color c1, color c2, int tubeNumber, int tripodNumber) {
    pushMatrix();
    translate((tubeNumber - 1) * (numLEDsPerTube * rectWidth) + (tubeNumber * 20), tripodNumber * 21); // this can be used to shift the matrix to draw for each tube using tubeNumber and tripodNumber
    
    noFill();
  
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, b1, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
    popMatrix();
  }
}