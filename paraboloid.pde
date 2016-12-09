final float A = 3;
final float B = 4;

final PVector[][] vertexes = new PVector[100][100];

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
  return (sq(u) - sq(v)) / 2;
  //return 4 / (
  //  sq(A)
  //  * sq(B)
  //  * (
  //    1
  //    + (4 * sq(u)) / sq(sq(A))
  //    + (4 * sq(v)) / sq(sq(B))
  //  ));
}

void setup() {
  size(500, 500, P3D);
  
  for (int x = 0; x < 100; x++) {
    for (int z = 0; z < 100; z++) {
      vertexes[x][z] = new PVector(x, gaussian(x, z), z);
    }
  }
}

void draw() {
  background(0);
  translate(width / 2, height / 2, 0);
  
  fill(200);
  stroke(155);
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