void setup() {
  size (700, 700);
}

float n=2000; //number of circles

void draw() {
  frameRate(20);

  for (float d = n; d>0; d = d - 75) //d = diameter of the circle
  {
    fill(random(255), random(255), random(255));
    circle(height/2, width/2, d);
  }
  n = n - 5;
}
