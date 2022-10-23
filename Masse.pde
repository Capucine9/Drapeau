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
  PVector velocity = new PVector (0, 0);
  
  // the acceleration of the mass at the time t;
  PVector acceleration;

  // the radius of the mass
  float radius;
  
  // the mass of the mass
  float m;
  
  ////////////////////////////////////// CONSTANT
  // air resistance constant
  final float D = 0;
  
  //stifness coefficient
  float k=1;
  
  // spring length difference
  float delta_l;
  
  // damping coefficient
  float c=0.5;
  
  // wind velocity
  PVector wind_velocity = new PVector(2, 0);
  
  // sum of forces
  PVector sum;
  
  // time step
  final float delta_t = 0.0;


  /**
   * Constructor of the object
   **/
  Mass(int i, int j, float x, float y, float diametre, float masse, int longueur_a_vide) {
    this.i = i;
    this.j = j;
    float Xinit = x;
    float Yinit = y;
    position = new PVector(x, y);
    // init an random initial velocity
    //velocity0 = new PVector(0, 0);
    radius = diametre / 2;
    //velocity = new PVector(velocity0.x, velocity0.y);
    //velocity = new PVector(velocity.x, velocity.y);
    m = masse;
    l0 = longueur_a_vide;
    
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
    
    
   
    
    // vecteur aleatoire + ajout frottement
    // calculate forces
    PVector air = new PVector (velocity.x * -D , velocity.y * -D);
    PVector wind = new PVector (wind_velocity.x * D , wind_velocity.y * D);
    
    float d_l = (position.y - Yinit) - l0;
    float x1 = position.x;
    float y1 = position.y;
    float x2 = Xinit;
    float y2 = Yinit;
    // distance (pour normalisation) : dist(x1, y1, x2, y2)
    float distance = dist(x1, y1, x2, y2);
    //norme en x
    float Nx = (x1 - x2)/distance;
    //norme en y
    float Ny = (y1 - y2)/distance;
    
    PVector stifness = new PVector (-k * d_l * Nx, -k * d_l * Ny);
    PVector damping = new PVector (-c * velocity.x * Nx , -c * velocity.y * Ny);
    
    //sum of forces
    PVector somme = air.copy();
    somme.add(air);
    somme.add(wind);
  
  
    //PVector somme = new PVector (0,0);
    somme.add(stifness);
    somme.add(damping);
    somme.div(m);
    somme.add(GRAVITY); 
    somme.mult(delta_t);
    velocity.add(somme);
    position.add(velocity);
    
  }


  
  /**
   * Check if the mass hurt a wall or not, and recalculate its velocity
   **/
  /*void checkBoundaryCollision() {
    // RIGHT
    if (position.x > width-radius) {
      position.x = width-radius;
      // modification of transversale velocity (friction)
      velocity.y *= -1;
      // modification of normale velocity (bouncy)
      velocity.x *= -1;
      velocity0.x *= -1;
    }
    
    // LEFT
    if (position.x < radius) {
      position.x = radius;
      velocity.y *= -1;
      velocity.x *= -1;
      velocity0.x *= -1;
    }
    
    // BOTTOM
    if (position.y > height-radius) {
      position.y = height-radius;
      velocity.x *= -1;
      velocity.y *= -1;
      velocity0 = velocity;
      
      // new trajectoty so initialize time
      t = 0.1;
    }
    
    // TOP
    if (position.y < radius) {
      position.y = radius;
      velocity.x *= -1;
      velocity.y *= -1;
      velocity0 = velocity;
      
      // new trajectoty so initialize time
      t = 0.1;
    }
  }*/

 
  /**
   * Display the mass and his velocity vector
   **/
  void display() {
    noStroke();
    fill(204);
    ellipse(position.x, position.y, radius*2, radius*2);
  
    
    // display the velocity of the mass
    stroke(204, 102, 0);
    line(position.x, position.y, position.x + velocity.x*20, position.y + velocity.y*20);
    
  }
}
