PImage[] bossIdleRight = new PImage[8];
PImage[] bossIdleLeft = new PImage[8];
PImage[] bossAttackRight = new PImage[13];
PImage[] bossAttackLeft = new PImage[13];
PImage[] bossEscapeRight = new PImage[9];
PImage[] bossEscapeLeft = new PImage[9];
int bossIdleFrame = 0;
int bossAttackFrame = 0;
int bossEscapeFrame = 0;
int riseFrame = 8;
class Boss {
  float x, y, w, h;
  float hp = 80;
  String direction = "left";
  boolean isAttack = false;
  boolean isEscape = false;
  boolean isRise = false;
  Boss(float x, float y) {
    this.x = x;
    this.y = y;
    this.w = 50;
    this.h = 80;
    for (int i=0; i<=7; i++) {
      bossIdleRight[i] = loadImage("/data/boss/idle_right/tile00"+i+".png");
    }
    for (int i=0; i<=7; i++) {
      bossIdleLeft[i] = loadImage("/data/boss/idle_left/tile00"+i+".png");
    }
    for (int i=0; i<=12; i++) {
      bossAttackRight[i] = loadImage("/data/boss/attack_right/tile00"+i+".png");
    }
    for (int i=0; i<=12; i++) {
      bossAttackLeft[i] = loadImage("/data/boss/attack_left/tile00"+i+".png");
    }
    for (int i=0; i<=8; i++) {
      bossEscapeRight[i] = loadImage("/data/boss/escape_right/tile00"+i+".png");
    }
    for (int i=0; i<=8; i++) {
      bossEscapeLeft[i] = loadImage("/data/boss/escape_left/tile00"+i+".png");
    }
  }

  void initalize() {
    display();
    update();
  }

  void display() {
    if (isAttack) {
      attack();
    } else if (isEscape) {
      escape();
    } else if (isRise) {
      rise();
    } else {
      idle();
    }
    hpDisplay();
    fireRockDisplay();
  }

  void update() {
    if (frameCount%600 == 0) {
      isEscape = true;
    }
    
    if (x - sandy.x < 57 && x - sandy.x >0) {
      isEscape = true;
    } else if (x - sandy.x > -57  && x - sandy.x <0) {
      isEscape = true;
    }
    
    if ( frameCount%300 == 0) {
      isAttack = true;
    }
    
    if(attack) {
      if(sandy.direction == "right") {
        if(detectCollisionForAttack(sandy.x + 20, sandy.y, 85, 70, x, y+30, w, h)) {
          hp -= 0.2;
        }
      } else if (sandy.direction == "left") {
        if(detectCollisionForAttack(sandy.x - 20, sandy.y, 85, 70, x, y+30, w, h)) {
          hp -= 0.2;
        }
      }
    }
  }
  
  void hpDisplay() {
    fill(255,0,0);
    rect(x, y-30, hp, 10);
  }

  void idle() {
    if (direction == "left") {
      image(bossIdleLeft[bossIdleFrame], x, y);
    } else {
      image(bossIdleRight[bossIdleFrame], x, y);
    }

    if (bossIdleFrame == 7) {
      bossIdleFrame = 0;
    } else if (frameCount%10 == 0) {
      bossIdleFrame++;
    }
  }

  void attack() {
    if (direction == "left") {
      image(bossAttackLeft[bossAttackFrame], x, y);
    } else {
      image(bossAttackRight[bossAttackFrame], x, y);
    }

    if (bossAttackFrame == 12) {
      bossAttackFrame = 0;
      fireRockRain();
      isAttack = false;
    } else if (frameCount%10 == 0) {
      bossAttackFrame++;
    }
  }

  void escape() {
    if (direction == "left") {
      image(bossEscapeLeft[bossEscapeFrame], x, y);
    } else {
      image(bossEscapeRight[bossEscapeFrame], x, y);
    }

    if (bossEscapeFrame == 8) {
      bossEscapeFrame = 0;
      if (direction == "left") {
        x = random(0, 200);
        direction = "right";
      } else if (direction == "right") {
        x = random(600, 800);
        direction = "left";
      }
      isEscape = false;
      isRise = true;
    } else if (frameCount%6 == 0) {
      bossEscapeFrame++;
    }
  }

  void rise() {
    if (direction == "left") {
      image(bossEscapeLeft[riseFrame], x, y);
    } else {
      image(bossEscapeRight[riseFrame], x, y);
    }

    if (riseFrame == 0) {
      riseFrame = 8;
      isRise = false;
    } else if (frameCount%6 == 0) {
      riseFrame--;
    }
  }

  void fireRockRain() {
    for (int i = 0; i < 5; i++) {
      fireRocks.add(new FireRock(random(sandy.x-50, sandy.x + 50), random(-300, -100), 9));
    }
  }

  void fireRockDisplay() {
    for (int i = 0; i < fireRocks.size(); i++) {
      FireRock fireRock = fireRocks.get(i);
      fireRock.display();
    }
  }
}
