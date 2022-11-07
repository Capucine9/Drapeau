/**
 * Class which a mass, a part of the flag
 *
 * @author Hubert C. / Charron M.
 **/
class Mass {
  
  
  // the coordinates of the mass in the array of mass (but also in the flag)
  int i = -1;    // line coordinate
  int j = -1;    // column coordinate
  
  
  // the position of the mass in the world
  PVector position;
  
  
  // the velocity of the mass at the actual time (at the actual frame of the window)
  PVector velocity = new PVector (0, 0, 0);
  
  // the acceleration of the mass at the actual time (at the actual frame of the window)
  PVector acceleration;
  
  // the sum of force recieved by being the anchor of a spring for multiple mass
  // allow to apply the third law of newton
  PVector forceExterieure = new PVector(0,0, 0);
  
  // the radius of the mass
  float radius = 2;
  
  // the mass/weight of the mass
  float m = masse;
  
  // boolean to know if the mass is fixed on its position (like fix on a post)
  boolean canMove = true;
  


  /**
   * Constructor of the object. The mobility of the mass is requiered and must never change.
   **/
  Mass(int i, int j, float x, float y, int longueur_a_vide, boolean _canMove) {
    this.i = i;
    this.j = j;
    position = new PVector(x, y, 0);
    l0 = longueur_a_vide;
    this.canMove = _canMove;
  }



  
  /**
   * Function to update the position and velocity of the mass, according to position of other mass, wind, stifness ...
   * A mass is attracted by four spring :
   *  - on his right
   *  - up
   *  - upper left
   *  - upper right
   * The four force are computed (if diagonal enabled) and then, the wind, air resistance and gravity are apply.
   **/
  void update() {  

    PVector forceLeft =       calculRessortForce(i, j-1, false);
    PVector forceUp =         calculRessortForce(i-1, j, false);
    // diagonal spring
    PVector forceDiagLeft = new PVector(0,0,0);
    PVector forceDiagRight = new PVector(0,0,0);
    // if diagonal spring are enable, compute force, else, they are null
    if (diagonal_spring ){
      forceDiagLeft =   calculRessortForce(i-1, j-1, true);
      forceDiagRight =  calculRessortForce(i-1, j+1, true);
    }
    
    //sum of forces
    PVector air = new PVector (velocity.x * -D , velocity.y * -D, velocity.z * -D);
    PVector wind = new PVector (wind_velocity.x * D , wind_velocity.y * D, wind_velocity.z * D);
    PVector somme = air.copy();
    somme.add(air);
    somme.add(wind);
    
    // add spring force
    somme.add(forceLeft);
    somme.add(forceUp);
    somme.add(forceDiagLeft);
    somme.add(forceDiagRight);
    somme.add(forceExterieure);
    somme.div(m);
    somme.add(GRAVITY); 
    somme.mult(delta_t);
    // apply modification of velocity and position only if the mass can move
    if ( this.canMove ) {
      velocity.add(somme);
      position.add(velocity);
    }
    
    // reset external force, beacause this force is independent of time
    forceExterieure = new PVector(0,0);
    
  }





  /**
   * Function that computed and return the force apply to the mass, according to the spring anchored at the position of the mass specified by its
   * flag coordinates. The parameter isDiag must be true if the anchor is in diagonal of the mass (important for the difference of spring length)
   */
  PVector calculRessortForce(int indexRowSpringAnchor, int indexColumnSpringAnchor, boolean isDiag) {
    // if coordinates are out of bounds, then the spring doesn't exist
    if ( indexRowSpringAnchor < 0 || indexRowSpringAnchor >= nbMasseOrd || indexColumnSpringAnchor < 0 || indexColumnSpringAnchor >= nbMasseAbs )
      return new PVector(0,0);
    
    // position of mass and spring anchor
    float xMasse = position.x;
    float yMasse = position.y;
    float zMasse = position.z;
    float xAnchorSpring = mass[indexRowSpringAnchor][indexColumnSpringAnchor].position.x;
    float yAnchorSpring = mass[indexRowSpringAnchor][indexColumnSpringAnchor].position.y;
    float zAnchorSpring = mass[indexRowSpringAnchor][indexColumnSpringAnchor].position.z;
    
    // difference of position
    float d_l_v = ((xMasse - xAnchorSpring)) * ((xMasse - xAnchorSpring));
    float d_l_h = ((yMasse - yAnchorSpring)) * ((yMasse - yAnchorSpring));
    float d_l_p = ((zMasse - zAnchorSpring)) * ((zMasse - zAnchorSpring));
    
    float d_l;
    // calculated the difference of distance (according if the spring is in diagonal)
    if ( isDiag )
      d_l = sqrt(d_l_v + d_l_h + d_l_p) - (l0*sqrt(2));      
    else
      d_l = sqrt(d_l_v + d_l_h + d_l_p) - l0;
    
    // distance (for normalized)
    float distance = dist(xMasse, yMasse, zMasse, xAnchorSpring, yAnchorSpring, zAnchorSpring);
    //norm for each axis
    float Nx = (xMasse - xAnchorSpring)/distance;
    float Ny = (yMasse - yAnchorSpring)/distance;
    float Nz = (zMasse - zAnchorSpring)/distance;
 
    PVector stifness = new PVector (-k * d_l * Nx, -k * d_l * Ny, -k * d_l * Nz);
    PVector damping = new PVector (-c * velocity.x * Nx , -c * velocity.y * Ny, -c * velocity.z * Nz);
    
    // if texture is disabled, then draw the spring like a line with a specific color. The color of the line
    // represent the amount of force apply on this spring. The line is white and becoma more red until hte spring as
    // his length superior at (2*lo) * sqrt(k/2)
    if ( !texture ) {
      float ratio = 1-(d_l/l0)*(sqrt(k/2));
      int green = 255;
      int blue = 255;
      //if ( ratio > 0.5 ) {
        
      //  green = 255;
      //  blue = (int) (255 * ((ratio-0.5)/0.5));
      //}else{
      //  green = (int) (255 * (ratio/0.5));
      //  blue = 0;
      //}
        
      stroke(255,green,blue);
      line(xMasse, yMasse, zMasse, xAnchorSpring, yAnchorSpring, zAnchorSpring);
    }
    
    PVector force = stifness.add(damping);
    // according to the third law of newton, the force "force" apply on this mass, is also apply to the mass that are the spring anchor of this force
    mass[indexRowSpringAnchor][indexColumnSpringAnchor].forceExterieure.add(force.mult(-1));
    return force.mult(-1);
  }
}
