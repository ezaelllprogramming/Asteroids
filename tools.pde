void button(int x,int y, int w, int h, String label) {  
  if(mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2){
    stroke(255,0,0);
    strokeWeight(5);
    textSize(60);
  }else{
    stroke(0);
    strokeWeight(1);
    textSize(50);
  }
  fill(255);
  rect(x,y,w,h);
  fill(0);
  text(label,x,y);
}

boolean touchingMouse(int x, int y, int w, int h){
  if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2){
    return true;
  }else{
    return false;
  }
}

void heart1() {
  noStroke();
  fill(255,0,0);
  beginShape();
  vertex(50, 15);
  bezierVertex(50, -5, 90, 5, 50, 40);
  vertex(50, 15);
  bezierVertex(50, -5, 10, 5, 50, 40);
  endShape(); 
}

void heart2() {
  noStroke();
  fill(255,0,0);
  beginShape();
  vertex(100, 15);
  bezierVertex(100, -5, 140, 5, 100, 40);
  vertex(100, 15);
  bezierVertex(100, -5, 60, 5, 100, 40);
  endShape(); 
}

void heart3() {
  noStroke();
  fill(255,0,0);
  beginShape();
  vertex(150, 15);
  bezierVertex(150, -5, 190, 5, 150, 40);
  vertex(150, 15);
  bezierVertex(150, -5, 110, 5, 150, 40);
  endShape();
}
