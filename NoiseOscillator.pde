// Perlin Ooze for Ooligan Alley projection mapping

// Color pallette - can be changed on the fly
color[] currentPallette = new color[16];

// The amount by which the x, y and z arguments for the noise() function change with each iteration
// x and y determine the 'zoom' of the noise
float xincrement = 0.005;
float yincrement = 0.005;
// z determines the 'speed' or 'viscosity' of the animation
float zincrement = 0.01;

// The amount by which the increments above increase or shrink with each frame
// A control block in the draw() loop changes these over time to prevent a monotonic compression
float xstretch = 0.99;
float ystretch = 0.99;
float zstretch = 0.99;

// The noise function's 3rd argument, a global variable that increments once per cycle (i.e. time)
float zoff = 0.0;

void setup() {
  size(400, 400);
  frameRate(120);

  // Initialize the pallette to look pretty cool
  for (int i = 0; i < currentPallette.length; i++) {
    currentPallette[i] = color(0, 0, 0);
  }
  currentPallette[11] = color(0, 0, 255);
  currentPallette[12] = color(0, 0, 255);
  currentPallette[13] = color(0, 0, 255);
  currentPallette[15] = color(255, 0, 0);
}

void draw() {
  // Set up palette:
  //setupChangingPalette();
  //setupGreenPurple();
  setupRainbow();

  // Adjust noise detail here
  // Parameter 1 is the number of octaves
  // Parameter 2 is the percent contribution of each subsequent octave
   noiseDetail(6, 0.48f);

  loadPixels();

  float xoff = 0.0;

  // For every x,y coordinate in a 2D space, for each frame in time (z), calculate a noise value and scale it to 0-255
  for (int x = 0; x < width; x++) {
    xoff += xincrement;
    float yoff = 0.0;
    for (int y = 0; y < height; y++) {
      yoff += yincrement;

      int brightness = floor(noise(xoff, yoff, zoff) * 255);

      // Use this line to illustrate the difference between Perlin noise and white noise:
      //float brightness = random(0,255);

      // Set the color of each pixel based on the brightness value:
      //pixels[x+y*width] = getColor(bright);
       pixels[x+y*width] = currentPallette[brightness % 16];

    }
  }

  //Mirror the screen for cool effects:
  /*
  leftHalf = get(0, 0, width/2, height);
  translate(width/2, 0);
  scale(-1, 1);
  image(leftHalf, 0, 0);
  */

  updatePixels();

  zoff += zincrement;

  // Increase or decrease the incrementors to expand/contract quicker/slower (breathing)

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

void setupRainbow(){
  currentPallette[0] = color(255, 0, 0);
  currentPallette[1] = color(0, 0, 0);
  currentPallette[2] = color(255, 165, 0);
  currentPallette[3] = color(0, 0, 0);
  currentPallette[4] = color(255, 255, 0);
  currentPallette[5] = color(0, 0, 0);
  currentPallette[6] = color(0, 128, 0);
  currentPallette[7] = color(0, 0, 0);
  currentPallette[8] = color(0, 128, 255);
  currentPallette[9] = color(0, 0, 0);
  currentPallette[10] = color(0, 0, 255);
  currentPallette[11] = color(0, 0, 0);
  currentPallette[12] = color(75, 0, 130);
  currentPallette[13] = color(0, 0, 0);
  currentPallette[14] = color(238, 130, 238);
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
