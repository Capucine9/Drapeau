/**
 * Main script of the program 
 */
 
// button text
String tx5 = "- 5x5"; 
String tx10 = "- 10x10";
String tx15 = "- 15x15";

int dimGridX = 10;
int dimGridY = 10;

// selected number of discretisation points
int marqueur = 71;
 
 
// width of the windows
int dimX = 1000;
// height of the windows 
int dimY = 800;

// number of mass
int nbMass = 2;
 
// the mass of the project
Mass[][] mass;

// coordinates of the first mass
int Xinit = 200;
int Yinit = 200;

// size of the mass
float taille = 20;

// mass of the selected mass
float masse = 1;

// empty length spring
int l0 = 50;

// tick/time elapse
//float t = 0.0;

// gravity force in m/s
final PVector GRAVITY = new PVector(0,9.8);



void settings () {
  // set the size of the windows
   size(dimX, dimY);
}


void setup() {
  //this.newMass();
  this.initGrid();
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
  
  // update position of the mass and display it
  //mass.update();
  //mass.display();
  //mass.checkBoundaryCollision();
  
  for ( int y = dimGridY-1; y >= 0; y--) {
    for ( int x = dimGridX-1; x >= 0; x-- ) {
      mass[x][y].update();
      mass[x][y].display();
    }
  }
    
  //////////////////////////////////
  //for ( int j = 0; j < dimGridX ; j++ ) {
  //  for (Mass m : mass[j]) {
  //    m.update();
  //    m.display();
      
  //    // line representing a mass-spring system
  //    stroke(255);
  //    line(Xinit, Yinit, mass[0][0].position.x, mass[0][0].position.y);
  //    for (int i=0; i < nbMass-1; i++){
  //      //line(mass[0][i].position.x, mass[0][i].position.y, mass[0][i+1].position.x, mass[0][i+1].position.y);
  //    }
  //  }
  //}
}



///**
// * Create a new mass and init its trajectory
// **/
//void newMass() {
  
//  // init the mass with size and random position, according to the selected limits
//  //mass = new Mass(Xinit -10, Yinit+l0, taille, masse, l0);
//  //t = 0.0;
  
//  ////////////////////////////////////
//  for (int i=0; i < nbMass; i++){
//    //mass[i] = new Mass(Xinit, Yinit + (l0 * (i+1)), taille, masse, l0);
//  }
  
//}


void initGrid () {
  mass = new Mass[dimGridX][dimGridY];
  for ( int i = 0; i < dimGridX; i++) {
    for ( int j = 0; j < dimGridY; j++ ) {
      int x = Xinit + (l0 * j);
      int y = Yinit + (l0 * i);
      mass[i][j] = new Mass(i, j, x, y, taille, masse, l0, true);
    }
  }
  mass[0][0].canMove = false;
  mass[dimGridX-1][0].canMove = false;
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
        this.dimGridX = 5;
        this.dimGridY = 5;
        this.initGrid();
      }
      // 10x10
      if (mouseY >= 50 && mouseY <= 70){
        marqueur = 72;
        this.dimGridX = 10;
        this.dimGridY = 10;
        this.initGrid();
      }
      // 15x15
      if (mouseY >= 70 && mouseY <= 90){
        marqueur = 92;
        this.dimGridX = 15;
        this.dimGridY = 15;
        this.initGrid();
      }
    }
  }
}
