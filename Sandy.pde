PImage[] idleRight = new PImage[6];
PImage[] idleLeft = new PImage[6];
PImage[] runRight = new PImage[8];
PImage[] runLeft = new PImage[8];
PImage[] attackRight = new PImage[10];
PImage[] attackLeft = new PImage[10];
PImage[] jumpRight = new PImage[3];
PImage[] jumpLeft = new PImage[3];
PImage[] fallRight = new PImage[3];
PImage[] fallLeft = new PImage[3];
PImage[] crouchRight = new PImage[4];
PImage[] crouchLeft = new PImage[4];
PImage[] slideRight = new PImage[5];
PImage[] slideLeft = new PImage[5];
PImage[] hurtRight = new PImage[4];
PImage[] hurtLeft = new PImage[4];
PImage[] deathRight = new PImage[11];
PImage[] deathLeft = new PImage[11];
PImage heart;

int idleFrame = 0;
int attackFrame = 0;
int runFrame = 0;
int jumpFrame = 0;
int fallFrame = 0;
int crouchFrame = 0;
int slideFrame = 0;
int hurtFrame = 0;
int deathFrame = 0;


class Sandy {
  float x = 80;
  float y = 410;
  float dx = 0;
  float dy = 0;
  float w = 40;
  float h = 70;
  int hp = 5;
  String direction = "right";
  boolean isJumping = false;
  boolean isFalling = false;
  boolean isHurt = false;
  boolean isDead = false;



  Sandy() {
    for (int i=1; i<=6; i++) {
      idleRight[i-1] = loadImage("/data/warrior/idle_right/Warrior_Idle_"+i+".png");
    }

    for (int i=1; i<=6; i++) {
      idleLeft[i-1] = loadImage("/data/warrior/idle_left/Warrior_Idle_"+i+".png");
    }

    for (int i=1; i<=8; i++) {
      runRight[i-1] = loadImage("/data/warrior/run_right/Warrior_Run_"+i+".png");
    }

    for (int i=1; i<=8; i++) {
      runLeft[i-1] = loadImage("/data/warrior/run_left/Warrior_Run_"+i+".png");
    }

    for (int i=1; i<=10; i++) {
      attackRight[i-1] = loadImage("/data/warrior/attack_right/Warrior_Dash-Attack_"+i+".png");
    }

    for (int i=1; i<=10; i++) {
      attackLeft[i-1] = loadImage("/data/warrior/attack_left/Warrior_Dash-Attack_"+i+".png");
    }

    for (int i=1; i<=3; i++) {
      jumpRight[i-1] = loadImage("/data/warrior/jump_right/Warrior_Jump_"+i+".png");
    }

    for (int i=1; i<=3; i++) {
      jumpLeft[i-1] = loadImage("/data/warrior/jump_left/Warrior_Jump_"+i+".png");
    }

    for (int i=1; i<=3; i++) {
      fallRight[i-1] = loadImage("/data/warrior/fall_right/Warrior_Fall_"+i+".png");
    }

    for (int i=1; i<=3; i++) {
      fallLeft[i-1] = loadImage("/data/warrior/fall_left/Warrior_Fall_"+i+".png");
    }

    for (int i=1; i<=4; i++) {
      crouchRight[i-1] = loadImage("/data/warrior/crouch_right/Warrior_Crouch_"+i+".png");
    }

    for (int i=1; i<=4; i++) {
      crouchLeft[i-1] = loadImage("/data/warrior/crouch_left/Warrior_Crouch_"+i+".png");
    }

    for (int i=1; i<=5; i++) {
      slideRight[i-1] = loadImage("/data/warrior/slide_right/Warrior-Slide_"+i+".png");
    }

    for (int i=1; i<=5; i++) {
      slideLeft[i-1] = loadImage("/data/warrior/slide_left/Warrior-Slide_"+i+".png");
    }

    for (int i=1; i<=4; i++) {
      hurtRight[i-1] = loadImage("/data/warrior/hurt_right/Warrior_hurt_"+i+".png");
    }

    for (int i=1; i<=4; i++) {
      hurtLeft[i-1] = loadImage("/data/warrior/hurt_left/Warrior_hurt_"+i+".png");
    }

    for (int i=1; i<=11; i++) {
      deathRight[i-1] = loadImage("/data/warrior/death_right/Warrior_Death_"+i+".png");
    }

    for (int i=1; i<=11; i++) {
      deathLeft[i-1] = loadImage("/data/warrior/death_left/Warrior_Death_"+i+".png");
    }

    heart = loadImage("/data/warrior/heart.png");
  }

  void initalize() {
    display();
    update();
  }

  void display() {
    if (isDead) {
      death();
      if (frameCount%300 == 0) level = 7;
      return;
    }

    if (hp == 0) {
      isDead = true;
    }
    hpDisplay();
    animationControl();
  }


  void animationControl() {
    if (isHurt) {
      hurt();
    } else if (attack) {
      attack();
    } else if (down && !isJumping ) {
      crouch();
    } else if (up && !isJumping) {
      jump();
    } else if (right && !isJumping) {
      rightRun();
    } else if (left && !isJumping) {
      leftRun();
    } else if (isFalling) {
      fall();
    } else {
      idle();
    }
  }

  void update() {
    if (!right && !left) dx = 0;
  }

  void refresh() {
    sandy.hp = 5;
    sandy.x = 80;
    sandy.y = 410;
  }

  void hpDisplay() {
    for (int i = 0; i < hp; i++) {
      image(heart, 20 + i*35 +view_x, 20);
    }
  }

  void idle() {
    if (direction == "right") {
      image(idleRight[idleFrame], x, y);
    } else {
      image(idleLeft[idleFrame], x, y);
    }

    if (idleFrame == 5) {
      idleFrame = 0;
    } else if (frameCount%10 == 0) {
      idleFrame++;
    }
  }

  void attack() {
    fill(255, 0, 0, 100);
   

    if (direction == "right") {
      //ellipse(sandy.x + 20, sandy.y, 85, 70);
      image(attackRight[attackFrame], x, y);
    } else {
      //ellipse(sandy.x - 20, sandy.y, 85, 70);
      image(attackLeft[attackFrame], x, y);
    }

    if (attackFrame == 9) {
      attackFrame = 0;
      attack = false;
    } else if (frameCount%5 == 0) {
      attackFrame++;
    }
  }

  void rightRun() {
    dx = 3;
    direction = "right";
    image(runRight[runFrame], x, y);
    if (runFrame == 7) {
      runFrame = 0;
    } else if (frameCount%5 == 0) {
      runFrame++;
    }
  }

  void leftRun() {
    dx = -3;
    direction = "left";
    image(runLeft[runFrame], x, y);
    if (runFrame == 7) {
      runFrame = 0;
    } else if (frameCount%5 == 0) {
      runFrame++;
    }
  }

  void jump() {
    if (direction == "right") {
      image(jumpRight[jumpFrame], x, y);
    } else {
      image(jumpLeft[jumpFrame], x, y);
    }

    if (jumpFrame == 2) {
      jumpFrame = 0;
    } else if (frameCount%20 == 0) {
      jumpFrame++;
    }
  }

  void fall() {
    if (direction == "right") {
      image(fallRight[fallFrame], x, y);
    } else {
      image(fallLeft[fallFrame], x, y);
    }

    if (fallFrame == 2) {
      fallFrame = 0;
    } else if (frameCount%20 == 0) {
      fallFrame++;
    }
  }

  void crouch() {
    if (right) {
      direction = "right";
      x++;
      slide();
    } else if (left) {
      direction = "left";
      x--;
      slide();
    } else {
      crouchIdle();
    }
  }

  void crouchIdle() {
    if (direction == "right") {
      image(crouchRight[crouchFrame], x, y);
    } else {
      image(crouchLeft[crouchFrame], x, y);
    }

    if (crouchFrame == 3) {
      crouchFrame = 0;
    } else if (frameCount%10 == 0) {
      crouchFrame++;
    }
  }

  void slide() {
    if (direction == "right") {
      image(slideRight[slideFrame], x, y);
    } else {
      image(slideLeft[slideFrame], x, y);
    }

    if (slideFrame == 4) {
      slideFrame = 0;
    } else if (frameCount%10 == 0) {
      slideFrame++;
    }
  }

  void hurt() {
    isHurt = true;
    if (direction == "right") {
      image(hurtRight[hurtFrame], x, y);
    } else {
      image(hurtLeft[hurtFrame], x, y);
    }

    if (hurtFrame == 3) {
      hurtFrame = 0;
      isHurt = false;
    } else if (frameCount%10 == 0) {
      hurtFrame++;
    }
  }

  void death() {
    if (direction == "right") {
      image(deathRight[deathFrame], x, y);
    } else {
      image(deathLeft[deathFrame], x, y);
    }

    if (deathFrame == 10) {
      return;
    } else if (frameCount%10 == 0) {
      deathFrame++;
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
