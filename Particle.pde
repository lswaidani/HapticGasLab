/***************************************************************************
Particle class implements Gas, creates an instance of a single gas particle.
Must be instantiated by a GasBody object.
***************************************************************************/
class Particle implements Gas {

  private FCircle   particleBody;
  
  // Particle properties
  private float     velX;
  private float     velY;
  private float     velMag;
  //private float     kineticTemp;
  
  
  // Constructor creates particle at (xPos, YPos)
  Particle(float xPos, float yPos, float temp) {
    
    //kineticTemp = temp;
    
    // Randomise velocity vector direction
    velX = random(-1,1);
    velY = random(-1,1);
    velMag = mag(velX,velY);
    
    // Calculate and apply the average speed for temperature value
    float velTarget = CalculateVelocityFromTemp(temp);
    velX = velX*velTarget/velMag;
    velY = velY*velTarget/velMag;
    
    // Configure particle body in Fisica
    particleBody = new FCircle(0.3);
    particleBody.setDensity(20);
    particleBody.setBullet(true);
    particleBody.setRotatable(false);
    particleBody.setRestitution(1.0);
    particleBody.setFriction(0.0);
    particleBody.setDamping(0.0);
    particleBody.setHaptic(false);
    particleBody.setFill((0),random(255),(0));
    particleBody.setPosition(xPos, yPos);
    particleBody.setVelocity(velX,velY);
    particleBody.setGrabbable(false);
    
    world.add(particleBody); 
  }
  
  
  void UpdateProperties() {
    velX = particleBody.getVelocityX();
    velY = particleBody.getVelocityY();
    velMag = mag(velX,velY);
    //kineticTemp = CalculateKineticTemp();
  }
  
  
  //void AdjustVelocity (float tempAdjust) {
  //  // If particle is at rest randomise direction
  //  /*if (velMag == 0) {
  //    velX = random(-1,1);
  //    velY = random(-1,1);
  //    velMag = mag(velX,velY);
  //  }*/
    
  //  // Calculate the velocity adjustment according to kinetic-temp
  //  //float vNew = CalculateVelocityFromTemp(kineticTemp+tempAdjust);
  //  // set/adjust velocity
  //  velX = velX*vNew/velMag-velX;
  //  velY = velY*vNew/velMag-velY;
  //  particleBody.addImpulse(velX*particleBody.getMass()*10, velY*particleBody.getMass()*10);
  //}
  

  // Kinetic-Temperature Equations
  float CalculateVelocityFromTemp(float T) { return sqrt(3*R*T/M)*vScale; }  // Use to calculate the 'correct' velocity according to a new temperature
  float CalculateKineticTemp() { return pow(velMag/vScale,2)*M/(3*R); }    // Calculate kinetic temperature according to current particle velocity
  
  
  // Access private variables
  float GetVelocity() { return velMag; }
  //float GetTemperature() { return kineticTemp; }


  void Destroy() {
    particleBody.removeFromWorld();
  }
  
}