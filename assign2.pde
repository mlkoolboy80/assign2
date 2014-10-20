// global variables
float frogX, frogY, frogW, frogH, frogInitX, frogInitY;
float leftCar1X, leftCar1Y, leftCar1W, leftCar1H;//car1
float leftCar2X, leftCar2Y, leftCar2W, leftCar2H;//car2
float rightCar1X, rightCar1Y, rightCar1W, rightCar1H;//car3
float rightCar2X, rightCar2Y, rightCar2W, rightCar2H;//car4
float pondY;

float speed;

boolean alive=true;
int life;
final int GAME_START = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
final int GAME_RUN = 4;
final int FROG_DIE = 5;
int gameState;
int interval=0;//use millis() to record current time

// Sprites
PImage imgFrog, imgDeadFrog;
PImage imgLeftCar1, imgLeftCar2;
PImage imgRightCar1, imgRightCar2;
PImage imgWinFrog, imgLoseFrog;

void setup(){
  size(640,480);
  textFont(createFont("font/Square_One.ttf", 20));
  // initial state
  gameState = GAME_START;
  
  speed = 5;
  
  // the Y position of Pond
  pondY = 32;
  
  // initial position of frog
  frogInitX = 304;
  frogInitY = 448;
  
  frogW = 32;
  frogH = 32;
  
  leftCar1W=leftCar2W=rightCar1W=rightCar2W = 32;//all cars' width 
  leftCar1H=leftCar2H=rightCar1H=rightCar2H = 32;//all cars' height
  leftCar1X = leftCar2X = 0; //position X of car1,2
  rightCar1X = rightCar2X =640;//position X of car3,4
  
  leftCar1Y = 128;//position Y of car1
  rightCar1Y =192;//position Y of car2
  leftCar2Y  =256;//position Y of car3
  rightCar2Y =320;//position Y of car4
  
  imgFrog = loadImage("data/frog.png");
  imgDeadFrog = loadImage("data/deadFrog.png");
  imgLeftCar1 = loadImage("data/LCar1.png");//img of car1
  imgLeftCar2 = loadImage("data/LCar2.png");//img of car2
  imgRightCar1 = loadImage("data/RCar1.png");//img of car3
  imgRightCar2 = loadImage("data/RCar2.png");//img of car4
  imgWinFrog = loadImage("data/win.png");
  imgLoseFrog = loadImage("data/lose.png");
}

void draw(){
  switch (gameState){
    case GAME_START:
        background(10,110,16);
        text("Press Enter", width/3, height/2);    
        break;
    case FROG_DIE:
        if(millis()-interval>=500){
            gameState = GAME_RUN;
            life--;
            frogX=frogInitX;
            frogY=frogInitY;
            if(life <= 0){
              gameState = GAME_LOSE;
            }
        }
        break;
    case GAME_RUN:
        background(10,110,16);
        //gameState 
        
        
        fill(4,13,78);
        rect(0,32,640,32);

        // show frog live
        for(int i=0;i<life;i++){
            image(imgFrog,64+i*48 ,32);
         }

        // draw frog
        image(imgFrog, frogX, frogY);

         //car1 move
         leftCar1X += 1.5 * speed;
         if (leftCar1X > width){
             leftCar1X = 0;
         }
         image(imgLeftCar1, leftCar1X, leftCar1Y);

         //car2 move
         leftCar2X += 0.5 * speed;
         if (leftCar2X > width){
           leftCar2X = 0;
         }
         image(imgLeftCar2, leftCar2X, leftCar2Y);
         
         //car3 move
         rightCar1X -= speed;
         if (rightCar1X < 0){
           rightCar1X = width;
         }
         image(imgRightCar1, rightCar1X, rightCar1Y);

         //car4 move
         rightCar2X -= 0.5 * speed;
         if (rightCar2X < 0){
           rightCar2X = width;
         }
         image(imgRightCar2, rightCar2X, rightCar2Y);
  
         float frogCX = frogX+frogW/2;
         float frogCY = frogY+frogH/2;
         fill(10,110,16);
         stroke(10,110,16);
         // car1 hitTest
         if (ishit(leftCar1X, leftCar1Y, leftCar1W, leftCar1H, frogCX, frogCY)){
           interval = millis();
           gameState = FROG_DIE;
           rect(frogX,frogY,frogW,frogH); // remove body
           image(imgDeadFrog, frogX, frogY);
           image(imgLeftCar1, leftCar1X, leftCar1Y);
         }
         // car2 hitTest
         if (ishit(leftCar2X, leftCar2Y, leftCar2W, leftCar2H, frogCX, frogCY)){
           interval = millis();
           gameState = FROG_DIE;
           rect(frogX,frogY,frogW,frogH);
           image(imgDeadFrog, frogX, frogY);
           image(imgLeftCar2, leftCar2X, leftCar2Y);
         }
         // car3 hitTest
         if (ishit(rightCar1X, rightCar1Y, rightCar1W, rightCar1H, frogCX, frogCY)){
           interval = millis();
           gameState = FROG_DIE;
           rect(frogX,frogY,frogW,frogH);
           image(imgDeadFrog, frogX, frogY);
           image(imgRightCar1, rightCar1X, rightCar1Y);
         }
         // car4 hitTest
         if (ishit(rightCar2X, rightCar2Y, rightCar2W, rightCar2H, frogCX, frogCY)){
           interval = millis();
           gameState = FROG_DIE;
           rect(frogX,frogY,frogW,frogH);
           image(imgDeadFrog, frogX, frogY);
           image(imgRightCar2, rightCar2X, rightCar2Y);
         }
        break;
    case GAME_WIN:
        background(0);
        image(imgWinFrog,207,164);
        fill(255);
        text("You Win !!",240,height/4);
        break;
    case GAME_LOSE:
        background(0);
        image(imgLoseFrog,189,160);
        fill(255);
        text("You Lose",240,height/4); 
        break;
  }
}
void keyPressed() {
    if (key == CODED /*still needs something*/) {
      
      if(keyCode == UP){
        frogY = frogY - speed;
        // win !!
        if (frogY < pondY + frogH/2 && gameState == GAME_RUN){
          gameState = GAME_WIN;
        }
      } else if (keyCode == DOWN){
        frogY = frogY + speed;
        // avoid going down
        if (frogY > height - frogH){
          frogY = frogY - speed;
        }
      } else if (keyCode == LEFT){
        frogX = frogX - speed;
        // avoid going left
        if (frogX < 0){
          frogX = frogX + speed;
        }
      } else if (keyCode == RIGHT){
        frogX = frogX + speed;
        // avoid going right
        if (frogX > width - frogW){
          frogX = frogX - speed;
        }
      }
    }
    if(key==ENTER /*still needs something*/){
      if(gameState != GAME_RUN){
        gameState = GAME_RUN;
        life=3;
        frogX = frogInitX;
        frogY = frogInitY;
      }
    }
}

boolean ishit(float carX, float carY, float carW, float carH, float frogCX, float frogCY){
  if (frogCX > carX && frogCX < carW+carX && frogCY > carY && frogCY < carY+carH){
    return true;
  } else {
    return false;
  }
}
