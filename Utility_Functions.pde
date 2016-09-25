// utility functions like drawRaster and showFrameRate

void drawRaster() {
  pushStyle();
  noFill();
  stroke(0, 102, 153);
  
  pushMatrix();
  translate(20, 21);  
  
  for (int j = 0; j < numTripods; j ++) {
    for (int i = 0; i < numLEDsPerTube; i ++) {
      rect(x, y, rectWidth, rectHeight);
      x += rectWidth;
    }
    
    x += 20;
    
    for (int i = 0; i < numLEDsPerTube; i ++) {
      rect(x, y, rectWidth, rectHeight);
      x += rectWidth;
    }
    
    x += 20;
    
    for (int i = 0; i < numLEDsPerTube; i ++) {
      rect(x, y, rectWidth, rectHeight);
      x += rectWidth;
    }
    x = 0;
    y += 21;
  }
  
  x = 0;
  y = 0;
  popMatrix();
  popStyle();
}


  PFont font;

void ShowFrameRate() {
  fill(0);
  rect(0,0,24,16);
  // oversampled fonts tend to look better
  textFont(font,16);
  // gray int frameRate display:
  fill(200);
  text(int(frameRate),5,16);
}