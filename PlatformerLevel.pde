PImage platformerBackground;
PImage water;
PImage home;
ArrayList<Rock> rocks =new ArrayList<Rock>();
ArrayList<Key> keys =new ArrayList<Key>();
class PlatformerLevel {
  Platform platformerLevelGround;
  Platform platformerLevelGround1;
  Platform platformerLevelGround3;
  Platform platformerLevelGround4;
  Platform block;
  Platform block2;
  Platform block2v;
  Platform block3;
  Platform block3v;
  Platform block3v_2;
  Platform block_1;
  Platform block2v_1;
  Platform block3v_1;
  Platform block3v_3;
  Platform block2v_2;
  float x = 0;
  PlatformerLevel() {
    platformerBackground = loadImage("/data/platformer/background.jpg");
    water = loadImage("/data/platformer/water.png");
    //1
    platformerLevelGround = new Platform(160, 580, 800, 40, "/data/platformer/ground.png");
    block3v_2 = new Platform(680, 500, 40, 120, "/data/platformer/block_3_v.png");
    block3v = new Platform(540, 500, 40, 120, "/data/platformer/block_3_v.png");
    block3 = new Platform(380, 540, 120, 40, "/data/platformer/block_3.png");
    block2 = new Platform(400, 500, 80, 40, "/data/platformer/block_2.png");
    block2v = new Platform(760, 520, 40, 80, "/data/platformer/block_2_v.png");
    block = new Platform(460, 540, 40, 40, "/data/platformer/block.png");
    //2
    platformerLevelGround1 = new Platform(1060, 580, 800, 40, "/data/platformer/ground.png");
    block_1 = new Platform(980, 540, 40, 40, "/data/platformer/block.png");
    block2v_1 = new Platform(1060, 520, 40, 80, "/data/platformer/block_2_v.png");
    block3v_1 = new Platform(1180, 500, 40, 120, "/data/platformer/block_3_v.png");
    block3v_3 = new Platform(1280, 500, 40, 120, "/data/platformer/block_3_v.png");
    block2v_2 = new Platform(1440, 520, 40, 80, "/data/platformer/block_2_v.png");

    //3
    platformerLevelGround3 = new Platform(1980, 580, 800, 40, "/data/platformer/ground.png");
    platformerLevelGround4 = new Platform(2700, 580, 800, 40, "/data/platformer/ground.png");
    home = loadImage("/data/platformer/home.png");
    keys.add(new Key(610, 370));
    keys.add(new Key(1230, 370));
    keys.add(new Key(1530, 390));
  }

  void initalize() {
    display();
    update();

    platforms.clear();
    platforms.add(platformerLevelGround);
    platforms.add(block);
    platforms.add(block2);
    platforms.add(block2v);
    platforms.add(block3);
    platforms.add(block3v);
    platforms.add(block3v_2);

    platforms.add(platformerLevelGround1);
    platforms.add(block_1);
    platforms.add(block2v_1);
    platforms.add(block3v_1);
    platforms.add(block3v_3);
    platforms.add(block2v_2);

    platforms.add(platformerLevelGround3);
    platforms.add(platformerLevelGround4);
  }

  void display() {
    backgroundDisplay();
  }

  void update() {
    if (sandy.hp > 0 && sandy.y > 600) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }
    println(sandy.getRight());
    if (sandy.getRight() == 740 && sandy.y == 525) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }
    
    if (sandy.getRight() >1120 && sandy.getRight() <1160 && sandy.y == 525) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }
    
    if (sandy.getRight() >1340 && sandy.getRight() <1420 && sandy.y == 525) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }
    
      if (sandy.getRight() >1240 && sandy.getRight() <1260 && sandy.y == 525) {
      sandy.hp--;
      sandy.x = 80;
      sandy.y = 410;
    }

    if (sandy.getRight()> 1650) {
      rockRain();
    }
    for (int i = 0; i < keys.size(); i++) {
      Key selectedKey = keys.get(i);
      selectedKey.display();
      selectedKey.update();
    }

    if (keys.size() == 0 && sandy.getRight() > 2940) {
      nextLevel=true;
    }
  }

  void backgroundDisplay() {
    image(platformerBackground, -800, 300);
    image(platformerBackground, 400, 300);
    image(platformerBackground, 1600, 300);
    image(platformerBackground, 2800, 300);
    image(water, 610, 600);
    image(water, 1520, 600, 120, 80);
    image(home, 3000, 450);
  }

  void rockRain() {
    if (frameCount%20 == 0) {
      rocks.add(new Rock(random(1600, 2500), random(-300, -100)));
    }
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
    }
  }
}

class Rock {
  float rockX;
  float rockY;
  PImage rock;

  Rock(float x, float y) {
    rockX = x;
    rockY = y;
    rock = loadImage("/data/platformer/rock.png");
  }

  void display() {
    image(rock, rockX, rockY);
    rockY+= 8;
    if (sandy.direction == "right") {
      if (rectsCollide(sandy.x + 30, sandy.y + 20, 40, 80, rockX + 35, rockY + 45, 50, 50)) {
        rocks.remove(this);
        if (sandy.hp > 0) sandy.hp--;
        sandy.hurt();
      }
    } else {
      if (rectsCollide(sandy.x + 50, sandy.y + 20, 40, 80, rockX + 35, rockY + 45, 50, 50)) {
        rocks.remove(this);
        sandy.hp--;
        sandy.hurt();
      }
    }
  }
}

class Key {
  float x, y;
  PImage image;

  Key(float x, float y) {
    this.x = x;
    this.y = y;
    image = loadImage("/data/platformer/key.png");
  }

  void initalize() {
    display();
    update();
  }

  void display() {
    image(image, x, y);
  }

  void update() {
    if (sandy.direction == "right") {
      if (rectsCollide(sandy.x + 30, sandy.y + 20, 40, 80, x +20, y, 60, 20)) {
        keys.remove(this);
      }
    } else {
      if (rectsCollide(sandy.x + 50, sandy.y + 20, 40, 80, x + 10, y-10, 60, 20)) {
        keys.remove(this);
      }
    }
  }
}
