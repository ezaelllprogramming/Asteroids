void intro(){
  background(0,0,0);
  
  int i = 0;
  while (i < myObjects.size()) {
    GameObject myObj = myObjects.get(i);

    myObj.show();
    myObj.act();

    if (myObj.lives == 0) {
      myObjects.remove(i);
    } else {
      i++;
    }
  }
  
  button(400,350,200,100,"START");
  button(400,600,200,100, "QUIT");
  textSize(100);
  fill(255);
  text("ASTEROIDS",400,200);
}

void introClicks(){
    if (touchingMouse(400,350,200,100)){
    mode = GAME;
  }
  if (touchingMouse(400,600,200,100)){
    exit();
  }

}

class introAsteroid extends GameObject {

  introAsteroid() {
    location = new PVector (random(width), random(height));
    velocity = new PVector (1, 0);
    velocity.rotate(random(TWO_PI));
    size = 100;
    lives = 1;
  }

  introAsteroid(float s, float x, float y) {
    lives = 1;
    location = new PVector (x, y);
    velocity = new PVector (0, 1);
    velocity.rotate(random(0, TWO_PI));
    size = s;
  }

  void show() {
    strokeWeight(3);
    stroke(0);
    fill(100);
    ellipse(location.x, location.y, size, size);
  }

  void act() {
    super.act();
    if (location.x < 0) location.x = width;
    if (location.x > width) location.x = 0;
    if (location.y < 0) location.y = height;
    if (location.y > height) location.y = 0;
  }
}
