
int generation;

int map_x = 40;
int map_y = 60;

boolean stop = false;
boolean[][][] matrix;

void setup() {
  // pismo
  //fontA = loadFont("Calibri-Bold-48.vlw");
  //textFont(fontA, 18);
  
  background(0);
  frameRate(14);
  smooth();
  
  size(620, 460, P2D);
  noStroke();
  
  generation = 1;
  matrix = new boolean[map_y][map_x][2];
  
  Random random = new Random();
 
  for(int y = 0; y < map_y; y++)
    for(int x = 0; x < map_x; x++) {
      matrix[y][x][0]= random.nextBoolean();
    }
}

void draw() {
  background(0);
  delay(20);
  drawMatrix();
  //drawText();
  
  if(stop == false) {
    updateMatrix();
    generation++;
  }
}

boolean access_element(int x, int y) {
  if (x < 0)      x = map_x-1;
  if (y < 0)      y = map_y-1;
  if (x >= map_x) x = 0;
  if (y >= map_y)  y = 0;
    
  return matrix[y][x][0];
}

void drawMatrix() {
 
  for(int y = 0; y < map_y; y++) {
    for(int x = 0; x < map_x; x++) {
      if(matrix[y][x][0]) {
        fill(153, 204, 3);
        rect( (y+1)*10, (x+1)*10, 8, 8);
      }
      else {
        fill(51);
        rect((y+1)*10, (x+1)*10, 8, 8);
      }
    }
  }
}

void updateMatrix() {
  for (int y = 0; y < map_y; y++) {
    for (int x = 0; x < map_x; x++) {
      int neighbour = 0;
      if(access_element(x-1, y)) neighbour++;
      if(access_element(x+1, y))  neighbour++;
      if(access_element(x, y+1))  neighbour++;
      if(access_element(x, y-1))  neighbour++;
      if(access_element(x-1, y-1))  neighbour++;
      if(access_element(x+1, y-1))  neighbour++;
      if(access_element(x-1, y+1))  neighbour++;
      if(access_element(x+1, y+1))  neighbour++;
      
      if(neighbour < 2 || neighbour > 3) matrix[y][x][1] = false;
            if(neighbour == 3) matrix[y][x][1] = true;
    }
  }
  
  for(int y = 0; y < map_y; y++)
        for(int x = 0; x < map_x; x++)
            matrix[y][x][0]=matrix[y][x][1];
}

/*
void drawText() {
  fill(153, 204, 3);
  
  // vypisat pole
  char[] hash = new char[map_x*map_y];
  int count = 0;

  for(int x = 0; x < map_x; x++) {
    for(int y = 0; y < map_y; y++) {
      if(matrix[y][x][0])    
        hash[count] = '1';
      else
        hash[count] = '0';
      count++;   
    }
  }
  
  String stringHash = new String(hash);
  println(stringHash); // vypis do konzoly
  text(stringHash, 10, 400);
  text("generation:", 10, 440);
  text(generation, 200, 440);
}
*/

void mouseDragged() {
  
   int xx = floor( mouseY/10);
   int yy = floor( mouseX/10);
  
  if(xx < (map_x) && xx >= 0 && yy < (map_y) && yy >= 0) { 
   matrix[yy][xx][0] = !matrix[yy][xx][0];
   matrix[yy][xx][1] = !matrix[yy][xx][1];
  }
}

void mousePressed() {
  int xx = floor( mouseY/10);
  int yy = floor( mouseX/10);
  
  if (mouseButton == LEFT) {
    if(xx < (map_x) && xx >= 0 && yy < (map_y) && yy >= 0) {
      matrix[yy][xx][0] = !matrix[yy][xx][0];
      matrix[yy][xx][1] = !matrix[yy][xx][1];
    }
  }
  else if (mouseButton == RIGHT) {
    stop = !stop;
    // screenshot
    //save("screenshot.png");
  }
}
