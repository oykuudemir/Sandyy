class EscapeLevel {
  PImage escapeLevelBackground;
  PImage water;
  Platform escapeLevelGround;
  Platform escapeLevelGround2;
  Platform escapeLevelGround3;
  Platform escapeLevelGround4;
  Platform escapeLevelGround5;
  Platform block2;
  Platform block;
  Platform block_3;
  Platform block_1;
  Platform rock;
  Platform block_2;
  Platform block_4;
  Platform block3;
  Platform block4;
  Platform block5;
  Platform block6;

  float fireRockX = 0;
  EscapeLevel() {
    escapeLevelBackground = loadImage("/data/platformer/background.jpg");
    water = loadImage("/data/platformer/water.png");
    escapeLevelGround = new Platform(160, 580, 800, 40, "/data/platformer/ground.png");
    escapeLevelGround2 = new Platform(1000, 580, 800, 40, "/data/platformer/ground.png");
    escapeLevelGround3= new Platform(1800, 580, 800, 40, "/data/platformer/ground.png");
    escapeLevelGround4 = new Platform(2680, 580, 800, 40, "/data/platformer/ground.png");
    escapeLevelGround5 = new Platform(3480, 580, 800, 40, "/data/platformer/ground.png");
    block2 = new Platform(300, 540, 160, 40, "/data/platformer/block_4.png");
    block = new Platform(580, 540, 50, 40, "/data/platformer/block.png");
    block_3 = new Platform(900, 540, 160, 40, "/data/platformer/block_3.png");
    block_1 = new Platform(953, 500, 55, 40, "/data/platformer/block.png");
    rock = new Platform(1400, 540, 50, 40, "/data/platformer/rock.png");
    block_2 = new Platform(1450, 540, 50, 40, "/data/platformer/block.png");
    block_4 = new Platform(2000, 540, 200, 40, "/data/platformer/block_4.png");
    block3 = new Platform(2025, 500, 150, 40, "/data/platformer/block_3.png");
    block4 = new Platform(2750, 540, 200, 40, "/data/platformer/block_4.png");
    block5 = new Platform(2775, 500, 150, 40, "/data/platformer/block_3.png");
    block6 = new Platform(2800, 460, 100, 40, "/data/platformer/block_2.png");
  }

  void initalize() {
    backgroundDisplay();
    fireRockRain();
    platforms.clear();
    platforms.add(escapeLevelGround);
    platforms.add(escapeLevelGround2);
    platforms.add(escapeLevelGround3);
    platforms.add(escapeLevelGround4);
    platforms.add(escapeLevelGround5);
    platforms.add(block2);
    platforms.add(block);
    platforms.add(block_3);
    platforms.add(block_1);
    platforms.add(rock);
    platforms.add(block_2);
    platforms.add(block_4);
    platforms.add(block3);
    platforms.add(block4);
    platforms.add(block5);
    platforms.add(block6);
    
    if(sandy.getRight() > 3100) {
      nextLevel = true;
    }
    
    if (sandy.y > 800) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
      fireRockX = 0;
    }

  }
  void backgroundDisplay() {
    image(escapeLevelBackground, 400, 300);
    image(escapeLevelBackground, 1600, 300);
    image(escapeLevelBackground, 2800, 300);
    image(escapeLevelBackground, 4000, 300);
    image(water, 2240, 590);
  }

  void fireRockRain() {
    if (frameCount%5 == 0) {
      fireRocks.add(new FireRock(fireRockX, -100, 8));
    }
    for (int i = 0; i < fireRocks.size(); i++) {
      FireRock fireRock = fireRocks.get(i);
      fireRock.display();
    }
    fireRockX += 2.8;
  }
}
