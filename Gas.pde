/*****************************************************************************
Gas interface contains gas constants and abstract methods for all gas objects.
Implemented by GasBody and Particle classes.
*****************************************************************************/
interface Gas {
  
  // Gas constants and parameters
  static final float  R                 = 8.314;  // TODO: correct value for avogardro
  static final float  molesPerParticle  = 4.1/numberOfParticles;
  static final float  M                 = 0.014; // Molar mass of nitrogen 14g/mol
  static final float  vScale            = 0.001;
  
  // Abstract methods 
  abstract void Destroy();
}