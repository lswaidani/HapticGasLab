/**********************************************************************************
Container class creates an instance of a gas container and fills it with a GasBody.
**********************************************************************************/
class Container {
  
  // Container parameters 
  static final int  cHeight       = 13;
  static final int  cWidth        = 7;
  final float       thick         = .5;
  final float       xPos, yPos;
  final PVector     topLeft;
  final PVector     bottomRight;
  
  float             volume;
  float             pistonHeight;
  
  // Physical components
  FPoly             Cylinder;
  FPoly             Piston;
  
  // GasBody object
  GasBody           Gas;
  
  
  Container(float x, float y) {
    xPos = x;
    yPos = y;
    Cylinder = CreateCylinder();
    Piston = CreatePiston();
    topLeft = new PVector(x+2*thick,y+thick+2);
    bottomRight = new PVector(x+cWidth-2*thick,y+cHeight-2*thick);
    volume = CalculateVolume();
    Gas = CreateGas(); //<>//
  }
  
  
  // Create the cylinder component
  FPoly CreateCylinder() {
    FPoly cylinder = new FPoly();
    
    // Vertex geometry
    cylinder.vertex(0,               -thick);
    cylinder.vertex(0,               cHeight);
    cylinder.vertex(cWidth,          cHeight);
    cylinder.vertex(cWidth,          -thick);
    cylinder.vertex(cWidth-2*thick,  -thick);
    cylinder.vertex(cWidth-2*thick,  0);
    cylinder.vertex(cWidth-thick,    0);
    cylinder.vertex(cWidth-thick,    0+cHeight-thick);
    cylinder.vertex(thick,           0+cHeight-thick);
    cylinder.vertex(thick,           0);
    cylinder.vertex(2*thick,         0);
    cylinder.vertex(2*thick,         -thick);

    // Physical properties
    cylinder.setPosition(xPos, yPos);
    cylinder.setStatic(true);
    cylinder.setRestitution(1.0);
    cylinder.setFriction(0.0);
    cylinder.setDamping(0.0);
    cylinder.setFill(0, 102, 153);
    
    world.add(cylinder); 
    return cylinder;
  }
  
  
  FPoly CreatePiston() {
    FPoly piston = new FPoly();
    
    // Vertex geometry
    piston.vertex(0+thick,        0);
    piston.vertex(0+thick,        0+thick);
    piston.vertex(0+cWidth-thick, 0+thick);
    piston.vertex(0+cWidth-thick, 0);
    
    //Physical properties
    piston.setPosition(xPos, yPos+1);
    piston.setRotatable(false);
    piston.setRestitution(1.0);
    piston.setFriction(0.0);
    piston.setDamping(0.0);
    piston.setDensity(1);
    piston.setFill(200, 102, 153);
    piston.setHapticStiffness(10.0);
    piston.setHapticDamping(0.0);
    pistonHeight = piston.getY()-yPos;
    world.add(piston); 

    return piston;
  }
  
  
  GasBody CreateGas() {
    return Gas = new GasBody(volume, numberOfParticles, initialTemp, topLeft, bottomRight);
  }
  
  
  // Updates the physical state of the cylinder and gas contained
  void Update() {
    pistonHeight = Piston.getY()-yPos;
    volume = CalculateVolume();
    Gas.Update(volume);
  }
  
  
  float CalculateVolume() {
      return (0.8-(pistonHeight*0.8/12))*PI*pow(0.2, 2);
  }
}