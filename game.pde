Spaceship myShip;
Enemy myEnemy;
ArrayList<GameObject> myObjects;

boolean wkey, akey, skey, dkey, spacekey;

void game() {
  background(0, 0, 0);

  button(100, 750, 200, 100, "PAUSE");

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
  myShip.show();
  myShip.act();

  println(asteroidCounter());
  if (asteroidCounter() == 0) {
    mode = WIN;
  }
}

int asteroidCounter() {
  int count = 0;
  int i = 0;
  while (i < myObjects.size()) {
    GameObject myObj = myObjects.get(i);
    if (myObj instanceof Asteroid) {
      count++;
    }
    i++;
  }

  return count;
}

void gameClicks() {

  if (touchingMouse(100, 750, 200, 100)) {
    mode = PAUSE;
  }
}

class Asteroid extends GameObject {

  Asteroid() {
    location = new PVector (random(width), random(height));
    velocity = new PVector (1, 0);
    velocity.rotate(random(TWO_PI));
    size = 100;
    lives = 1;
  }

  Asteroid(float s, float x, float y) {
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

    int i = 0;
    while (i < myObjects.size()) {
      GameObject myObj = myObjects.get(i);
      if (myObj instanceof Bullet) {
        if (dist(location.x, location.y, myObj.location.x, myObj.location.y) <= size/2 + myObj.size) {
          myObj.lives = 0;
          lives = 0;
          if (size > 30) {
            myObjects.add(new Asteroid(size/2, location.x, location.y));
            myObjects.add(new Asteroid(size/2, location.x, location.y));
          }
        }
      }
      i++;
    }
  }
}

class Bullet extends GameObject {

  int timer;

  Bullet() {
    timer = 100;
    location = new PVector (myShip.location.x, myShip.location.y);
    velocity = new PVector (myShip.direction.x, myShip.direction.y);
    velocity.setMag(5);
    lives = 1;
    size = 10;
  }

  void show() {
    pushMatrix();
    strokeWeight(3);
    stroke(2);
    fill(255, 0, 0);
    translate(location.x, location.y);
    rotate(velocity.heading());
    ellipse(0, 0, size*2, size/2);
    popMatrix();
  }

  void act() {
    super.act();
    dieoffScreen();
    timer--;
    if (timer == 0) {
      lives = 0;
    }
  }
}

class Enemy extends GameObject {

  PVector direction;
  int threshold;
  int shotTimer;
  float appear;

  Enemy() {
    float i = 0;
    location = new PVector(-size, random(0, 800));
    size = 50;
    lives = 1;
    shotTimer = 0;
    threshold = 60;
    appear = 0;
  }

  void show() {
    fill(255, 0, 0);
    ellipse(location.x, location.y, 50, 50);
  }

  void act() {
    if (appear <= 0) {
      location.x = location.x+5;
      if (location.x >= width+size) {
        location.x = 0;
        location.y = random(0, 800);
      }
    }
    if (shotTimer >= threshold) {
      myObjects.add(new Bullet());
      shotTimer = 0;
    }
    shotTimer++;
  }
}

class Fire extends GameObject {

  int t;

  Fire() {
    location = myShip.location.copy();
    velocity = myShip.direction.copy();
    velocity.rotate(PI + random(-0.5, 0.5));
    velocity.setMag(5);
    size = 1;
    lives = 1;
    t = 255;
  }

  void show() {
    strokeWeight(3);
    stroke(random(0, 255), random(0, 100), 0, t);
    fill(random(0, 255), random(0, 100), 0, t);
    t = t - 10;
    rect(location.x, location.y, size, size);
  }

  void act() {
    super.act();
    dieoffScreen();
  }
}

class GameObject {
  PVector location;
  PVector velocity;
  float size;
  int lives;

  GameObject() {
  }

  void show() {
    strokeWeight(3);
    stroke(255);
    fill(0);
    ellipse(location.x, location.y, size, size);
  }

  void act() {
    location.add(velocity);
  }

  void dieoffScreen() {
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      lives = 0;
    }
  }
}

class Spaceship extends GameObject {
  PVector direction;
  int shotTimer, threshold;
  int livesTimer;

  Spaceship() {
    location = new PVector(width/2, height/2);
    direction = new PVector(0.1, 0);
    velocity = new PVector(0, 0);
    size = 50;
    lives = 3;
    shotTimer = 0;
    threshold = 20;
    livesTimer = 0;
  }

  void show() {
    pushMatrix();
    fill(255);
    strokeWeight(3);
    stroke(255);
    translate(location.x, location.y);
    rotate(direction.heading());
    rect(-10, 18, 40, 10);
    rect(-10, -18, 40, 10);
    line(-30, -50, 0, 50);
    line(-30, 50, 0, -50);
    line(-30, 50, -10, 50);
    line(0, 50, 20, 50);
    line(-30, -50, -10, -50);
    line(0, -50, 20, -50);
    triangle(-25, -12.5, -25, 12.5, 40, 0);
    stroke(70);
    fill(70);
    ellipse(-5, 0, -30, -10);
    popMatrix();
  }

  void act() {
    livesTimer++;
    super.act();
    int i = 0;
    while (i < myObjects.size() && livesTimer >= 60) {
      GameObject myObj = myObjects.get(i);
      if (myObj instanceof Asteroid) {
        if (dist(location.x, location.y, myObj.location.x, myObj.location.y) <= myObj.size) {

          lives--;
          livesTimer = 0;
        }
      }
      i++;
    }

    if (lives == 3) {
      heart1();
      heart2();
      heart3();
    }

    if (lives == 2) {
      heart1();
      heart2();
    }

    if (lives == 1) {
      heart1();
    }

    if (lives == 0) {
      mode = GAMEOVER;
      location = new PVector(width/2, height/2);
      direction = new PVector(0.1, 0);
      velocity = new PVector(0, 0);
      size = 50;
      lives = 3;
      shotTimer = 0;
      threshold = 20;
    }

    shotTimer++;

    if (wkey) {
      velocity.add(direction);
      myObjects.add(new Fire());
      myObjects.add(new Fire());
      myObjects.add(new Fire());
      myObjects.add(new Fire());
    }
    if (skey) velocity.sub(direction);
    if (dkey) direction.rotate(radians(5));
    if (akey) direction.rotate(-radians(5));
    if (spacekey && shotTimer >= threshold) {
      myObjects.add(new Bullet());
      shotTimer = 0;
    }
  }
}

class Explosion extends GameObject {

  int t;

  Explosion() {
    //location = myShip.location.copy();
    //velocity = myShip.direction.copy();
    velocity.rotate(PI + random(-0.5, 0.5));
    velocity.setMag(5);
    size = 1;
    lives = 1;
    t = 255;
  }

  void show() {
    strokeWeight(3);
    stroke(random(0, 255), random(0, 100), 0, t);
    fill(random(0, 255), random(0, 100), 0, t);
    t = t - 10;
    rect(location.x, location.y, size, size);
  }

  void act() {
    super.act();
    dieoffScreen();
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (key == ' ') spacekey = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (key == ' ') spacekey = false;
}
