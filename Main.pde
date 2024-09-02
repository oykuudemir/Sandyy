Sandy sandy;

FallingRockLevel fallingRockLevel;
PlatformerLevel platformerLevel;
EscapeLevel escapeLevel;
EnemyPlatformLevel enemyPlatformLevel;
BossLevel bossLevel;
Start start;
YouWin youWin;
GameOver gameOver;

ArrayList<Platform> platforms;
boolean right, left, up, down, attack = false;

float GRAVITY = .6;
float JUMP_SPEED = 10;

float RIGHT_MARGIN = 400;
float LEFT_MARGIN = 60;
float VERTICAL_MARGIN = 40;

float view_x;
float view_y;

int level = 0;

boolean tryAgain = false;
boolean nextLevel = false;
void setup() {
  size(800, 600);
  view_x = 0;
  view_y = 0;
  sandy = new Sandy();
  fallingRockLevel = new FallingRockLevel();
  platformerLevel = new PlatformerLevel();
  escapeLevel = new EscapeLevel();
  bossLevel = new BossLevel();
  enemyPlatformLevel = new EnemyPlatformLevel();
  start = new Start();
  youWin = new YouWin();
  gameOver = new GameOver();
  platforms = new ArrayList<Platform>();
  rectMode(CENTER);
  imageMode(CENTER);
}

void draw() {
  background(0);
  if (level == 0) {
    start.initalize();
  } else if (level == 1) {
    resolvePlatformCollisions(sandy, platforms);
    fallingRockLevel.initalize();
    sandy.initalize();
    for (Platform p : platforms) {
      p.display();
    }
  } else if (level == 2) {
    scroll();
    resolvePlatformCollisions(sandy, platforms);
    platformerLevel.initalize();
    sandy.initalize();
    for (Platform p : platforms) {
      p.display();
    }
  } else if (level == 3) {
    scroll();
    resolvePlatformCollisions(sandy, platforms);
    escapeLevel.initalize();
    sandy.initalize();
    for (Platform p : platforms) {
      p.display();
    }
  } else if (level == 4) {
    scroll();
    resolvePlatformCollisions(sandy, platforms);
    enemyPlatformLevel.initalize();
    sandy.initalize();
    for (Platform p : platforms) {
      p.display();
    }
  } else if (level == 5) {
    resolvePlatformCollisions(sandy, platforms);
    bossLevel.initalize();
    sandy.initalize();
    for (Platform p : platforms) {
      p.display();
    }
  } else if (level == 6) {
    youWin.initalize();
  } else if (level == 7) {
    gameOver.initalize();
  }


  if (tryAgain) {
    level = 1;
    sandy.x = 80;
    sandy.y = 410;
    sandy.hp = 5;
    bossLevel.boss.hp = 80;
    fireRocks.clear();
    fallingRockLevel.time = 0;
    view_x = 0;
    view_y = 0;
    keys.clear();
    keys.add(new Key(610, 370));
    keys.add(new Key(1230, 370));
    keys.add(new Key(1530, 390));
    sandy.isDead = false;
    tryAgain = false;
  }

  if (nextLevel) {
    level++;
    sandy.x = 80;
    sandy.y = 410;
    sandy.hp = 5;
    view_x = 0;
    view_y = 0;
    fireRocks.clear();
    nextLevel = false;
  }
}


void keyPressed() {
  if (keyCode == RIGHT) {
    right = true;
  } else if (keyCode == LEFT) {
    left = true;
  } else if (keyCode == UP && isOnPlatforms(sandy, platforms)) {
    sandy.dy = -JUMP_SPEED;
    up = true;
  } else if (keyCode == DOWN) {
    down = true;
  } else if (keyCode == ENTER) {
    attack = true;
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    right = false;
  } else if (keyCode == LEFT) {
    left = false;
  } else if (keyCode == UP) {
    up = false;
  } else if (keyCode == DOWN) {
    down = false;
  }
}

void mouseClicked() {
  println(mouseX, mouseY);
}

boolean isOnPlatforms(Sandy s, ArrayList<Platform> walls) {
  s.y += 5;
  ArrayList<Platform> collision_list = checkCollisionList(s, walls);
  s.y -= 5;
  return collision_list.size() > 0;
}

void scroll() {
  float right_boundary = view_x + width - RIGHT_MARGIN;
  if (sandy.getRight() > right_boundary) {
    view_x += sandy.getRight() - right_boundary;
  }

  float left_boundary = view_x + LEFT_MARGIN;
  if (sandy.getLeft() < left_boundary) {
    view_x -= left_boundary - sandy.getLeft();
  }

  translate(-view_x, -view_y);
}

void resolvePlatformCollisions(Sandy s, ArrayList<Platform> walls) {
  s.dy += GRAVITY;
  s.y += s.dy;

  ArrayList<Platform> col_list = checkCollisionList(s, walls);
  if (col_list.size() > 0) {
    Platform collided = col_list.get(0);
    if (s.dy > 0) {
      s.setBottom(collided.getTop());
    } else if (s.dy < 0) {
      s.setTop(collided.getBottom());
    }
    s.dy = 0;
  }
  s.x += s.dx;
  col_list = checkCollisionList(s, walls);

  if (col_list.size() > 0) {
    Platform collided = col_list.get(0);

    if (s.dx > 0) {
      s.setRight(collided.getLeft());
    } else if (s.dx < 0) {
      s.setLeft(collided.getRight());
    }
  }
}

ArrayList<Platform> checkCollisionList(Sandy s, ArrayList<Platform> list) {
  ArrayList<Platform> collision_list = new ArrayList<Platform>();
  for (Platform p : list) {
    if (checkCollisionPlatform(s, p))
      collision_list.add(p);
  }
  return collision_list;
}

boolean checkCollisionPlatform(Sandy s1, Platform s2) {
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();

  if (noXOverlap || noYOverlap) {
    return false;
  } else {
    return true;
  }
}
