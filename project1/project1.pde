Player player, player2, player3;
ArrayList<Platform> platforms, platforms3;
ArrayList<Food> foods, foods2, foods3;
Antlion antlion;
ArrayList<Enemy> enemies1;
ArrayList<Enemy> enemies2;
ArrayList<Seawead> seaweads;

// Score
int foodNum = 0;

// Level
int L_ONE = 1;
int L_TWO = 2;
int L_THREE = 3;
int level = L_ONE;

boolean left, right, up;



void setup() {
  size(1080, 700);
  
  // initialize player
  player = new Player(50, 600, 50, 50, 0, 0);
  player2 = new Player(50, 350, 50, 50, 0, 0);
  player3 = new Player(50, 600, 50, 50, 0, 0);
  
  // initialize platforms
  platforms = new ArrayList<Platform>();
    //platforms.add(new Platform(300, 1000, 200, 25));
    //platforms.add(new Platform(500, 900, 200, 25));
    //platforms.add(new Platform(800, 800, 200, 25));
    //platforms.add(new Platform(500, 700, 200, 25));
    platforms.add(new Platform(300, 600, 200, 25));
    platforms.add(new Platform(500, 500, 200, 25));
    platforms.add(new Platform(800, 400, 200, 25));
    platforms.add(new Platform(500, 300, 200, 25));
    platforms.add(new Platform(700, 200, 200, 25));
    platforms.add(new Platform(300, 100, 200, 25));
    
    
  platforms3 = new ArrayList<Platform>();
    platforms3.add(new Platform(500, 550, 200, 25));
    platforms3.add(new Platform(250, 400, 200, 25));
    platforms3.add(new Platform(750, 400, 200, 25));
    platforms3.add(new Platform(500, 250, 200, 25));
  
  //initialize food
  foods = new ArrayList<Food>();
    //foods.add(new Food(550, 900, 25, 25));
    //foods.add(new Food(350, 1000, 25, 25));
    foods.add(new Food(350, 600, 25, 25));
    foods.add(new Food(550, 500, 25, 25));
    foods.add(new Food(850, 400, 25, 25));
    foods.add(new Food(550, 300, 25, 25));

  foods2 = new ArrayList<Food>();
    for (int i = 0; i < 8; i++) {
      float rx = random(1080);
      float ry = random(700);
      foods2.add(new Food(rx, ry, 25, 25));
    }
  
  // initiallize antlion
  //antlion = new Antlion();
  
  
  // initialize enemy
  enemies1 = new ArrayList<Enemy>();
  enemies1.add(new Enemy(100, 550, 50, 50, 2.5, 0));
  enemies1.add(new Enemy(800, 350, 50, 50, -3, 0));
  enemies1.add(new Enemy(100, 150, 50, 50, 5, 0));
  
  enemies2 = new ArrayList<Enemy>();
  enemies2.add(new Enemy(100, 100, 50, 50, 0, 0));
  enemies2.add(new Enemy(800, 600, 50, 50, 0, 0));
  
  
  // initialize seawead
  seaweads = new ArrayList<Seawead>();
  for (int i = 0; i < 3; i++) {
      float rx = random(1080);
      float ry = random(700);
      seaweads.add(new Seawead(rx, ry, 75, 75));
  }
  
  // initialize boolean variables
  left = false;
  right = false;
  up = false;
}


void draw() {
  levelCheck();
  
  // ---------------- LEVEL 1 --------------------
  if (level == L_ONE) {
    background(255);
    setText();
    player.update();
    
    // Check the collision of player and platform & DIsplay the platform
    for (int i = 0; i < platforms.size(); i++) {
      Platform p = platforms.get(i);
      p.display();
      
      rectangleCollisions(player, p);
      player.checkPlatforms();    
    }
    
    // Display the foods
    for (int i=0; i<foods.size(); i++) {
      Food f = foods.get(i);
      f.display();
      
      boolean foodCollision = collectCollision(player, f);
      if (foodCollision) {
        foodNum++;
        foods.remove(i);
      }
    }
    
    // Display the enemies
    for(int i=0; i<enemies1.size(); i++) {
      Enemy e = enemies1.get(i);
      e.display();
      e.update1();
      
      boolean enemyCollision = enemyCollision(player, e);
      if (enemyCollision) {
        println("You're hitted");
      }
      
    }
    
    // Check the boundaries
    player.checkBoundaries();
    
    // Display
    player.display();
    
    //antlion.update(player);
    
  }
  
  // --------------- LEVEL 2 -------------------
  
  if (level == L_TWO) {
    background(135, 206, 235);
    setText();
    player2.update2();
    
    for (int i=0; i<foods2.size(); i++) {
      Food f = foods2.get(i);
      f.display();
      
      boolean foodCollision = collectCollision(player2, f);
      if (foodCollision) {
        foodNum++;
        foods2.remove(i);
      }
    }
    
    // Display the enemies
    for(int i=0; i<enemies2.size(); i++) {
      Enemy e = enemies2.get(i);
      e.display();
      e.update2(player2);
      
      boolean enemyCollision = enemyCollision(player2, e);
      if (enemyCollision) {
        println("You're hitted22222");
      }
    }
    
    
    // Display the seaweads
    for(int i=0; i<seaweads.size(); i++) {
      Seawead s = seaweads.get(i);
      s.display();
      
      boolean seaweadCollision = seaweadCollision(player2, s);
      if (seaweadCollision) {
        float speedLimit = 0.8;
        player2.vx *= speedLimit;
        player2.vy *= speedLimit;
        println("You are caught by seaweed!!");
      }
    }
    
  }
  
  
  // --------------- LEVEL 3 -------------------
  if (level == L_THREE) {
    background(255, 204, 203);
    setText();
    player3.update();
    player3.display();
    
    // Check the collision of player and platform & DIsplay the platform
    for (int i = 0; i < platforms3.size(); i++) {
      Platform p = platforms3.get(i);
      p.display();
      
      rectangleCollisions(player3, p);
      player3.checkPlatforms();    
    }
    
    
    // Check the boundaries
    player3.checkBoundaries();
    
  }
  
}


void keyPressed(){
  switch (keyCode){
    case 37:
      left = true;
      break;
    case 39:
      right = true;
      break;
    case 38:
      up = true;
      break;
  }
}


void keyReleased(){
    switch (keyCode){
    case 37:
      left = false;
      break;
    case 39:
      right = false;
      break;
    case 38:
      up = false;
      break;
  }
}

void rectangleCollisions(Player p1, Platform p2){
  float dx = (p1.x+p1.w/2) - (p2.x+p2.w/2);
  float dy = (p1.y+p1.h/2) - (p2.y+p2.h/2);

  float combinedHalfWidths = p1.halfWidth + p2.halfWidth;
  float combinedHalfHeights = p1.halfHeight + p2.halfHeight;

  if (abs(dx) < combinedHalfWidths){
    if (abs(dy) < combinedHalfHeights){
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY){
        if (dy > 0){
          p1.collisionSide = "top";
          p1.y += overlapY;
        }else{
          p1.collisionSide = "bottom";
          p1.y -= overlapY;
        }
      }else{
        if (dx > 0){
          p1.collisionSide = "left";
          p1.x += overlapX;
        }else{
          p1.collisionSide = "right";
          p1.x -= overlapX;
        }
      }
    } else {
      p1.collisionSide = "none";
    }
  }else {
    p1.collisionSide = "none";
  }
}


Boolean collectCollision(Player cp, Food cf) {
  float player_x_left = (cf.x-cf.w/2)-(cp.x+cp.w);
  float player_x_right = (cp.x)-(cf.x+cf.w/2);
  float player_y_top = (cf.y-cf.h/2)-(cp.y+cp.h);
  float player_y_bottom = (cp.y) - (cf.y+cf.h/2);
  
  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top <=0 && player_y_bottom <=0) {
    return true;
  }
  return false;
}

Boolean enemyCollision(Player ep, Enemy ee) {
  float player_x_left = (ee.pos.x-ee.w/2)-(ep.x+ep.w);
  float player_x_right = (ep.x)-(ee.pos.x+ee.w/2);
  float player_y_top = (ee.pos.y-ee.h/2)-(ep.y+ep.h);
  float player_y_bottom = (ep.y) - (ee.pos.y+ee.h/2);
  
  if (player_x_left <= 0 && player_x_right <= 0 && player_y_top <=0 && player_y_bottom <=0) {
    return true;
  }
  return false;
}

Boolean seaweadCollision(Player sp, Seawead ss) {
  float disx = abs((sp.x+sp.w/2)-(ss.x));
  float disy = abs((sp.y+sp.h/2)-(ss.y));
  float sumx = sp.w/2 + ss.w/2;
  float sumy = sp.h/2 + ss.h/2;
  
  if (disx<=sumx && disy<=sumy) {
    return true;
  }
  return false;
}


void setText() {
  String s = "FOOD:  " + foodNum;
  String s2 = "LEVEL:  " + level;
  if (level == L_TWO){
    String s3 = "Keep jumping and don't fall";
    textSize(18);
    fill(255);
    text(s3, 400, 30);
  }
  textSize(24);
  fill(0);
  text(s, 900, 30);
  text(s2, 30, 30);
}

void levelCheck() {
  if (foodNum >= 3 && player.y < 0 && level == L_ONE) {
    foodNum = 0;
    level = L_TWO;
  }
  
  if (foodNum >= 5 && player2.x+player2.w > width && level == L_TWO) {
    foodNum = 0;
    level = L_THREE;
  }
}
