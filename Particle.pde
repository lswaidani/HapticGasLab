/***************************************************************************
Particle class implements Gas, creates an instance of a single gas particle.
Must be instantiated by a GasBody object.
***************************************************************************/
class Particle implements Gas {
  
  private FCircle   particleBody;
  private float     velMag;
  
  
  Particle(float xPos, float yPos, float temp) {
    
    // Randomise velocity vector direction
    float velX = random(-1,1);
    float velY = random(-1,1);
    velMag = mag(velX,velY);
    
    // Calculate and apply the average speed for temperature value
    float velTarget = CalculateVelocityFromTemp(temp);
    velX = velX*velTarget/velMag;
    velY = velY*velTarget/velMag;
    
    // Configure particle body in Fisica
    particleBody = new FCircle(0.4);
    particleBody.setDensity(30);
    particleBody.setBullet(true);
    particleBody.setRotatable(false);
    particleBody.setRestitution(1.0);
    particleBody.setFriction(0.0);
    particleBody.setDamping(0.0);
    particleBody.setHaptic(false);
    particleBody.setPosition(xPos, yPos);
    particleBody.setVelocity(velX,velY);
    particleBody.setGrabbable(false);
    particleBody.attachImage(particleImage);
    
    // Create physics body
    world.add(particleBody); 
  }
  
  
  void UpdateVelocity() {
    float velX = particleBody.getVelocityX();
    float velY = particleBody.getVelocityY();
    velMag = mag(velX,velY);
  }
  

  // Kinetic-Temperature Equations
  float CalculateVelocityFromTemp(float T) { return sqrt(3*R*T/M)*vScale; }  // Use to calculate the 'correct' velocity according to a new temperature
  
  
  // Access private variables
  float GetVelocity() { return velMag; }

  
  // Automatically called when parent gas body is destroyed
  void Destroy() {
    particleBody.removeFromWorld();
  }
}