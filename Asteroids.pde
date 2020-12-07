int mode;
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
final int WIN = 4;

void setup(){
  size(800,800);
  rectMode(CENTER);
  textAlign(CENTER);
  mode = INTRO;
  myShip = new Spaceship();
  myEnemy = new Enemy();
  wkey=akey=skey=dkey=false;
  myObjects = new ArrayList<GameObject>();
 
  myObjects.add(new Asteroid());
  myObjects.add(new Asteroid());
  myObjects.add(new Asteroid());
  myObjects.add(new Asteroid());
  myObjects.add(new Asteroid());
}

void draw() {
  if (mode == INTRO) {
    intro();
  }else if (mode == GAME){
    game();
  }else if (mode == PAUSE){
    pause();
  }else if (mode == WIN){
    win();
  }else if (mode == GAMEOVER){
    gameover();
  }else{
    println( "ERROR: Mode = " + mode);
  }
}
