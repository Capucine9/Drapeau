/**
 * Main script of the program 
 */
import peasy.*;

// texture
PImage img;

PeasyCam cam;
 
// button text
String tx5 = "- 5x5"; 
String tx8 = "- 8x12";
String tx12 = "- 12x18";
String txAvec = "Avec";
String txSans = "Sans";

int dimGridX = 8;
int dimGridY = 12;

// selected number of discretisation points
int marqueur_nb_points = 71;
// selected diagonal spring
int marqueur_diag = 850;
// selected texture
int marqueur_texture = 850;

// with diagonal spring
boolean diagonal_spring = false;
// with texture
boolean texture = false;
 
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

// mass of the selected mass
float masse = 1;

// empty length spring
int l0 = 50;

// tick/time elapse
//float t = 0.0;

// gravity force in m/s
final PVector GRAVITY = new PVector(0,9.8,0);

// wind velocity
PVector wind_velocity = new PVector(100, 1, 10);

boolean decrease_wind = true;



void settings () {
  // set the size of the windows
   size(dimX, dimY, P3D);
}


void setup() {
  //this.newMass();
  this.initGrid();
  img = loadImage("drapeau.png");
  
  cam = new PeasyCam(this, dimX/2, dimY/2, 0, 900);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  cam.setYawRotationMode();
  //cam.setActive(false);
}


/**
 * Method call at each frame of the windows
 **/
void draw() {
  background(51);
  cam.beginHUD();
  
  // change in the number of discretisation points
  fill(255);
  textSize(25);
  text("Nombre de points de la discrétisation :", 15, 25); 
  textSize(20);
  text(tx5, 15, 50);
  text(tx8, 15, 70);
  text(tx12, 15, 90);
  
  // marker
  fill(255, 0, 0);
  text(" < ", 80, marqueur_nb_points);
  
  // change the colour of the next selected value
  if (mouseX >= 18 && mouseX <= 70){
    // 5x5
    if (mouseY >= 30 && mouseY <= 50){
      fill(255,0,0);
      text(tx5, 15, 50);
    }
    // 8x12
    if (mouseY >= 50 && mouseY <= 70){
      fill(255,0,0);
      text(tx8, 15, 70);
    }
    // 12x18
    if (mouseY >= 70 && mouseY <= 90){
      fill(255,0,0);
      text(tx12, 15, 90);
    }
  }
  
  // change the number of spring
  fill(255);
  textSize(25);
  text("Ressorts diagonaux :", 550, 25); 
  textSize(20);
  text(txAvec, 800, 25);
  text(txSans, 870, 25);
  
  // marker
  fill(255, 0, 0);
  text(" > ", marqueur_diag, 25);
  
  // change the colour of the next selected value
  if (mouseY >= 15 && mouseY <= 30){
    // with diagonal spring
    if (mouseX >= 795 && mouseX <= 845){
      fill(255,0,0);
      text(txAvec, 800, 25);
    }
    // without diagonal spring
    if (mouseX >= 865 && mouseX <= 915){
      fill(255,0,0);
      text(txSans, 870, 25);
    }
  }
  
  
  // change the texture
  fill(255);
  textSize(25);
  text("Texture :", 550, 50); 
  textSize(20);
  text(txAvec, 800, 50);
  text(txSans, 870, 50);
  
  // marker
  fill(255, 0, 0);
  text(" > ", marqueur_texture, 50);
  
  // change the colour of the next selected value
  if (mouseY >= 40 && mouseY <= 53){
    // with texture
    if (mouseX >= 795 && mouseX <= 845){
      fill(255,0,0);
      text(txAvec, 800, 50);
    }
    // without texture
    if (mouseX >= 865 && mouseX <= 915){
      fill(255,0,0);
      text(txSans, 870, 50);
    }
  }
  cam.endHUD();
  
  // draw stake
  stroke(50);
  fill(255);
  translate(mass[0][0].position.x+5, mass[0][0].position.y+10000/2, 0);
  box(10,10000,10);
  translate(-mass[0][0].position.x+5, -(mass[0][0].position.y+10000/2), 0);
  
  
  fill(120,150,120);
  translate(width/2, height*1.4, 0);
  box(3000,10,3000);
  translate(-width/2, -height*1.4, 0);
  //line(mass[0][0].position.x-10, mass[0][0].position.y, 0, mass[0][0].position.x-10, 10000, 0);  // ligne gauche
  //line(mass[0][0].position.x, mass[0][0].position.y, 0, mass[0][0].position.x-10, mass[0][0].position.y, 0);  // parallele
  //line(mass[0][0].position.x, mass[0][0].position.y, 0, mass[0][0].position.x, 10000, 0);  // ligne droite
  
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
  
  
  if (texture){
    // flag aspect
    float longueurTexture = 800;
    float hauteurTexture = 1200;
    
    float ratiolongueur = longueurTexture/(float)(dimGridX-1);
    float ratiohauteur = hauteurTexture/(float)(dimGridY-1);
    
    for ( int i = 0; i < dimGridX-1; i++) {
      for ( int j = 0; j < dimGridY-1; j++ ) {
        float x1 = mass[i][j].position.x;
        float y1 = mass[i][j].position.y;
        float z1 = mass[i][j].position.z;
        float x2 = mass[i+1][j].position.x;
        float y2 = mass[i+1][j].position.y;
        float z2 = mass[i+1][j].position.z;
        float x3 = mass[i+1][j+1].position.x;
        float y3 = mass[i+1][j+1].position.y;
        float z3 = mass[i+1][j+1].position.z;
        float x4 = mass[i][j+1].position.x;
        float y4 = mass[i][j+1].position.y;
        float z4 = mass[i][j+1].position.z;
        
        noStroke();
        beginShape();
        texture(img);
        vertex(x1, y1, z1, ratiohauteur*j, ratiolongueur*i);
        vertex(x2, y2, z2, ratiohauteur*j, ratiolongueur*(i+1));
        vertex(x3, y3, z3, ratiohauteur*(j+1), ratiolongueur*(i+1));
        vertex(x4, y4, z4, ratiohauteur*(j+1), ratiolongueur*i);
        endShape();
  
      }
    }
  }
  
  
  // random wind
  float choice = random(0,10000);
  if ( choice > 9900 ) {
    float choice_more = random(0,100);
    float ran = random(0,0.5);
    int borne = 85;
    float switch_z = random(0,100);
    if ( !decrease_wind ) borne = 100 - borne;
    if ( choice_more > borne ) {
      System.out.println("wsh");
      wind_velocity.add(wind_velocity.copy().mult(ran));
    }else{
      wind_velocity.sub(wind_velocity.copy().mult(ran));
    }
    if ( switch_z > 60 ) wind_velocity.z *= -1;
    if ( wind_velocity.x < 30 && decrease_wind )
      decrease_wind = false;
    else if ( wind_velocity.x > 200 && !decrease_wind )
      decrease_wind = true;
    System.out.println("New wind : "+wind_velocity);
  }
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
      mass[i][j] = new Mass(i, j, x, y, masse, l0, true);
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
        marqueur_nb_points = 52;
        this.dimGridX = 5;
        this.dimGridY = 5;
        l0 = 50;
        this.initGrid();
      }
      // 8x12
      if (mouseY >= 50 && mouseY <= 70){
        marqueur_nb_points = 72;
        this.dimGridX = 8;
        this.dimGridY = 12;
        l0 = 50;
        this.initGrid();
      }
      // 12x18
      if (mouseY >= 70 && mouseY <= 90){
        marqueur_nb_points = 92;
        this.dimGridX = 12;
        this.dimGridY = 18;
        Xinit = 90;
        Yinit = 150;
        l0 = 20;
        this.initGrid();
      }
    }
    
    // change diagonal spring
    if (mouseY >= 15 && mouseY <= 30){
    // with diagonal spring
      if (mouseX >= 795 && mouseX <= 845){
        marqueur_diag = 780;
        diagonal_spring = true;
        this.initGrid();
      }
      // without diagonal spring
      if (mouseX >= 865 && mouseX <= 915){
        marqueur_diag = 850;
        diagonal_spring = false;
        this.initGrid();
      }
    }
    
    // change texture
    if (mouseY >= 40 && mouseY <= 53){
      // with texture
      if (mouseX >= 795 && mouseX <= 845){
        marqueur_texture = 780;
        texture = true;
      }
      // without texture
      if (mouseX >= 865 && mouseX <= 915){        
        marqueur_texture = 850;
        texture = false;
      }
    }
    
    
  }
}
