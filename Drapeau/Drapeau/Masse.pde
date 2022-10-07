/**
 * Class which represent a ball that bounces
 **/
class Ball {
  
  
  // the position of the ball in the world
  PVector position;
  
  // the initial velocity of the ball
  PVector velocity0;
  
  // the velocity of the ball at the time t;
  PVector velocity;
  
  // the acceleration of the ball at the time t;
  PVector acceleration;

  // the radius of the ball
  float radius;
  
  // the mass of the ball
  float m;
  
  ////////////////////////////////////// CONSTANT
  // air resistance constant
  final float D = 0.4;
  // restitution coefficient
  float cr_coef = 0.74;
  // friction coefficient
  final float CF = 0.6;


  /**
   * Constructor of the object
   **/
  Ball(float x, float y, float diametre, float masse, float cr_) {
    position = new PVector(x, y);
    // init an random initial velocity
    velocity0 = new PVector(random(-20,20),random(-3,-4));
    radius = diametre / 2;
    velocity = new PVector(velocity0.x, velocity0.y);
    m = masse;
    cr_coef =cr_;
  }


  /**
   * Update the attribute of the ball, its position thanks to the calculation of the velocity and acceleration at time t.
  **/ 
  void update() {
    // calculate the acceleration at the time t
    PVector tmp = new PVector(velocity.x * (-D / m), velocity.y * (-D / m) );
    acceleration = tmp.add(GRAVITY); 
    
    // calculate the velocity at the time t
    tmp = new PVector(velocity0.x, velocity0.y);
    velocity = tmp.add(acceleration.mult(t));
    
    position.add(velocity);
  }


  
  /**
   * Check if the ball hurt a wall or not, and recalculate its velocity
   **/
  void checkBoundaryCollision() {
    // RIGHT
    if (position.x > width-radius) {
      position.x = width-radius;
      // modification of transversale velocity (friction)
      velocity.y *= (1-CF);
      // modification of normale velocity (bouncy)
      velocity.x *= -cr_coef;
      velocity0.x *= -1;
    }
    
    // LEFT
    if (position.x < radius) {
      position.x = radius;
      velocity.y *= (1-CF);
      velocity.x *= -cr_coef;
      velocity0.x *= -1;
    }
    
    // BOTTOM
    if (position.y > height-radius) {
      position.y = height-radius;
      velocity.x *= (1-CF);
      velocity.y *= -cr_coef;
      velocity0 = velocity;
      
      // new trajectoty so initialize time
      t = 0.1;
    }
    
    // TOP
    if (position.y < radius) {
      position.y = radius;
      velocity.x *= (1-CF);
      velocity.y *= -cr_coef;
      velocity0 = velocity;
      
      // new trajectoty so initialize time
      t = 0.1;
    }
  }

 
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
    
  }
}
