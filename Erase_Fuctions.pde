void fadeToBlackBy(int fadeAmount) {
  pushStyle();
  fill(b1,fadeAmount); // gray, alpha
  
  rect(0, 0, tubeLength, rectHeight);
  
  popStyle();
}