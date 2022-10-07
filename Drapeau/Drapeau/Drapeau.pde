/**
 * Main script of the program 
 */
 
// button text
String txbaseball = "- Baseball"; 
String txtennis = "- Tennis";
String txbasketball = "- Basketball";

// selected ball
int marqueur = 71;
 
  
// width of the windows -> 1000cm -> 10m
int dimX = 1000;
// height of the windows  -> 800cm -> 8m
int dimY = 800;
 
 
// the ball of the project
Ball ball;
// differents size for balls in cm (order : baseball, tennis, baskeball)
float[] size = {7.4, 7, 24.19};
// size of the selected ball
float taille = size[1];

// differents mass for balls in g (same order that above)
float[] tabmasse = {1.455, 0.63, 6};
// mas of the selected ball
float masse = tabmasse[1];


// differents restitution coefficient for balls (same order that above)
float[] tabcr = {0.5, 0.74, 0.85};
// coef of the selected ball
float cr = tabcr[1];


// the limits where balls appears in the windows (0 is the top of the windows)
int[] spawn_limits = {0,80};

// tick/time elapse
float t = 0.0;

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
  
  // display of text buttons
  fill(255);
  textSize(25);
  text("Type de balle :", 825, 25); 
  textSize(20);
  text(txbaseball, 835, 50);
  text(txtennis, 835, 70);
  text(txbasketball, 835, 90);
  
  // characteristics of the ball
  textSize(25);
  text("Caractérisques de la balle :", 15, 25); 
  textSize(20);
  text("- Diamètre (en cm) : ", 15, 50);
  text("- Masse (en g) : ", 15, 70);
  text("- Coefficient de restitution : ", 15, 90);
  // caracteristics display
  String txdiametre = str(taille);
  text(txdiametre, 185, 50);
  String txmasse = str(masse*100);
  text(txmasse, 145, 70);
  String txcr = str(cr);
  text(txcr, 250, 90);
  
  // marker
  fill(255, 0, 0);
  text("> ", 820, marqueur);
  
  
  
  // change selected ball
  if (mouseX >= 835 && mouseX <= 935){
    // baseball
    if (mouseY >= 30 && mouseY <= 50){
      fill(255,0,0);
      text(txbaseball, 835, 50);
    }
    // tennis
    if (mouseY >= 50 && mouseY <= 70){
      fill(255,0,0);
      text(txtennis, 835, 70);
    }
    // basketball
    if (mouseY >= 70 && mouseY <= 90){
      fill(255,0,0);
      text(txbasketball, 835, 90);
    }
  }
  
  
  // update position of the ball and display it
  ball.update();
  ball.display();
  ball.checkBoundaryCollision();
  
  
  
  // update the tick count
  t += 0.01;
}



/**
 * Create a new ball and init its trajectory
 **/
void newBall() {
  
  // init the ball with size and random position, according to the selected limits
  ball = new Ball(random((0+taille/2),(dimX-taille/2)), random(spawn_limits[0]+taille/2, spawn_limits[1]-taille/2), taille, masse, cr);
  t = 0.0;
}



/**
 * Method executed when the user click on a mouse button
 **/
void mousePressed() {
  // if the left button of the mouse is pressed
  if ( mouseButton == LEFT ) {
    // change selected ball
    if (mouseX >= 835 && mouseX <= 935){
      // Baseball
      if (mouseY >= 30 && mouseY <= 50){
        marqueur = 52;
        ball.radius = size[0]/2;
        taille = size[0];
        masse = tabmasse[0];
        cr = tabcr[0];
      }
      // Tennis
      if (mouseY >= 50 && mouseY <= 70){
        marqueur = 72;
        ball.radius = size[1]/2;
        taille = size[1];
        masse = tabmasse[1];
        cr = tabcr[1];
      }
      // Basketball
      if (mouseY >= 70 && mouseY <= 90){
        marqueur = 92;
        ball.radius = size[2]/2;
        taille = size[2];
        masse = tabmasse[2];
        cr = tabcr[2];
      }
    }

  // if the right button of the mouse is pressed
  }else if ( mouseButton == RIGHT ) {
    this.newBall();
    this.ball.position = new PVector(mouseX, mouseY);
  }
}
