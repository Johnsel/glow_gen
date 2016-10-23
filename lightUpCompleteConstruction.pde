//BLOCKS - less rendering..

//Still needs some random movement of the sizes of blue areas, 

float xCountNoise, yCountNoise, xSinusBackground;
float noiseScale = .005;

void lightUpCompleteConstruction() {

  xCountNoise=xCountNoise+0.5; //DANGEROUS gets bigger and bigger fix needed.

  //Move with sinus trough y of noise function, just to make the background more random
  xSinusBackground=xSinusBackground+0.005;
  yCountNoise = height*sin(xSinusBackground); //can get negative, no problem
  if (xSinusBackground >= 2*PI) {
    xSinusBackground = 0;
  }

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
}