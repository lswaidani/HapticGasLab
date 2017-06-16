/*******************************************************************************
GasBody implements Gas, manages behaviour of all Paritcle instances it posesses
Must be called by a Container object
*******************************************************************************/
class GasBody implements Gas {
  
  private PVector              topLeft, bottomRight;
  
  // Gas properties
  private float                actualTemp = 0;
  private float                pressure;
  private float                temperature;
  private float                volume;
  private float                moles;
  //private float                molarMass;
  private ArrayList<Particle>  Particles               = new ArrayList<Particle> ();
  private int                  N; // number of particles
  
  
  GasBody(float vol, int n, float temp, PVector containTopLeft, PVector containBottomRight) {
    volume = vol;
    N = n;
    temperature = temp;
    moles = 4.1;
    pressure = CalculatePressure();
    topLeft = containTopLeft;
    bottomRight = containBottomRight;
    
    for (int i=0; i<n; i++) {
      Particle p = CreateParticle();
      Particles.add(p);
    }
  }
  
  
  // Method for adding a particle the the GasBody
  private Particle CreateParticle() {
     Particle p = new Particle(random (topLeft.x, bottomRight.x), random (topLeft.y, bottomRight.y), temperature);
     return p;
  }
  
  
  // Update the physical properties of the gas and correct energy loss by adjusting velocity of particles
  void Update(float vol) {
    volume = vol;
    actualTemp = MeasureKineticTemperature();
    float error = actualTemp - temperature;
    restitution = 1 - 0.01*error;
    SetParticleRestitution(restitution);
    pressure = CalculatePressure();
    
  }
  
  
  float MeasureKineticTemperature() {
    float meanVel = 0;
    for (Particle p: Particles) {
      p.UpdateVelocity();
      meanVel = meanVel + p.GetVelocity();
    }
    meanVel = meanVel/N;
    return pow(meanVel/vScale,2)*M/(3*R);  // Calculate kinetic temperature according to current particle velocity
  }

  
  // Calculat the pressure reading according to PV=nRT
  float CalculatePressure() {
    return moles*R*actualTemp/volume;
  }
  
  
  void SetParticleRestitution(float r) {
    for (Particle p: Particles) {
      p.particleBody.setRestitution(r);
    }
  }
  
  // External access of private variables
  float GetVolume() { return volume; }
  float GetTemperature() { return temperature; }
  float GetPressure() { return pressure; }
  float GetMoles() { return moles; }
  float GetTemperatureActual() { return actualTemp; }

  void SetPressure(float pres) { pressure = pres; }
  void SetVolume(float vol) { volume = vol; }
  void SetMoles(float n) { moles = n; }
  //void SetMolarMass(float mass) { molarMass = mass; }
  void SetTemperature(float temp) { temperature = temp; }
  
  
  // Destroy all particles
  void Destroy() {
    for (Particle p : Particles) {
      p.Destroy();
      Particles.remove(p);
    }
  }
  
}