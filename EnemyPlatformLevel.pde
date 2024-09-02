class EnemyPlatformLevel {
  Platform enemyPlatformLevelGround;
  Platform enemyPlatformLevelGround1;
  Platform enemyPlatformLevelGround2;
  Platform enemyPlatformLevelGround3;
  Platform rightBlock;
  Platform block;
  Platform block2v;
  Platform block2v_1;
  Platform block_1;
  Platform block_2;
  Platform block3v;
  Platform straw;
  Platform straw2;
  Platform straw3;
  Platform table;
  Platform table2;
  Platform table3;
  Platform table4;
  Platform table5;
  Platform table6;
  Platform table7;
  Enemy enemy;
  Enemy enemy1;
  Enemy enemy2;
  Enemy enemy3;
  Enemy enemy4;
  Enemy enemy5;
  Enemy enemy6;
  PImage enemyPlatformBackground;
  EnemyPlatformLevel () {
    enemyPlatformLevelGround = new Platform(400, 580, 800, 40, "/data/platformer/ground.png");
    enemyPlatformLevelGround1 = new Platform(1200, 580, 800, 40, "/data/platformer/ground.png");
    enemyPlatformLevelGround2 = new Platform(2300, 580, 800, 40, "/data/platformer/ground.png");
    enemyPlatformLevelGround3 = new Platform(3100, 580, 800, 40, "/data/platformer/ground.png");
    rightBlock = new Platform(-20, 520, 40, 80, "/data/platformer/block_2_v.png");
    enemyPlatformBackground = loadImage("/data/platformer/background.jpg");
    block = new Platform(460, 540, 40, 40, "/data/platformer/block.png");
    block2v = new Platform(550, 520, 40, 80, "/data/platformer/block_2_v.png");
    block2v_1 = new Platform(650, 520, 40, 80, "/data/platformer/block_2_v.png");
    block3v = new Platform(750, 500, 40, 120, "/data/platformer/block_3_v.png");
    straw = new Platform(1100, 540, 57, 40, "/data/platformer/straw.png");
    straw2 = new Platform(1157, 520, 57, 80, "/data/platformer/straw.png");
    straw3 = new Platform(1560, 540, 57, 40, "/data/platformer/straw.png");
    table = new Platform(1560, 540, 63, 40, "/data/platformer/table_2.png");
    table2 = new Platform(1693, 500, 63, 40, "/data/platformer/table_2.png");
    table3 = new Platform(1806, 500, 63, 40, "/data/platformer/table_2.png");
    table4 = new Platform(1940, 540, 63, 40, "/data/platformer/table_2.png");
    table5 = new Platform(1560, 540, 63, 40, "/data/platformer/table_2.png");
    table6 = new Platform(1560, 540, 63, 40, "/data/platformer/table_2.png");
    table7 = new Platform(1560, 540, 63, 40, "/data/platformer/table_2.png");
    enemy = new Enemy(300, 540);
    enemy1 = new Enemy(900, 540);
    enemy2 = new Enemy(1000, 540);
    enemy3 = new Enemy(1250, 540);
    enemy4 = new Enemy(2300, 540);
    enemy5 = new Enemy(2400, 540);
    enemy6 = new Enemy(2500, 540);
  }

  void initalize() {
    update();
    image(enemyPlatformBackground, 400, 300);
    image(enemyPlatformBackground, 1600, 300);
    image(enemyPlatformBackground, 2800, 300);
    platforms.clear();
    platforms.add(enemyPlatformLevelGround);
    platforms.add(enemyPlatformLevelGround1);
    platforms.add(enemyPlatformLevelGround2);
    platforms.add(enemyPlatformLevelGround3);
    platforms.add(rightBlock);
    platforms.add(block);
    platforms.add(block2v);
    platforms.add(block2v_1);
    platforms.add(block3v);
    platforms.add(straw);
    platforms.add(straw2);
    platforms.add(table);
    platforms.add(table2);
    platforms.add(table3);
    platforms.add(table4);
    platforms.add(table5);
    platforms.add(table6);
    platforms.add(table7);
    enemy.initalize();
    enemy1.initalize();
    enemy2.initalize();
    enemy3.initalize();
    enemy4.initalize();
    enemy5.initalize();
    enemy6.initalize();
  }

  void update() {
    if (sandy.x > 566 && sandy.x < 732 && sandy.y == 525) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }

    if (sandy.y > 800) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }

    if (sandy.getRight() > 2600) {
      nextLevel = true;
    }
  }
}
