// Library imports   //<>//
import processing.serial.*;
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;
//import g4p_controls.*;
//import processing.sound.*;

void setup() {
  //size(displayWidth, displayHeight, P2D); 
  fullScreen();
  if (InitialiseHapticDevice()) {
    isHapticSimulation=true;
  }
  InitialiseWorld();
  InitialiseHapticTimer();
  isPlaying = true;
  //Pulse pulse = new Pulse(this);
  //pulse.play();
  frameRate(60);
}


// Graphics loop 
void draw() {
  if (isPlaying == true) {
    background(255); 
    GasCylinder.UpdateBunsen();
    world.draw();
    
    // GUI update at multiple of frame rate
    if (guiCount>1) {
      guiCount--;
    } 
    else {
      guiCount = 5;
    }
    
    DrawGUI();
  }
}


// Physics and haptics loop
void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  
  // if game is playing (not paused)
  if (isPlaying==true) {
    // World update
    GasCylinder.Update();
    GasCylinder.Piston.addForce(0,-GasCylinder.pistonHeight*1000);
    world.step(1.0f/1000.0f,1);
  }
  
  // If Haply is connected then perfrom haptic commands
  if (isHapticSimulation==true) {
    if (haply_board.data_available()) {
      // GET END-EFFECTOR STATE (TASK SPACE) 
      angles.set(haply_2DOF.get_device_angles()); 
      pos_ee.set(haply_2DOF.get_device_position(angles.array()));
      pos_ee.set(pos_ee.copy().mult(100));
    }
  
    s.setToolPosition(xEE0 /*-pos_ee.x+1*/, yEE0 + pos_ee.y-3); 
    s.updateCouplingForce();
  
    f_ee.set(-s.getVCforceX(), s.getVCforceY());
  
    f_ee.div(12000); 
    haply_2DOF.set_device_torques(f_ee.array());
    torques.set(haply_2DOF.mechanisms.get_torque());
    haply_2DOF.device_write_torques();
  }
}