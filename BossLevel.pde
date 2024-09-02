class BossLevel {
  Platform bossLevelGround;
  Platform rightBlock;
  Platform leftBlock;
  Boss boss;
  PImage bossBackground;
  BossLevel() {
    bossLevelGround = new Platform(400, 580, 800, 40, "/data/platformer/ground.png");
    rightBlock = new Platform(-20, 580, 40, 80, "/data/platformer/block_2_v.png");
    leftBlock = new Platform(820, 580, 40, 80, "/data/platformer/block_2_v.png");
    boss = new Boss (650, 450);
    bossBackground = loadImage("/data/platformer/background.jpg");
  }

  void initalize() {
    image(bossBackground,400,300);
    platforms.clear();
    platforms.add(bossLevelGround);
    platforms.add(rightBlock);
    platforms.add(leftBlock);
    boss.initalize(); 
    if(boss.hp <= 0) {
      nextLevel = true;
    }
  }
}
