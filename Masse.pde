/**
 * Class which represent a flag 
 **/
class Mass {
  
  int i = -1;
  int j = -1;
  
  // the position of the mass in the world
  PVector position;
  
  // the initial velocity of the mass
  //PVector velocity0;
  
  // the velocity of the mass at the time t;
  PVector velocity = new PVector (0, 0, 0);
  
  // the acceleration of the mass at the time t;
  PVector acceleration;
  
  //
  PVector forceExterieure = new PVector(0,0, 0);
  
  // the radius of the mass
  float radius = 2;
  
  // the mass of the mass
  float m;
  
  //
  boolean canMove = true;
  
  ////////////////////////////////////// CONSTANT
  // air resistance constant
  final float D = 0.4;
  
  //stifness coefficient
  float k=100;
  
  // spring length difference
  float delta_l;
  
  // damping coefficient
  float c=3;
  
  // wind velocity
  PVector wind_velocity = new PVector(100, 0, 10);
  
  // time step
  final float delta_t = 0.001;


  /**
   * Constructor of the object
   **/
  Mass(int i, int j, float x, float y, float masse, int longueur_a_vide, boolean _canMove) {
    this.i = i;
    this.j = j;
    position = new PVector(x, y, 0);
    // init an random initial velocity
    //velocity0 = new PVector(0, 0);
    //velocity = new PVector(velocity0.x, velocity0.y);
    //velocity = new PVector(velocity.x, velocity.y);
    m = masse;
    l0 = longueur_a_vide;
    this.canMove = _canMove;
  }


  /**
   * Update the attribute of the mass, its position thanks to the calculation of the velocity and acceleration at time t.
  **/ 
  //void updateOld() {
  //  // calculate forces
  //  PVector air = new PVector (velocity.x * -D , velocity.y * -D);
  //  PVector wind = new PVector (wind_velocity.x * D , wind_velocity.y * D);
    
  //  delta_l = position.y - Yinit - l0;
  //  PVector stifness = new PVector (0, -k * delta_l);
  //  PVector damping = new PVector (0 , -c * velocity.y);
    
  //  // sum of forces
  //  //PVector sum = air.copy();
  //  sum = new PVector (0,0);
  //  //sum.add(air);
  //  //sum.add(wind);
  //  sum.add(stifness);
  //  //sum.add(damping);
    
  //  // division by mass
  //  sum.div(m);
    
  //  // calculate the acceleration at the time t
  //  //PVector tmp = new PVector(sum.x * (1 / m), sum.y * (-D / m));
  //  acceleration = sum.add(GRAVITY); 
    
  //  // calculate the velocity at the time t + delta t
  //  //PVector tmp1 = acceleration.mult(delta_t);
  //  //velocity.add(tmp1);
  //  acceleration.mult(delta_t);
  //  velocity.add(acceleration);
    
  //  // calculate the position at the time t + delta t
  //  PVector tmp2 = velocity.mult(delta_t);
  //  position.add(tmp2);
  //  System.out.println("position.y "+ position.y);
  //  System.out.println("-------------------------");

    
  //  //position.add(velocity);
    
  //  //t += 0.005;
  //}
  
  void update() {
    
    // vecteur vertical
    //float d_l = (position.y - Yinit) - l0;
    //PVector stifness = new PVector (0, -k * d_l);
    //PVector damping = new PVector (0 , -c * velocity.y);
    //PVector somme = new PVector (0,0);
    //somme.add(stifness);
    //somme.add(damping);
    //somme.div(m);
    //somme.add(GRAVITY); 
    //somme.mult(delta_t);
    //velocity.add(somme);
    ////velocity.mult(delta_t);
    //position.add(velocity);
    
    
    
    //// vecteur aleatoire
    //float d_l = (position.y - Yinit) - l0;
    //float x1 = position.x;
    //float y1 = position.y;
    //float x2 = Xinit;
    //float y2 = Yinit;
    //// distance (pour normalisation) : dist(x1, y1, x2, y2)
    //float distance = dist(x1, y1, x2, y2);
    ////norme en x
    //float Nx = (x1 - x2)/distance;
    ////norme en y
    //float Ny = (y1 - y2)/distance;
    
    //PVector stifness = new PVector (-k * d_l * Nx, -k * d_l * Ny);
    //PVector damping = new PVector (-c * velocity.x * Nx , -c * velocity.y * Ny);
    //PVector somme = new PVector (0,0);
    //somme.add(stifness);
    //somme.add(damping);
    //somme.div(m);
    //somme.add(GRAVITY); 
    //somme.mult(delta_t);
    //velocity.add(somme);
    //position.add(velocity);
    
    
    //// vecteur aleatoire + ajout frottement
    //// calculate forces
    //PVector air = new PVector (velocity.x * -D , velocity.y * -D);
    //PVector wind = new PVector (wind_velocity.x * D , wind_velocity.y * D);
    
    //float d_l = (position.y - Yinit) - l0;
    //float x1 = position.x;
    //float y1 = position.y;
    //float x2 = Xinit;
    //float y2 = Yinit;
    //// distance (pour normalisation) : dist(x1, y1, x2, y2)
    //float distance = dist(x1, y1, x2, y2);
    ////norme en x
    //float Nx = (x1 - x2)/distance;
    ////norme en y
    //float Ny = (y1 - y2)/distance;
    
    //PVector stifness = new PVector (-k * d_l * Nx, -k * d_l * Ny);
    //PVector damping = new PVector (-c * velocity.x * Nx , -c * velocity.y * Ny);
    
    
    
    //// flag aspect
    //for ( int i = 0; i < dimGridX-1; i++) {
    //  for ( int j = 0; j < dimGridY-1; j++ ) {
    //    float x1 = mass[i][j].position.x;
    //    float y1 = mass[i][j].position.y;
    //    float x2 = mass[i+1][j].position.x;
    //    float y2 = mass[i+1][j].position.y;
    //    float x3 = mass[i+1][j+1].position.x;
    //    float y3 = mass[i+1][j+1].position.y;
    //    float x4 = mass[i][j+1].position.x;
    //    float y4 = mass[i][j+1].position.y;
    //    fill(150,0,127);
    //    stroke(255);
    //    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    //  }
    //} 
    
    
    
    

    PVector forceLeft =       calculRessortForce(i, j-1, false);
    PVector forceUp =         calculRessortForce(i-1, j, false);
    // diagonal spring
    PVector forceDiagLeft = new PVector(0,0,0);
    PVector forceDiagRight = new PVector(0,0,0);
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
  
  
    //PVector somme = new PVector (0,0);
    somme.add(forceLeft);
    somme.add(forceUp);
    somme.add(forceDiagLeft);
    somme.add(forceDiagRight);
    somme.add(forceExterieure);
    forceExterieure = new PVector(0,0);
    somme.div(m);
    somme.add(GRAVITY); 
    somme.mult(delta_t);
    if ( this.canMove ) {
      velocity.add(somme);
      position.add(velocity);
    }
    
  }


  /**
   *
   */
  PVector calculRessortForce(int indexRowSpringAnchor, int indexColumnSpringAnchor, boolean isDiag) {
    if ( indexRowSpringAnchor < 0 || indexRowSpringAnchor >= dimGridX || indexColumnSpringAnchor < 0 || indexColumnSpringAnchor >= dimGridY )
      return new PVector(0,0);
    
    float xMasse = position.x;
    float yMasse = position.y;
    float zMasse = position.z;
    float xAnchorSpring = mass[indexRowSpringAnchor][indexColumnSpringAnchor].position.x;
    float yAnchorSpring = mass[indexRowSpringAnchor][indexColumnSpringAnchor].position.y;
    float zAnchorSpring = mass[indexRowSpringAnchor][indexColumnSpringAnchor].position.z;
    
    float d_l_v = ((xMasse - xAnchorSpring)) * ((xMasse - xAnchorSpring));
    float d_l_h = ((yMasse - yAnchorSpring)) * ((yMasse - yAnchorSpring));
    float d_l_p = ((zMasse - zAnchorSpring)) * ((zMasse - zAnchorSpring));
    float d_l;
    if ( isDiag )
      d_l = sqrt(d_l_v + d_l_h + d_l_p) - (l0*sqrt(2));      
    else
      d_l = sqrt(d_l_v + d_l_h + d_l_p) - l0;
    
    // distance (pour normalisation) : dist(x1, y1, x2, y2)
    float distance = dist(xMasse, yMasse, zMasse, xAnchorSpring, yAnchorSpring, zAnchorSpring);
    //norme en x
    float Nx = (xMasse - xAnchorSpring)/distance;
    //norme en y
    float Ny = (yMasse - yAnchorSpring)/distance;
    float Nz = (zMasse - zAnchorSpring)/distance;
    
    PVector stifness = new PVector (-k * d_l * Nx, -k * d_l * Ny, -k * d_l * Nz);
    PVector damping = new PVector (-c * velocity.x * Nx , -c * velocity.y * Ny, -c * velocity.z * Nz);
    
    stroke(255);
    line(xMasse, yMasse, zMasse, xAnchorSpring, yAnchorSpring, zAnchorSpring);
    
    PVector force = stifness.add(damping);
    mass[indexRowSpringAnchor][indexColumnSpringAnchor].forceExterieure.add(force.mult(-1));
    return force.mult(-1);
  }

 
  /**
   * Display the mass and his velocity vector
   **/
  void display() {
    noStroke();
    fill(204);
    translate(position.x, position.y, position.z);
    sphere(radius*2);
    translate(-position.x, -position.y, -position.z);
  
    
    // display the velocity of the mass
    
  }
}
