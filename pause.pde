void pause(){
  background(0);
  button(100,100,200,100,"GAME");
}

void pauseClicks(){
  if (touchingMouse(100,100,200,100)){
    mode = GAME;
  }
}
