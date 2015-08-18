import processing.video.*;
Capture cam;
color[] currentPallette = new color[16];
float xincrement = 0.005;
float yincrement = 0.005;
float xstretch = 0.99;
float ystretch = 0.99;
float zstretch = 0.99;
// The noise function's 3rd argument, a global variable that increments once per cycle
float zoff = 0.0;
// We will increment zoff differently than xoff and yoff
float zincrement = 0.01;
void setup() {
  size(600, 600);
  frameRate(120);

  for (int i = 0; i < currentPallette.length; i++) {
    currentPallette[i] = color(0, 0, 0);
  }
  /*currentPallette[0] = color(255, 0, 0);
  currentPallette[1] = color(255, 0, 0);
  currentPallette[2] = color(255, 0, 0);
  currentPallette[3] = color(255, 0, 0);
  currentPallette[4] = color(255, 0, 0);
  currentPallette[5] = color(255, 0, 0);
  currentPallette[6] = color(255, 0, 0);
  currentPallette[7] = color(255, 0, 0);
  currentPallette[8] = color(255, 0, 0);
  currentPallette[9] = color(255, 0, 0);
  currentPallette[10] = color(255, 0, 0);*/
  currentPallette[11] = color(0, 0, 255);
  currentPallette[12] = color(0, 0, 255);
  currentPallette[13] = color(0, 0, 255);
  //currentPallette[14] = color(255, 0, 0);
  currentPallette[15] = color(255, 0, 0);


}

void draw() {
  setupChangingPalette();
  // Optional: adjust noise detail here
  // noiseDetail(8,0.65f);

  loadPixels();

  float xoff = 0.0; // Start xoff at 0

  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += xincrement;   // Increment xoff
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += yincrement; // Increment yoff

      // Calculate noise and scale by 255
      int bright = floor(noise(xoff,yoff,zoff)*255);

      // Try using this line instead
      //float bright = random(0,255);

      // Set each pixel onscreen to a grayscale value

           //pixels[x+y*width] = getColor(bright);
           pixels[x+y*width] = currentPallette[bright%16];

    }
  }

  /*
  leftHalf = get(0, 0, width/2, height);
  translate(width/2, 0);
  scale(-1, 1);
  image(leftHalf, 0, 0);
  */

  updatePixels();

  zoff += zincrement; // Increment zoff
  xincrement*=xstretch;
  yincrement*=ystretch;
  zincrement *= zstretch;
  if (xincrement > 0.01) {
    xstretch = 0.999;
  }
  if (xincrement < 0.002) {
    xstretch = 1.001;
  }
   if (yincrement > 0.01) {
    ystretch = 0.999;
  }
  if (yincrement < 0.002) {
    ystretch = 1.001;
  }
     if (zincrement > 0.01) {
    zstretch = 0.99;
  }
  if (zincrement < 0.002) {
    zstretch = 1.01;
  }
}

color getColor(float c){
 if (c < 64) {
   return color(255, 0, 0);
 } else if (c < 128) {
   return color(255, 255, 0);
 } else if (c < 192) {
   return color(0, 255, 255);
 } else {
   return color(0, 0, 255);
 }
}

void setupGreenPurple(){
  currentPallette[0] = color(0, 255, 0);
  currentPallette[1] = color(0, 255, 0);
  currentPallette[2] = color(0, 255, 0);
  currentPallette[3] = color(0, 255, 0);
  currentPallette[4] = color(0, 0, 0);
  currentPallette[5] = color(0, 0, 0);
  currentPallette[6] = color(0, 0, 0);
  currentPallette[7] = color(0, 0, 0);
  currentPallette[8] = color(200, 0, 255);
  currentPallette[9] = color(200, 0, 255);
  currentPallette[10] = color(200, 0, 255);
  currentPallette[11] = color(200, 0, 255);
  currentPallette[12] = color(0, 0, 0);
  currentPallette[13] = color(0, 0, 0);
  currentPallette[14] = color(0, 0, 0);
  currentPallette[15] = color(0, 0, 0);
}

void setupChangingPalette(){
  currentPallette[0] = color(255, sin(zoff)*255, 0);
  currentPallette[1] = color(0, sin(zoff)*255, 0);
  currentPallette[2] = color(0, sin(zoff)*255, 255);
  currentPallette[3] = color(0, sin(zoff)*255, 0);
  currentPallette[4] = color(0, 0, 0);
  currentPallette[5] = color(0, 0, 0);
  currentPallette[6] = color(0, 0, 0);
  currentPallette[7] = color(0, 0, 0);
  currentPallette[8] = color(sin(zoff)*200, 0, cos(zoff)*255);
  currentPallette[9] = color(sin(zoff)*200+55, 0, cos(zoff)*255);
  currentPallette[10] = color(sin(zoff)*200, 255, cos(zoff)*255);
  currentPallette[11] = color(sin(zoff)*200+55, 0, cos(zoff)*255);
  currentPallette[12] = color(0, 0, 0);
  currentPallette[13] = color(0, 0, 0);
  currentPallette[14] = color(0, 0, 0);
  currentPallette[15] = color(0, 0, 0);
}
