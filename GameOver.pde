class GameOver {
  PImage gameOver;
  GameOver() {
    gameOver = loadImage("data/youlost.png");
  }
  void initalize() {
    image(gameOver,400,300);
    if(attack) {
      tryAgain = true;
    }
  }
}
