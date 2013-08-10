int GRID_X = 25,
    GRID_Y = 25,
    SCALE = 20;

color ALIVE = #56b5ef,
      DEAD = #2239c4;

PImage a, b;

boolean pause = false;

void setup() {
  size(GRID_X * SCALE, GRID_Y * SCALE);
  frameRate(8);
  a = randomImage();
  noStroke();
  background(DEAD);
}

void draw() {
  b = conwayEvolution(a);
  drawImage(pause ? b : (a = b));
}

PImage conwayEvolution(PImage img)
{
  PImage img_ = createImage(img.width, img.height, RGB);

  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++)
    {
      int n = countNeighbours(img, i, j);
      
      if ( img.get(i, j) == ALIVE ) { // Live cell
        if (n < 2) img_.set(i, j, DEAD); // Die by under-population
        if (n == 2 || n == 3) img_.set(i, j, ALIVE); // Continue to live
        if (n > 3) img_.set(i, j, DEAD); // Die by overcrowding
      }
      else { // Dead cell
        if (n == 3) img_.set(i, j, ALIVE); // Reproduction
      }
    }
  }
  return img_;
}

int countNeighbours(PImage img, int x, int y)
{
  return isAlive(img, x-1, y-1) + isAlive(img, x, y-1 ) + isAlive(img, x+1, y-1)
       + isAlive(img, x-1, y  )                         + isAlive(img, x+1, y  )
       + isAlive(img, x-1, y+1) + isAlive(img, x, y+1 ) + isAlive(img, x+1, y+1);
}

int isAlive(PImage img, int x, int y)
{
  x = x < 0 ? x + img.width : x % img.width;
  y = y < 0 ? y + img.height: y % img.height;
  return img.get(x, y) == ALIVE ? 1 : 0;
}

PImage randomImage()
{
  PImage img = createImage(GRID_X, GRID_Y, RGB);
  for (int i = 0; i < img.pixels.length; i++)
    img.pixels[i] = random(0, 1) < 0.5 ? ALIVE : DEAD;
  img.updatePixels();
  return img;
}

void drawImage(PImage img)
{
  for (int i = 0; i < a.width; i++)
    for (int j = 0; j < a.height; j++)
    {
      color c = a.get(i, j) == ALIVE ? ALIVE : DEAD; 
      if(c == ALIVE) {
        fill(c);
        ellipse(i * SCALE + (SCALE>>1), j * SCALE + (SCALE>>1), SCALE, SCALE);
      }
      else {
        fill(c, 50);
        rect(i * SCALE, j * SCALE, (i+1) * SCALE, (j+1) * SCALE);
      }
    }
}

boolean check = false;
int x_ = -1, y_ = -1, c_ = 0;
void drawPoint() {
  int x = mouseX/SCALE, y = mouseY/SCALE;
  if(check && x == x_ && y == y_) return;
  int c = check ? c_ : (a.get(x, y) == ALIVE ? DEAD : ALIVE);
  a.set(x, y, c);
  x_ = x; y_ = y; c_ = c;
}


// Mouse Events

void mousePressed() { check = false; drawPoint(); }
void mouseDragged() { check = true; if (mousePressed) drawPoint(); }

// Keyboard Events

void keyPressed() {
  switch(keyCode) {
    case BACKSPACE: a = randomImage(); break;
    case DELETE: a = createImage(GRID_X, GRID_Y, RGB); break;
    default: pause = !pause;
  }
}
