// Display settings
final int         displayWidth          = 1920;
final int         displayHeight         = 1080;
final float       ppcm                  = 55.66/900*1080; // this is the resolution of the screen divided by the number of centimeters 

// World setup parameters
FWorld            world; 
boolean           isPlaying             = false;
boolean           isHapticSimulation    = true;

final float       worldWidth            = (displayWidth/2)/ppcm;  // world size
final float       worldHeight           = (displayHeight)/ppcm;  

float             edgeTopLeftX          = 0.0;                    // edges of the world
float             edgeTopLeftY          = 0.0; 
float             edgeBottomRightX      = worldWidth; 
float             edgeBottomRightY      = worldHeight; 

// World object parameters
HVirtualCoupling  s; 
PImage            haply_avatar;
final float       xEE0                  = worldWidth/2;  // Where the end effector starts
final float       yEE0                  = 0.6;

FCompound         sc;
Container         GasCylinder;
GasBody           Gas;
static int        numberOfParticles     = 200;
float             initialTemp           = 293;
float             restitution           = 1;

// Image files
PImage            particleImage; 
PImage            cylinderImage; 
PImage            pistonImage;

// Haptic device definitions
Device            haply_2DOF;
Board             haply_board;
byte              deviceID              = 0;
boolean           rendering_force       = false; 

// Joint space 
PVector           angles                = new PVector(0, 0);
PVector           torques               = new PVector(0, 0);

// Task space
PVector           pos_ee                = new PVector(0, 0);
PVector           pos_ee_last           = new PVector(0, 0); 
PVector           f_ee                  = new PVector(0, 0); 


// Simulation Speed Parameters 
final long        SIMULATION_PERIOD     = 1; // ms
final long        HOUR_IN_MILLIS        = 36000000;
CountdownTimer    haptic_timer;
final float       dt                    = SIMULATION_PERIOD/1000.0; 