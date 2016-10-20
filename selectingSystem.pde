int currentSelectedTube = 1;
int currentSelectedTripod = 1;

void selectingSystem(){
  //Keep selecting system within raster
  if (currentSelectedTube < 1){
    currentSelectedTube = 1;
  }
  if (currentSelectedTube > 3){
    currentSelectedTube = 3;
  }
  if (currentSelectedTripod < 1){
    currentSelectedTripod = 1;
  }
  if (currentSelectedTripod > numTripods){
    currentSelectedTripod = numTripods;
  }
    
    
  
  
  //Create rectangle for indicating which tube / tripod is selected
  pushMatrix();
  translate((currentSelectedTube - 1) * (numLEDsPerTube * rectWidth) + (currentSelectedTube * 20), currentSelectedTripod * 21);
  pushStyle();
  noFill();
  strokeWeight(0.5);
  stroke(0,255,0);
  rect(x-5,y-5,tubeLength+10,rectHeight+10);
  //println(currentSelectedTube);
  //println(currentSelectedTripod);
  popStyle();
  popMatrix();
  
  
}