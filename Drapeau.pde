/**
 * Main script of the program 
 */
 
// button text
String tx5 = "- 5x5"; 
String tx10 = "- 10x10";
String tx15 = "- 15x15";

// selected number of discretisation points
int marqueur = 71;
 
 
// width of the windows
int dimX = 1000;
// height of the windows 
int dimY = 800;
 
 
// the ball of the project
Ball ball;

// coordinates of the first ball
int Xinit = 200;
int Yinit = 200;

// size of the ball
float taille = 20;

// mass of the selected ball
float masse = 1;

// empty length spring
int l0 = 100;

// tick/time elapse
//float t = 0.0;

// gravity force in m/s
final PVector GRAVITY = new PVector(0,9.8);



void settings () {
  // set the size of the windows
   size(dimX, dimY);
}


void setup() {
  this.newBall();
}



/**
 * Method call at each frame of the windows
 **/
void draw() {
  background(51);
  
  // change in the number of discretisation points
  fill(255);
  textSize(25);
  text("Nombre de points de la discrétisation :", 15, 25); 
  textSize(20);
  text(tx5, 15, 50);
  text(tx10, 15, 70);
  text(tx15, 15, 90);
  
  // marker
  fill(255, 0, 0);
  text(" < ", 80, marqueur);
  
  // change the colour of the next selected value
  if (mouseX >= 18 && mouseX <= 70){
    // 5x5
    if (mouseY >= 30 && mouseY <= 50){
      fill(255,0,0);
      text(tx5, 15, 50);
    }
    // 10x10
    if (mouseY >= 50 && mouseY <= 70){
      fill(255,0,0);
      text(tx10, 15, 70);
    }
    // 15x15
    if (mouseY >= 70 && mouseY <= 90){
      fill(255,0,0);
      text(tx15, 15, 90);
    }
  }
  
  // update position of the ball and display it
  ball.update();
  ball.display();
  //ball.checkBoundaryCollision();
}



/**
 * Create a new ball and init its trajectory
 **/
void newBall() {
  
    // init the ball with size and random position, according to the selected limits
  ball = new Ball(Xinit, Yinit+l0-50, taille, masse, l0);
  //t = 0.0;
  
}



/**
 * Method executed when the user click on a mouse button
 **/
void mousePressed() {
  // if the left button of the mouse is pressed
  if ( mouseButton == LEFT ) {
    // change the number of discretisation points
    if (mouseX >= 18 && mouseX <= 70){
      // 5x5
      if (mouseY >= 30 && mouseY <= 50){
        marqueur = 52;
      }
      // 10x10
      if (mouseY >= 50 && mouseY <= 70){
        marqueur = 72;
      }
      // 15x15
      if (mouseY >= 70 && mouseY <= 90){
        marqueur = 92;
      }
    }
  }
}
