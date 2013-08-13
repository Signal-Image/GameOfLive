class Life
{
  private color[][] k = new color[GRID_X][GRID_Y];

  Life() {}

  Life(int status) {
    randomize();
  }

  void randomize() {
    for (int i = 0; i < GRID_X; i++)
      for (int j = 0; j < GRID_Y; j++)
        k[i][j] = random(0, 1) < 0.5 ? ALIVE : DEAD;
  }

  void set(int x, int y, color c) {
    k[x][y] = c;
  }

  color get(int x, int y) {
    return k[x][y];
  }

  void inverse(int x, int y) {
    k[x][y] = k[x][y] == ALIVE ? DEAD : ALIVE;
  }

  Life conwayEvolution() {
    Life b = new Life();

    for (int i = 0; i < GRID_X; i++)
      for (int j = 0; j < GRID_Y; j++)
      {
        int n = countNeighbours(i, j);

        if ( get(i, j) == ALIVE ) {
          // A living cell stays alive if it has 2 or 3 living neighbours
          b.set(i, j, (n == 2 || n == 3) ? ALIVE : DEAD);
        }
        else {
          // A dead cell gets alive if it has 3 living neighbours
          b.set(i, j, (n == 3) ? ALIVE : DEAD);
        }
      }

    return b;
  }

  int countNeighbours(int x, int y) {
    return isAlive(x-1, y-1) + isAlive(x, y-1 ) + isAlive(x+1, y-1)
         + isAlive(x-1, y  )                    + isAlive(x+1, y  )
         + isAlive(x-1, y+1) + isAlive(x, y+1 ) + isAlive(x+1, y+1);
  }

  int isAlive(int x, int y) {
    x = x < 0 ? x + GRID_X : x % GRID_X;
    y = y < 0 ? y + GRID_Y : y % GRID_Y;
    return get(x, y) == ALIVE ? 1 : 0;
  }

  void draw() {
    for (int i = 0; i < GRID_X; i++)
      for (int j = 0; j < GRID_Y; j++)
        drawCell(i, j);
  }
  
  void drawCell(int x, int y) {
    color c = get(x, y) == ALIVE ? ALIVE : DEAD;

    if(c == ALIVE) {
      fill(c);
      ellipse(x * SCALE + (SCALE>>1), y * SCALE + (SCALE>>1), SCALE, SCALE);
    } else {
      fill(c, 200);
      rect(x * SCALE, y * SCALE, SCALE, SCALE);
    }
  }
}

