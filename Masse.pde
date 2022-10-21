/**
 * Class which represent a ball that bounces
 **/
class Ball {
  
  
  // the position of the ball in the world
  PVector position;
  
  // the initial velocity of the ball
  //PVector velocity0;
  
  // the velocity of the ball at the time t;
  PVector velocity = new PVector (0, 0);
  
  // the acceleration of the ball at the time t;
  PVector acceleration;

  // the radius of the ball
  float radius;
  
  // the mass of the ball
  float m;
  
  ////////////////////////////////////// CONSTANT
  // air resistance constant
  final float D = 0.4;
  
  //stifness coefficient
  float k=10;
  
  // spring length difference
  float delta_l;
  
  // damping coefficient
  float c=1;
  
  // wind velocity
  PVector wind_velocity = new PVector(0, 0);
  
  // sum of forces
  PVector sum;
  
  // time step
  final float delta_t = 0.05;


  /**
   * Constructor of the object
   **/
  Ball(float x, float y, float diametre, float masse, int longueur_a_vide) {
    float Xinit = x;
    float Yinit = y;
    position = new PVector(x, y);
    // init an random initial velocity
    //velocity0 = new PVector(0, 0);
    radius = diametre / 2;
    //velocity = new PVector(velocity0.x, velocity0.y);
    velocity = new PVector(velocity.x, velocity.y);
    m = masse;
    l0 = longueur_a_vide;
    
  }


  /**
   * Update the attribute of the ball, its position thanks to the calculation of the velocity and acceleration at time t.
  **/ 
  void update() {
    // calculate forces
    PVector air = new PVector (velocity.x * -D , velocity.y * -D);
    PVector wind = new PVector (wind_velocity.x * D , wind_velocity.y * D);
    
    delta_l = position.y - Yinit; //- l0;
    System.out.println("position.y "+ position.y);
    System.out.println("delta_l "+ delta_l);
    PVector stifness = new PVector (0, -k * delta_l);
    PVector damping = new PVector (0 , -c * velocity.y);
    
    // sum of forces
    //PVector sum = air.copy();
    sum = new PVector (0,0);
    sum.add(air);
    System.out.println("sum.y + air "+ sum.y);
    sum.add(wind);
    System.out.println("sum.y + wind "+ sum.y);
    sum.add(stifness);
    System.out.println("sum.y + stifness "+ sum.y);
    sum.add(damping);
    System.out.println("sum.y + damping "+ sum.y);
    
    // division by mass
    sum.div(m);
    System.out.println("sum.y/m "+ sum.y);
    
    
    // calculate the acceleration at the time t
    //PVector tmp = new PVector(sum.x * (1 / m), sum.y * (-D / m));
    acceleration = sum.add(GRAVITY); 
    System.out.println("acceleration.y : " + acceleration.y);
    
    // calculate the velocity at the time t + delta t
    //PVector tmp1 = acceleration.mult(delta_t);
    //velocity.add(tmp1);
    acceleration.mult(delta_t);
    velocity.add(acceleration);
    System.out.println("velocity.y : " + velocity.y);
    
    // calculate the position at the time t + delta t
    PVector tmp2 = velocity.mult(delta_t);
    position.add(tmp2);
    System.out.println("position.y "+ position.y);
    System.out.println("-------------------------");

    
    //position.add(velocity);
    
    //t += 0.005;
  }


  
  /**
   * Check if the ball hurt a wall or not, and recalculate its velocity
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
   * Display the ball and his velocity vector
   **/
  void display() {
    noStroke();
    fill(204);
    ellipse(position.x, position.y, radius*2, radius*2);
  
    
    // display the velocity of the ball
    stroke(204, 102, 0);
    line(position.x, position.y, position.x+velocity.x*20, position.y+velocity.y*20);
    
    // line representing a mass-spring system
    stroke(255);
    line(Xinit, Yinit, position.x, position.y);
    
  }
}
