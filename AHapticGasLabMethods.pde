// AHapticGasLabMethods.pde

// This sketch contatins all the methods for the main program


// Looks for a serial device and tries to set it up as a Haptic device
// returns true if successful.
boolean InitialiseHapticDevice() {
  if (Serial.list().length == 0) {
    return false;
  }
  else {
    haply_board = new Board(this, Serial.list()[0], 0);
    haply_2DOF = new Device(DeviceType.HaplyTwoDOF, deviceID, haply_board);
    return true;
  }
}


// Creates an instance of the world and its contents and initialises all properties
void InitialiseWorld() {

  hAPI_Fisica.init(this);               // Initialise Fisica engine
  hAPI_Fisica.setScale(ppcm);     
  world = new FWorld();
  world.setGravity((0.0), (0.0));
  particleImage = loadImage("../img/particle.png");
  particleImage.resize((int)(hAPI_Fisica.worldToScreen(0.2)), (int)(hAPI_Fisica.worldToScreen(0.2)));
  cylinderImage = loadImage("../img/cylinder.png");
  cylinderImage.resize((int)(hAPI_Fisica.worldToScreen(6)), (int)(hAPI_Fisica.worldToScreen(13)));
  pistonImage = loadImage("../img/piston.png");
  pistonImage.resize((int)(hAPI_Fisica.worldToScreen(5)), (int)(hAPI_Fisica.worldToScreen(.5)));
    
  GasCylinder = new Container(3.8+3.5, 2+6.5);  // Add a gas cylinder to the world
  
  s= new HVirtualCoupling(.5);          // Setup the Virtual Coupling Contact Rendering Technique
  s.h_avatar.setDensity(5); 
  s.h_avatar.setFill(255, 0, 0); 
  s.h_avatar.setDrawable(false);
  s.init(world, worldWidth/2, 0.6); 

  //haply_avatar = loadImage("../img/Haply_avatar.png"); 
  //haply_avatar.resize((int)(hAPI_Fisica.worldToScreen(1)), (int)(hAPI_Fisica.worldToScreen(1)));
  //s.h_avatar.attachImage(haply_avatar); 

  //sc = new FCompound(); 
  //sc.addBody(s.h_avatar);
  //sc.addBody(GasCylinder.Piston);
  world.draw();
}


// Keyboard controls
void keyPressed() {
  if (key == 's') {
    if (GasCylinder.Piston.isStatic()) {
      GasCylinder.Piston.setStatic(false);
      println("Piston unlocked");
    } else {
      GasCylinder.Piston.setStatic(true);
      println("Piston locked");
    }
  }
  else if (key == 'p') {
    if (isPlaying == true) {
      isPlaying = false;
      println("Paused");
    }
    else {
      isPlaying = true;
      println("Unpaused");
    }
  }
  else if (key == 'x') {
    // Temperature up
    float t = GasCylinder.Gas.GetTemperature() + 5;
    GasCylinder.Gas.SetTemperature(t);
  }
  else if (key == 'z') {
    // Temperature down
    float t = GasCylinder.Gas.GetTemperature() - 5;
    GasCylinder.Gas.SetTemperature(t);   
  }
}


// Haptic timer methods
void InitialiseHapticTimer() { 
  haptic_timer = CountdownTimerService.getNewCountdownTimer(this).configure(SIMULATION_PERIOD, HOUR_IN_MILLIS).start();
}


void onFinishEvent(CountdownTimer t) {
  println("Resetting timer...");
  haptic_timer.reset();
  haptic_timer = CountdownTimerService.getNewCountdownTimer(this).configure(SIMULATION_PERIOD, HOUR_IN_MILLIS).start();
}