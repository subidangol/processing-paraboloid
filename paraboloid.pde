final float SIGMA = 0.2;
final float COEFFICIENT = 2 * PI * sq(SIGMA);

PVector[][] vertexes = new PVector[100][100];
float camOrbitRadius = 120;

/**
 * Function of gaussin curvature.
 * https://en.wikipedia.org/wiki/Paraboloid
 *
 * @param u u argument
 * @param v v argument
 *
 * @return result of function
 */
float gaussian(final float u, final float v) {
  return (1 / COEFFICIENT)
    * exp(-(sq(u) + sq(v)) / COEFFICIENT);
}

void setup() {
  size(500, 500, P3D);
  println(COEFFICIENT);
  
  /* Calculate vertexes with function */
  for (int x = 0; x < 100; x++) {
    for (int z = 0; z < 100; z++) {
      final float fx = map(x, 0, 100, -1.2, 1.2);
      final float fz = map(z, 0, 100, -1.2, 1.2);
      vertexes[x][z] = new PVector(x - 50, - gaussian(fx, fz) * 10, z - 50);
    }
  }
}

void mouseWheel(final MouseEvent event) {
  camOrbitRadius += event.getCount() * 2;
}

void draw() {
  
  /* Clear & translate */
  background(0);
  translate(width / 2, height / 2, 0);
  
  /* Position camera */
  final float camPosX = cos(map(mouseX, 0, width, -PI, 0)) * camOrbitRadius;
  final float camPosY = sin(map(mouseY, 0, height, -PI, PI)) * camOrbitRadius;
  final float camPosZ = cos(map(mouseY, 0, height, -PI, PI)) * camOrbitRadius;
  
  camera(
    camPosX, camPosY, camPosZ,
    0, 0, 0,
    0, 1, 0);
  
  /* Draw surface */
  fill(30, 30, 255);
  stroke(255, 0, 0);
  
  beginShape(QUADS);
  
  for (int x = 0; x < 100 - 1; x++) {
    for (int z = 0; z < 100 - 1; z++) {
      vertex(vertexes[x][z].x, vertexes[x][z].y, vertexes[x][z].z);
      vertex(vertexes[x + 1][z].x, vertexes[x + 1][z].y, vertexes[x + 1][z].z);
      vertex(vertexes[x + 1][z + 1].x, vertexes[x + 1][z + 1].y, vertexes[x + 1][z + 1].z);
      vertex(vertexes[x][z + 1].x, vertexes[x][z + 1].y, vertexes[x][z + 1].z);
    }
  }
  
  endShape();
}