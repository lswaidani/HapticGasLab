void InitialiseHapticDevice() {
  haply_board = new Board(this, Serial.list()[0], 0);
  haply_2DOF = new Device(DeviceType.HaplyTwoDOF, deviceID, haply_board);
}


void InitialiseWorld() {
  // Initialise Fisica engine
  hAPI_Fisica.init(this); 
  hAPI_Fisica.setScale(ppcm); 
  world = new FWorld();
  world.setGravity((0.0), (0.0));

  GasCylinder = new Container(3.8, 2);

  // Setup the Virtual Coupling Contact Rendering Technique

  s= new HVirtualCoupling(1); 
  s.h_avatar.setDensity(1); 
  s.h_avatar.setFill(255, 0, 0); 
  s.init(world, worldWidth/2, 0.6); 
  haply_avatar = loadImage("../img/Haply_avatar.png"); 
  haply_avatar.resize((int)(hAPI_Fisica.worldToScreen(1)), (int)(hAPI_Fisica.worldToScreen(1)));
  s.h_avatar.attachImage(haply_avatar); 

  world.draw();
}


// Keyboard controls
void keyPressed() {
  if (key == 's') {
    if (GasCylinder.Piston.isStatic()) {
      GasCylinder.Piston.setStatic(false);
    } else {
      GasCylinder.Piston.setStatic(true);
    }
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