// material levels
float waterLevel = 0.4;
float sandLevel = 0.5;
float grassLevel = 0.7;
float cliffLevel = 0.8;

// value decreasers
float lower = 50;
float mouseLower = 1000;

// xyz offsets
float xOff = 0;
float yOff = 0;
float zOff = 0;

// visual settings
boolean morphLandScape = false;
boolean scrollLand = false;
int resolution = 2;
int variation = 0;
FlashText textflash = new FlashText();

void setup() {
  size(400, 400);
}

void draw() {
  background(0);

  surface.setTitle("FrameRate: " + str(frameRate) + "fps");
  int index;
  for (int i = 0; i < height; i += resolution) {
    for (int j = 0; j < width; j += resolution) {

      // material colors
      color water = color(100, 100, 255 - random(0, variation));
      color sand = color(252 - random(0, variation), 186, 3);
      color grass = color(0, 200 - random(0, variation), 0);
      color cliff = color(51 - random(0, variation), 51 - random(0, variation), 51 - random(0, variation));
      color snow = color(200 - random(0, variation), 200 - random(0, variation), 200 - random(0, variation));

      // color list
      color[] colors = {water, sand, grass, cliff, snow};

      // choose material
      float heightValue = noise((j + xOff) / lower, (i + yOff) / lower, zOff / lower);
      if (heightValue < waterLevel) {
        index = 0;
      } else if (heightValue < sandLevel) {
        index = 1;
      } else if (heightValue < grassLevel) {
        index = 2;
      } else if (heightValue < cliffLevel) {
        index = 3;
      } else {
        index = 4;
      }

      // draw material
      if (resolution == 1) {
        set(j, i, colors[index]);
      } else {
        fill(colors[index]);
        noStroke();
        rect(j, i, resolution, resolution);
      }
    }

    // move world with mouse
    if (mousePressed) {
      xOff += (pmouseX - mouseX) / (mouseLower / resolution);
      yOff += (pmouseY - mouseY) / (mouseLower / resolution);
    }

    // automatically scroll both x and y
    if (scrollLand) {
      xOff += 0.002;
      yOff += 0.002;
    }

    // scroll z value to change the worlds layout
    if (morphLandScape) {
      zOff += 0.0005;
    }
  }
}

void keyPressed() {
  // exit when p is pressed
  if (key == 'p') {
    textflash.flash("Exiting");
    exit();
  }

  // choose to use visual settings
  if (key == 'm') {
    if (morphLandScape) {
      morphLandScape = false;
      textflash.flash("Morph Land Off");
    } else {
      morphLandScape = true;
      textflash.flash("Morph Land On");
    }
  }

  if (key == 's') {
    if (scrollLand) {
      scrollLand = false;
      textflash.flash("Scroll Land Off");
    } else {
      scrollLand = true;
      textflash.flash("Scroll Land On");
    }
  }
}
