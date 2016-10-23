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
  rect(0, 0, 24, 16);
  // oversampled fonts tend to look better
  textFont(font, 16);
  // gray int frameRate display:
  fill(200);
  text(int(frameRate), 5, 16);

  //Display fps in title of canvas
  surface.setTitle(int(frameRate) + " fps");
}

int currentSelectedTube = 0;
int currentSelectedTripod = 0;

void selectingSystem() {
  //Keep selecting system within raster
  if (currentSelectedTube < 0) {
    currentSelectedTube = 0;
  }
  if (currentSelectedTube > 2) {
    currentSelectedTube = 2;
  }
  if (currentSelectedTripod < 0) {
    currentSelectedTripod = 0;
  }
  if (currentSelectedTripod >= numTripods) {
    currentSelectedTripod = numTripods - 1;
  }

  //Create rectangle for indicating which tube / tripod is selected
  pushMatrix();
  translate(currentSelectedTube * (numLEDsPerTube * rectWidth) + (currentSelectedTube * 20 + 20), currentSelectedTripod * 21 + 21);
  pushStyle();
  noFill();
  strokeWeight(0.5);
  stroke(0, 255, 0);
  rect(x-5, y-5, tubeLength+10, rectHeight+10);
  //println(currentSelectedTube);
  //println(currentSelectedTripod);
  popStyle();
  popMatrix();
}