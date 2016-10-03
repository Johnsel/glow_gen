//BLOCKS - less rendering..

float xCountNoise, yCountNoise, xSinusBackground;
float noiseScale = .002;

void lightUpCompleteConstruction() {

  xCountNoise=xCountNoise+0.5; //DANGEROUS gets bigger and bigger fix needed.
  
  //Move with sinus trough y of noise function, just to make the background more random
  xSinusBackground=xSinusBackground+0.005;
  yCountNoise = height*sin(xSinusBackground); //can get negative, no problem
  if(xSinusBackground >= 2*PI){
    xSinusBackground = 0;
  }
  //println(yCountNoise);
  
  
  //Noise background generation
  for (int x=0; x < width*1.5; x++) {
    pushMatrix();
    pushStyle();
    
    //Rotate around center
    translate(width/2, height/2);
    rotate(radians(95));
    translate((-width/2), (-height/2)-width*0.3);

    //Generation background
    float noiseVal = noise((xCountNoise+x)*noiseScale, xSinusBackground*1*noiseScale);
    float blueColor = map(noiseVal, 0, 1, 0, 90);
    stroke(20, -blueColor, blueColor);
    line(x, 0, x, height*2.5);
    //println(noiseVal);
    popStyle();
    popMatrix();
  }
  
  //Some random example code, not important. 
  //for (int b = 1; b <= numTripods; b++) {
  //  pushStyle();
  //  float inter = map(b, 0, numTripods, 0, 1);
  //  color c = lerpColor(d1, d2, inter);
  //  fill(c);
  //  for (int a = 1; a<=3; a++) {
  //    pushMatrix();
  //    translate((a - 1) * (numLEDsPerTube * rectWidth) + (a * 20), b * 21);
  //    println(a);
  //    rect(0, 0, tubeLength, rectHeight);
  //    popMatrix();
  //  }
  //  popStyle();
  //}
}