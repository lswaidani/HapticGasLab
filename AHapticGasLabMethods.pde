void InitialiseHapticDevice() {
  if (isHapticSimulation == true) {
    haply_board = new Board(this, Serial.list()[0], 0);
    haply_2DOF = new Device(DeviceType.HaplyTwoDOF, deviceID, haply_board);
  }
}


void InitialiseWorld() {
  // Initialise Fisica engine
  hAPI_Fisica.init(this); 
  hAPI_Fisica.setScale(ppcm); 
  world = new FWorld();
  world.setGravity((0.0), (0.0));

  GasCylinder = new Container(3.8, 2);
  
  bunsen = CreateBunsen();
  
  // Setup the Virtual Coupling Contact Rendering Technique

  s= new HVirtualCoupling(.5); 
  s.h_avatar.setDensity(1); 
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
      println("Unpuased");
    }
  }
  else if (key == 'x') {
    // Temperature up
    if (restitution>=1.5) {
      restitution = 1.5;
    }
    else {
      restitution = restitution + 0.01;
      GasCylinder.Gas.SetParticleRestitution(restitution);
      println("Bunsen burner: " + str(restitution));
    }
  }
  else if (key == 'z') {
    // Temperature down
    if (restitution<=0.5) {
      restitution = 0.5;
    }
    else {
      restitution = restitution - 0.01;
      GasCylinder.Gas.SetParticleRestitution(restitution);
      println("Bunsen burner: " + str(restitution));
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