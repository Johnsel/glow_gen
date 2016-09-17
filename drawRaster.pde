void drawRaster() {
  pushStyle();
  fill(0,0,0);
  stroke(c2);
  
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