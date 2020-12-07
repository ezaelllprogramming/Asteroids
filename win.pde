void win(){
  background(255);
  button(700,600,200,100,"INTRO");
  textSize(100);
  noStroke();
  fill(0);
  text("VICTORY",400,100);
  fill(0);
  ellipse(400,400,400,400);
  triangle(400,400,500,300,470,270);
  fill(255);
  ellipse(470,300,100,200);
  ellipse(330,300,100,200);
  fill(0);
  triangle(370,400,470,270,440,240);
  triangle(430,400,330,270,360,240);
  triangle(400,160,360,210,440,210);
}

void winClicks(){

       if (touchingMouse(700,600,200,100)){
    mode = INTRO;
    setup();
  }
}
