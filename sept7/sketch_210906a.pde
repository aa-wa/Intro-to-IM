size(400,500);
background(130,140,200);

//the head
noStroke();
fill(150,100,100);
triangle(250,135,283,163,270,190);
fill(229,194,152);
triangle(120,250,150,300,210,310);
fill(150,100,100);
triangle(183,297,150,300,210,310);
translate(width/2,height/2);
rotate(PI/6.0);
fill(229,194,152);
rect(-70,-104,100,150);
fill(150,100,100);
rect(10,-120,20,170);

//the eyes
stroke(0);
strokeWeight(1);
fill(240,240,240);
ellipse(-40,-85,20,5);
ellipse(10,-85,20,4);
fill(0);
circle(-40,-85,5);
circle(10,-85,4);

noFill();
arc(-40,-90,20,5,-PI,0);
arc(-40,-83,20,5,0,PI);
arc(10,-90,20,4,-PI,0);
arc(10,-83,20,4,0,PI);

//brows
strokeWeight(2);
line(-60,-90,-45,-100);
line(-45,-100,-25,-97);
line(0,-97,25,-100);
line(25,-100,30,-90);

//the nose
strokeWeight(1.9);
stroke(80,30,30);
arc(-33,-30,9,15,PI/2,3*PI/2);
fill(80,30,30);
triangle(-10,-70,-13,-40,-7,-33);
stroke(0);
fill(0);
ellipse(-29,-30,5,3);
ellipse(-13,-30,5,3);

//the mouth
noStroke();
strokeWeight(3);
fill(255);
rect(-35,3,30,10);
triangle(-50,6,-32,3,-32,14);
triangle(-7,3,-7,14,10,6);

//the hair
noFill();
stroke(0);
arc(-45,-120,200,100,3*PI/2,2*PI);
arc(-45,-90,200,100,23*PI/16,2*PI);
arc(-66,-130,100,50,PI,3*PI/2);
arc(-80,-20,40,20,PI/2,PI);
arc(40,-20,40,20,0,PI/2);
arc(60,0,40,20,PI/2,PI);
arc(-100,0,40,20,0,PI/2);

//the neck
stroke(229,192,154);
arc(-20,90,20,20,PI/2,3*PI/2);
strokeWeight(6);
arc(-50,80,20,50,2*PI/3,5*PI/4);
stroke(150,100,100);
line(30,60,40,90);
