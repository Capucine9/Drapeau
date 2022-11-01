// import 3D camera handler package (PeasyCam)
import peasy.*;

/**
 * Main script of the program, script to launch with Processing
 *
 * @author Hubert C. / Charron M.
 */


// texture
PImage img;

// camera
PeasyCam cam;



// ======================================================================================
// IHM atributes
// ======================================================================================

// button text
String tx30 = "- 30x45"; 
String tx8 = "- 8x12";
String tx12 = "- 12x18";
String txAvec = "Avec";
String txSans = "Sans";

// marker ord for selected number of discretisation points
int marqueur_nb_points = 71;
// markeur ord for selected diagonal spring
int marqueur_diag = 850;
// marker ord for selected texture
int marqueur_texture = 850;

// boolean to make simulation with diagonal spring or not
boolean diagonal_spring = false;
// boolean to make simulation with texture or not
boolean texture = false;
 


// ======================================================================================
// Atributes link to the mass
// ======================================================================================
 
// the mass thta represent a flag ([i][], i represent the line. [][j], j represent a column)
// the position of a mass in the array of mass reflect the position of the mass in the flag
Mass[][] mass;

// coordinates of the first mass (upper left)
int Xinit = 200;
int Yinit = 200;

// empty length spring
int l0 = 50;


 
// ======================================================================================
// Atributes link to the mass
// ======================================================================================
 
// width of the windows
int dimWidth = 1000;
// height of the windows 
int dimHeight = 800;

// boolean that show if the program decrease wind velocity in the calcul of the new velocity
boolean decrease_wind = true;





/**
 * Function called after the function setup
 **/
void settings () {
  // set the size of the windows
   size(dimWidth, dimHeight, P3D);
}





/**
 * Function called at the start of the program
 **/
void setup() {
  // init the grid of mass that represent the flag
  this.initGrid();
  // load the imageof the texture
  img = loadImage("drapeau.png");
  
  // init the camera 
  cam = new PeasyCam(this, dimWidth/2, dimHeight/2, 0, 900);
  cam.setMinimumDistance(50);        // the power of the zoom
  cam.setMaximumDistance(3000);      // the power of the dezoom
  cam.setYawRotationMode();          // allow rotation only on the axe y
}





/**
 * Method call at each frame of the windows
 **/
void draw() {
  // color of the background of the window
  background(20,20,100);
  
  
  // ================================================================================================================================================================
  // IHM declaration (no affected by rotation)
  // ================================================================================================================================================================
  cam.beginHUD();
  
  
  // ======================================================================================
  // IHM to change the number of discretisation points
  // ======================================================================================
  fill(255);
  
  // Text
  textSize(25);
  text("Nombre de points de la discrétisation :", 15, 25); 
  textSize(20);
  text(tx30, 15, 50);
  text(tx8, 15, 70);
  text(tx12, 15, 90);
  
  // Marker
  fill(255, 0, 0);
  text(" < ", 80, marqueur_nb_points);
  // change the colour of the next selected value
  if (mouseX >= 18 && mouseX <= 70){
    // 5x5
    if (mouseY >= 30 && mouseY <= 50){
      fill(255,0,0);
      text(tx30, 15, 50);
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
  
  
  // ======================================================================================
  // IHM to display wind velocity
  // ======================================================================================
  fill(255);
  text("Vent : [x="+(int)wind_velocity.x+", y="+(int)wind_velocity.y+", z="+(int)wind_velocity.z+"]", 15, 120); 
  
  
  // ======================================================================================
  // IHM to command the precense of diagonal spring in the flag
  // ======================================================================================
  fill(255);
  textSize(25);
  text("Ressorts diagonaux :", 550, 25); 
  textSize(20);
  text(txAvec, 800, 25);
  text(txSans, 870, 25);
  
  // Marker
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
  
  
  // ======================================================================================
  // IHM to command the precense of texture on the flag
  // ======================================================================================
  fill(255);
  textSize(25);
  text("Texture :", 550, 50); 
  textSize(20);
  text(txAvec, 800, 50);
  text(txSans, 870, 50);
  
  // Marker
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
  // ================================================================================================================================================================
  // IHM declaration end (no affected by rotation)
  // ================================================================================================================================================================
  
  
  
  // ======================================================================================
  // Draw post
  // ======================================================================================
  stroke(50);
  fill(255);
  int stake_length = 2000;
  translate(mass[0][0].position.x+5, mass[0][0].position.y+stake_length/2, 0);
  box(10,stake_length,10);
  translate(-mass[0][0].position.x+5, -(mass[0][0].position.y+stake_length/2), 0);
  
  
  
  // ======================================================================================
  // Draw ground
  // ======================================================================================
  fill(30,80,30);
  translate(width/2, height*1.8, 0);
  box(5000,10,5000);
  translate(-width/2, -height*1.8, 0);
  stroke(255);
  line(Xinit, height*1.8-6, 2500, Xinit, height*1.8-6, -2500);
  line(2500+width/2, height*1.8-6, 0, 0+Xinit, height*1.8-6, 0);
  
  
  
  // ======================================================================================
  // Update mass positions
  // ======================================================================================
  for ( int y = nbMasseAbs-1; y >= 0; y--) {
    for ( int x = nbMasseOrd-1; x >= 0; x-- ) {
      mass[x][y].update();
    }
  }
  
  
  
  // ======================================================================================
  // Draw texture (if activated)
  // ======================================================================================
  if (texture){
    // flag aspect
    float longueurTexture = 800;
    float hauteurTexture = 1200;
    
    float ratiolongueur = longueurTexture/(float)(nbMasseOrd-1);
    float ratiohauteur = hauteurTexture/(float)(nbMasseAbs-1);
    
    for ( int i = 0; i < nbMasseOrd-1; i++) {
      for ( int j = 0; j < nbMasseAbs-1; j++ ) {
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
    
  
  
  // ======================================================================================
  // Calculate random wind
  // ======================================================================================
  int choice_max = 10000;
  float choice = random(0,choice_max);
  
  // probability to change the wind
  if ( choice > not_change_wind_proba*choice_max ) {
    float choice_more_max = 100;
    float choice_more = random(0,choice_more_max);    // probability to increase the wind (else decrease)
    float ran = random(0,factor_wind_max);            // factor of the actual wind, to add/remove to the wind
    float switch_z_max = 100;
    float switch_z = random(0,switch_z_max);          // probability to invert the Z direction of the wind
    
    int borne =  (int) (sub_wind_proba*choice_more_max);
    if ( !decrease_wind ) borne = (int) (1*choice_more_max) - borne;
    
    // increase the wind according to the radnom value
    if ( choice_more > borne ) {
      wind_velocity.add(wind_velocity.copy().mult(ran));
    }else{
      wind_velocity.sub(wind_velocity.copy().mult(ran));
    }
    
    // invert the Z velocity of the wind (if yes with proba)
    if ( switch_z > invert_Z_wind_proba*switch_z_max ) wind_velocity.z *= -1;
    
    // change the increase or decrease mode of the wind (to avoid unnatural wind)
    if ( wind_velocity.x < min_X_velocity && decrease_wind )
      decrease_wind = false;
    else if ( wind_velocity.x > max_X_velocity && !decrease_wind )
      decrease_wind = true;
  }
}





/**
 * Init all themass of the system with space of l0 between them. The first mass of the first and last line
 * are fixed and can't move.
 **/
void initGrid () {
  mass = new Mass[nbMasseOrd][nbMasseAbs];
  for ( int i = 0; i < nbMasseOrd; i++) {
    for ( int j = 0; j < nbMasseAbs; j++ ) {
      int x = Xinit + (l0 * j);
      int y = Yinit + (l0 * i);
      mass[i][j] = new Mass(i, j, x, y, l0, true);
    }
  }
  mass[0][0].canMove = false;
  mass[nbMasseOrd-1][0].canMove = false;
}





/**
 * Method executed when the user click on a mouse button
 **/
void mousePressed() {
  // if the left button of the mouse is pressed
  if ( mouseButton == LEFT ) {
    
    // ======================================================================================
    // Change number of discretisation points
    // ======================================================================================
    if (mouseX >= 18 && mouseX <= 70){
      // 30-45
      if (mouseY >= 30 && mouseY <= 50){
        marqueur_nb_points = 52;
        this.nbMasseOrd = 30;
        this.nbMasseAbs = 45;
        k = 350;
        c = 10;
        l0 = 15;
        this.initGrid();
      }
      // 8x12
      if (mouseY >= 50 && mouseY <= 70){
        marqueur_nb_points = 72;
        this.nbMasseOrd = 8;
        this.nbMasseAbs = 12;
        k=100;
        c=10;
        l0 = 50;
        this.initGrid();
      }
      // 12x18
      if (mouseY >= 70 && mouseY <= 90){
        marqueur_nb_points = 92;
        this.nbMasseOrd = 12;
        this.nbMasseAbs = 18;
        k=100;
        c=10;
        l0 = 20;
        this.initGrid();
      }
    }
    
    // ======================================================================================
    // Change diagonal spring mode
    // ======================================================================================
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
    
    // ======================================================================================
    // Change texture display mode
    // ======================================================================================
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
