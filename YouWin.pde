class YouWin {
  PImage youwin;
  YouWin() {
    youwin = loadImage("data/youwin.png");
  }
  void initalize() {
    image(youwin,400,300);
    
    if(attack) {
      tryAgain = true;
    }
  }

 
}
