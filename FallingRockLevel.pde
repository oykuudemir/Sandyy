PImage fallingRockGroundImage;
PImage fallingRockBackGroundImage;
Platform fallingRockGround;
Platform rightBlock;
Platform leftBlock;
PImage[] fireRock = new PImage[8];
ArrayList<FireRock> fireRocks =new ArrayList<FireRock>();
int fireRockFrame = 0;

class FallingRockLevel {
  float backgroundX = 400;
  int time = 0;
  Platform fallingRockGround;
  FallingRockLevel() {
    fallingRockGround = new Platform(400, 580, 800, 40, "/data/platformer/ground.png");
    fallingRockBackGroundImage = loadImage("/data/falling_rock/background.jpg");
    rightBlock = new Platform(-20, 580, 40, 80, "/data/platformer/block_2_v.png");
    leftBlock = new Platform(820, 580, 40, 80, "/data/platformer/block_2_v.png");
    sandy.refresh();
  }

  void initalize() {
    display();
    platforms.clear();
    platforms.add(fallingRockGround);
    platforms.add(rightBlock);
    platforms.add(leftBlock);
    if (frameCount%60 == 0) {
      time++;
    }
  }

  void display() {
    backgroundDisplay();

    timeDisplay();
    fireRock();


    if (time == 20 && sandy.hp > 0) {
      nextLevel = true;
    }
  }



  void timeDisplay() {
    textSize(64);
    fill(255);
    text(20-time, 720, 60);
  }

  void backgroundDisplay() {
    image(fallingRockBackGroundImage, backgroundX, 300);
  }

  void fireRock() {
    if (frameCount%20 == 0) {
      fireRocks.add(new FireRock(random(0, 800), random(-300, -100)));
    }
    for (int i = 0; i < fireRocks.size(); i++) {
      FireRock fireRock = fireRocks.get(i);
      fireRock.display();
    }
  }
}



class FireRock {
  float fireRockX;
  float fireRockY;
  float dy = 3;
  FireRock(float x, float y) {
    fireRockX = x;
    fireRockY = y;
    for (int i=1; i<=8; i++) {
      fireRock[i-1] = loadImage("/data/falling_rock/fire_rock/fire_rock_"+i+".png");
    }
  }

  FireRock(float x, float y, float dy) {
    fireRockX = x;
    fireRockY = y;
    for (int i=1; i<=8; i++) {
      fireRock[i-1] = loadImage("/data/falling_rock/fire_rock/fire_rock_"+i+".png");
    }
    this.dy = dy;
  }

  void display() {
    image(fireRock[fireRockFrame], fireRockX, fireRockY);
    fireRockY += dy;
    if (fireRockFrame == 7) {
      fireRockFrame = 0;
    } else if (frameCount%10 == 0) {
      fireRockFrame++;
    }

    if (sandy.direction == "right") {
      if (rectsCollide(sandy.x + 30, sandy.y + 20, 40, 80, fireRockX + 35, fireRockY + 45, 50, 50)) {
        fireRocks.remove(this);
        if (sandy.hp > 0) sandy.hp--;
        sandy.hurt();
      }
    } else {
      if (rectsCollide(sandy.x + 50, sandy.y + 20, 40, 80, fireRockX + 35, fireRockY + 45, 50, 50)) {
        fireRocks.remove(this);
        sandy.hp--;
        sandy.hurt();
      }
    }

    if (fireRockY > 800) {
      fireRocks.remove(this);
    }
  }
}

boolean rectsCollide(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  // Dikdörtgenlerin kenar koordinatlarını hesaplayın
  float rect1Right = x1 + w1;
  float rect1Bottom = y1 + h1;
  float rect2Right = x2 + w2;
  float rect2Bottom = y2 + h2;

  // Çarpışma kontrolü
  if (rect1Right <= x2) {
    return false; // Dikdörtgen 1, dikdörtgen 2'nin solunda
  }
  if (x1 >= rect2Right) {
    return false; // Dikdörtgen 1, dikdörtgen 2'nin sağında
  }
  if (rect1Bottom <= y2) {
    return false; // Dikdörtgen 1, dikdörtgen 2'nin üstünde
  }
  if (y1 >= rect2Bottom) {
    return false; // Dikdörtgen 1, dikdörtgen 2'nin altında
  }

  return true; // Hiçbir koşul sağlanmadıysa, dikdörtgenler çarpışır
}
