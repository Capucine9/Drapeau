// wind velocity
PVector wind_velocity = new PVector(100, 1, 10);

// the number of mass per ligne
int nbMasseOrd = 8;

// the number of mass per column
int nbMasseAbs = 12;


// gravity force in m/s
final PVector GRAVITY = new PVector(0,9.8,0);


// weight of a mass (kg)
float masse = 1;



////////////////////////////////////// CONSTANT
// air resistance constant
final float D = 0.4;

//stifness coefficient
float k=100;

// spring length difference
float delta_l;

// damping coefficient
float c=10;


// time step (must be between 0.001 and 0.005 for the smallest flag, 0.001 for the bigger. Else bugged simulation)
final float delta_t = 0.001;
  
  



//
float change_wind_proba = 0.992;
//
float add_wind_proba = 0.85;
//
float invert_Z_wind_proba = 0.6;
//
float factor_wind_max = 0.4;
//
float min_X_velocity = 30;
float max_X_velocity = 200;
