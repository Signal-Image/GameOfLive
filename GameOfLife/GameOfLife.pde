int GRID_X = 25,
    GRID_Y = 25,
    SCALE = 20;

color ALIVE = #56b5ef,
      DEAD = #2239c4;

Life a;

boolean pause = false;

void setup()
{
  size(GRID_X * SCALE, GRID_Y * SCALE);
  frameRate(8);

  noStroke();
  background(DEAD);

  a = new Life(1);
}

void draw()
{
  if(!pause) a = a.conwayEvolution();
  a.draw();
}

int x_ = -1, y_ = -1, c_ = 0;

void drawPoint(boolean check)
{
  int x = mouseX/SCALE,
      y = mouseY/SCALE;

  color c;

  if(check) {
    if(x == x_ && y == y_) return;
    c = c_;
  } else {
    c = a.get(x, y) == ALIVE ? DEAD : ALIVE;
  }

  a.set(x, y, c);

  x_ = x; y_ = y; c_ = c;
}


// Mouse Events

void mousePressed() { drawPoint(false); }
void mouseDragged() { drawPoint(true); }

// Keyboard Events

void keyPressed() {
  switch(keyCode) {
    case BACKSPACE: a = new Life(); pause = true; break;
    case ENTER:
    case RETURN:    a = new Life(1); pause = false; break;
    default: pause = !pause;
  }
}
