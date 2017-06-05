// Library imports   //<>//
import processing.serial.*;
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;
import g4p_controls.*;


void setup() {
  size(displayWidth, displayHeight, P2D); 
  InitialiseHapticDevice();
  InitialiseWorld();
  InitialiseHapticTimer();
  isPlaying = true;
  frameRate(60);
}


// Graphics loop 
void draw() {
  background(255); 
  if (!rendering_force) {
   // s.drawContactVectors(this);
  }
  DrawGUI();
  world.draw();
  //world.drawDebug();
}


// Physics and haptics loop
void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  if (guiCount>1) {
    guiCount--;
  } 
  else {
    GasCylinder.Update();
    guiCount = 50;
  }
  world.step(1.0f/1000.0f);

  rendering_force = true;

  if (haply_board.data_available()) {
    // GET END-EFFECTOR STATE (TASK SPACE) 
    angles.set(haply_2DOF.get_device_angles()); 
    pos_ee.set(haply_2DOF.get_device_position(angles.array()));
    pos_ee.set(pos_ee.copy().mult(100));
  }

  s.setToolPosition(xEE0 /*-pos_ee.x+1*/, yEE0 + pos_ee.y-3); 
  s.updateCouplingForce();

  f_ee.set(-s.getVCforceX(), s.getVCforceY());

  f_ee.div(9000); 
  haply_2DOF.set_device_torques(f_ee.array());
  torques.set(haply_2DOF.mechanisms.get_torque());
  haply_2DOF.device_write_torques();


  rendering_force = false;
}