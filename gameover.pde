void gameover(){
  background(150,0,0);
  button(700,750,200,100,"INTRO");
  textSize(100);
  fill(255);
  text("GAME OVER",400,100);
  noStroke();
  fill(0);
  triangle(300, 600, 400, 400, 500, 600);
  ellipse(400,430,50,70);
  ellipse(510,350,170,140);
  ellipse(290,350,170,140);
  triangle(480, 550, 430, 420, 530, 450);
  triangle(320, 550, 370, 420, 270, 450);
  
  fill(50);
  triangle(320, 580, 400, 420, 480, 580);
  
  fill(0);
  rect(400,500,20,200);
  rect(440,540,20,80);
  rect(435,525,10,80);
  
  rect(360,540,20,80);
  rect(365,525,10,80);
}

void gameoverClicks(){

       if (touchingMouse(700,750,200,100)){
    mode = INTRO;
    setup();
  }
}
