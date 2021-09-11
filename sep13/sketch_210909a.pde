void setup() {
  size (700, 700);
}

float n=2000;
void draw() {
  frameRate(20);
  for (float a =  n; a>0; a = a - 75) {
    fill(random(255), random(255), random(255));
    circle(height/2,width/2,a);
  }
  n = n - 5;
}
