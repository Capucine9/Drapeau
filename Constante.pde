/**
 * File of constants use in the program
 *
 * @author Hubert C. / Charron M.
 **/
 
 
 
// ======================================================================================
// Environment
// ======================================================================================

// the number of mass per ligne
int nbMasseOrd = 8;

// the number of mass per column
int nbMasseAbs = 12;

// air resistance constant                                       default : 0.4
final float D = 0.4;

// time step (must be between 0.001 and 0.005 for the smallest flag, 0.001 for the bigger. Else bugged simulation)     default : 0.001
final float delta_t = 0.001;




// ======================================================================================
// Environment forces
// ======================================================================================

// wind velocity                                                 default : (100, 1, 10)
PVector wind_velocity = new PVector(100, 1, 10);

// gravity force in m/s
final PVector GRAVITY = new PVector(0,9.8,0);




// ======================================================================================
// Wind changes probability (at each frame)
// ======================================================================================

// The probability that the wind doens't change this frame      default : 0.992
float not_change_wind_proba = 0.992;

// The probability to decrease the wind                         default : 0.85
float sub_wind_proba = 0.85;

// The probability to invert the Z direction of the wind        default : 0.6
float invert_Z_wind_proba = 0.6;

// The max factor of the wind that can be add to the wind       default : 0.4
float factor_wind_max = 0.4;

// The boundary of the wind (in x)                              default : 30-200
float min_X_velocity = 30;
float max_X_velocity = 200;




// ======================================================================================
// Spring constants
// ======================================================================================

//stifness coefficient                                         default : 100
float k = 100;

// damping coefficient                                         default : 10
float c = 10;

// weight of a mass (kg)                                       default : 1
float masse = 1;
