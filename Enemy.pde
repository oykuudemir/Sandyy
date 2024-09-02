PImage[] enemyAttackLeft = new PImage[5];
PImage[] enemyAttackRight = new PImage[5];
PImage[] enemyMoveLeft = new PImage[4];
PImage[] enemyMoveRight = new PImage[4];
PImage[] enemyDie = new PImage[4];

int enemyAttackFrame = 0;
int enemyMoveFrame = 0;
int enemyDieFrame = 0;


class Enemy {

  float x = 80;
  float y = 400;
  float maxX = 0;
  float minX = 0;
  float w = 60;
  float h = 25;
  int hp = 1;
  String direction = "right";
  boolean isDead = false;
  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
    this.maxX = x + 50;
    this.minX = x - 50;
    for (int i=0; i<=4; i++) {
      enemyAttackLeft[i] = loadImage("/data/enemy/attack_left/slime-attack-"+i+".png");
    }
    for (int i=0; i<=4; i++) {
      enemyAttackRight[i] = loadImage("/data/enemy/attack_right/slime-attack-"+i+".png");
    }
    for (int i=0; i<=3; i++) {
      enemyMoveLeft[i] = loadImage("/data/enemy/move_left/slime-move-"+i+".png");
    }
    for (int i=0; i<=3; i++) {
      enemyMoveRight[i] = loadImage("/data/enemy/move_right/slime-move-"+i+".png");
    }
    for (int i=0; i<=3; i++) {
      enemyDie[i] = loadImage("/data/enemy/die/slime-die-"+i+".png");
    }
  }


  void initalize() {
    update();
  }

  void update() {
    if (attack) {
      if(sandy.direction == "right") {

        if(detectCollisionForAttack(sandy.x + 20, sandy.y, 85, 70, x, y, w, h)) {
          
          if(frameCount%30 == 0) isDead = true;
        }
      } else if (sandy.direction == "left") {
        if(detectCollisionForAttack(sandy.x - 20, sandy.y, 85, 70, x, y, w, h)) {
          if(frameCount%30 == 0) isDead = true;
        }
      }
    }

    if (!isDead) {
      if (detectCollision(sandy, this) == "RightCollision") {
        direction = "left";
        attack();
        if (frameCount%60 == 0 && sandy.hp > 0) {
          sandy.hurt();
          sandy.hp--;
        }
      } else if (detectCollision(sandy, this) == "LeftCollision") {
        direction = "right";
        attack();
        if (frameCount%60 == 0 && sandy.hp > 0) {
          sandy.hurt();
          sandy.hp--;
        }
      } else {
        if (x == maxX) direction = "left";
        if (x == minX) direction = "right";
        move();
      }
    } else {
      death();
    }
  }

  void move() {
    if (direction == "right") {
      image(enemyMoveRight[enemyMoveFrame], x, y);
      x++;
    } else {
      x--;
      image(enemyMoveLeft[enemyMoveFrame], x, y);
    }

    if (enemyMoveFrame == 3) {
      enemyMoveFrame = 0;
    } else if (frameCount%10 == 0) {
      enemyMoveFrame++;
    }
  }

  void attack() {
    if (direction == "right") {
      image(enemyAttackRight[enemyAttackFrame], x, y);
    } else {
      image(enemyAttackLeft[enemyAttackFrame], x, y);
    }

    if (enemyAttackFrame == 4) {
      enemyAttackFrame = 0;
    } else if (frameCount%10 == 0) {
      enemyAttackFrame++;
    }
  }

  void death() {
    image(enemyDie[enemyDieFrame], x, y);
    if (enemyDieFrame == 3) {
      return;
    } else if (frameCount%10 == 0) {
      enemyDieFrame++;
    }
  }

  void setLeft(float left) {
    x = left + w/2;
  }
  float getLeft() {
    return x - w/2;
  }
  void setRight(float right) {
    x = right - w/2;
  }
  float getRight() {
    return x + w/2;
  }
  void setTop(float top) {
    y = top + h/2;
  }
  float getTop() {
    return y - h/2;
  }
  void setBottom(float bottom) {
    y = bottom - h/2;
  }
  float getBottom() {
    return y + h/2;
  }
}

String detectCollision(Sandy s, Enemy e) {

  if (s.getRight() < e.getLeft() || s.getLeft() > e.getRight()) {
    return "NoCollision";
  }


  float leftOverlap = s.getRight() - e.getLeft();
  float rightOverlap = e.getRight() - s.getLeft();

  if (leftOverlap > 0 && leftOverlap < rightOverlap) {
    return "LeftCollision";
  } else if (rightOverlap > 0) {
    return "RightCollision";
  } else {
    return "NoCollision";
  }
}

boolean detectCollisionForAttack(float ecx, float ecy, float erx, float ery,
  float rcx, float rcy, float rw, float rh) {

  float rw2 = rw / 2f;
  float rh2 = rh / 2f;

  float testX = ecx;
  float testY = ecy;

  if (ecx < rcx - rw2) testX = rcx - rw2;
  else if (ecx > rcx + rw2) testX = rcx + rw2;

  if (ecy < rcy - rh2) testY = rcy - rh2;
  else if (ecy > rcy + rh2) testY = rcy + rh2;

  float distX = ecx - testX;
  float distY = ecy - testY;


  float distance = (distX * distX) / (erx * erx) + (distY * distY) / (ery * ery);

  return distance < 0.3f;
}
