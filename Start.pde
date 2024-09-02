class Start {
  PImage start;
  Start() {
    start = loadImage("data/start.png");
  }
  void initalize() {
    image(start,400,300);
    
    if(attack) {
      nextLevel = true;
    }
  }

 
}
