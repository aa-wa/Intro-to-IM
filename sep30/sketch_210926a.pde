// 

// data source: covidtracking.com/data

String strings[]; //creating an array of strings

void setup() {
  size(800, 450);
  background(120,130,250);//keeping the background static so as to keep all the shapes in sight
  strings = loadStrings("D:/IM/national_history.csv"); //loading a csv file into the array
  frameRate(10); //lower framerate for a visible animation
}


int csvRowN = 1; //an integer indicating a row number
int rectYPos = 350; //an integer idnicating the y-position of the shapes

void draw() {
  String row[]; //creating a string to store a column from each row
  row = split(strings[csvRowN], ","); //splitting row number one into different columns by splitting at the comma
  fill(random(255), random(255), random(255));
  rect(100, rectYPos, float(row[2])/5, 30); //taking the third column of the rows .i.e. the increased deaths 
  csvRowN += 1;  //increasing the row number by one after each loop
  rectYPos-=50; //decreasing the y position of the shapes by 50 pixels after each loop
  if (csvRowN >= 8) {
    noLoop(); //if the row number is above row 8, the loop stops
  }
}
