/**********************************************************************************
Container class creates an instance of a gas container and fills it with a GasBody.
**********************************************************************************/
class Container {
  
  // Container parameters 
  static final float  cHeight       = 13;
  static final float  cWidth        = 6;
  final float         thick         = .5;
  final float         xPos, yPos;
  final PVector       topLeft;
  final PVector       bottomRight;
  
  float               volume;
  float               pistonHeight;
  
  // Physics engine components
  FPoly             Cylinder;
  FPoly             Piston;
  FBox              Bunsen;
  GasBody           Gas;
  
  
  Container(float x, float y) {
    xPos = x;
    yPos = y;
    Cylinder = CreateCylinder();
    Piston = CreatePiston();
    topLeft = new PVector(x-cWidth/2+2*thick,y-cHeight/2+2*thick+2);
    bottomRight = new PVector(x+cWidth/2-2*thick,y+cHeight/2-2*thick);
    volume = CalculateVolume();
    Gas = CreateGas(); //<>//
    Bunsen = CreateBunsen();
  }
  
  
  // Create the cylinder component
  FPoly CreateCylinder() {
    FPoly cylinder = new FPoly();
    
     // Vertex geometry
    cylinder.vertex(-cWidth/2,         -cHeight/2);        //1
    cylinder.vertex(-cWidth/2,         cHeight/2);         //2
    cylinder.vertex(cWidth/2,          cHeight/2);         //3
    cylinder.vertex(cWidth/2,          -cHeight/2);        //4
    cylinder.vertex(cWidth/2-2*thick,  -cHeight/2);        //5
    cylinder.vertex(cWidth/2-2*thick,  -cHeight/2+thick);  //6
    cylinder.vertex(cWidth/2-thick,    -cHeight/2+thick);  //7
    cylinder.vertex(cWidth/2-thick,    cHeight/2-thick);   //8

    cylinder.vertex(-cWidth/2+thick,     cHeight/2-thick);   //9
    cylinder.vertex(-cWidth/2+thick,     -cHeight/2+thick);  //10
    cylinder.vertex(-cWidth/2+2*thick,   -cHeight/2+thick);  //11
    cylinder.vertex(-cWidth/2+2*thick,   -cHeight/2);        //12

    // Physical properties
    cylinder.setPosition(xPos, yPos);
    cylinder.setStatic(true);
    cylinder.setRestitution(1.0);
    cylinder.setFriction(0.0);
    cylinder.setDamping(0.0);
    cylinder.setFill(0, 102, 153,100);
    cylinder.attachImage(cylinderImage);
    cylinder.setGrabbable(false);
    
    world.add(cylinder); 
    return cylinder;
  }
  
  
  FPoly CreatePiston() {
    FPoly piston = new FPoly();
    
    // Vertex geometry
    piston.vertex(-cWidth/2+thick, -thick/2);
    piston.vertex(-cWidth/2+thick, thick/2);
    piston.vertex(cWidth/2-thick,  thick/2);
    piston.vertex(cWidth/2-thick,  -thick/2);
    
    //Physical properties
    piston.setPosition(xPos, yPos-cHeight/2+2*thick);
    piston.setRotatable(false);
    piston.setRestitution(1);
    piston.setFriction(0.0);
    piston.setDamping(15.0);
    piston.setDensity(0.5);
    //piston.setFill(0, 102, 153,100);
    piston.attachImage(pistonImage);
    
    piston.setHapticStiffness(50.0);
    piston.setHapticDamping(0.1);
    pistonHeight = piston.getY()-yPos;
    if (isHapticSimulation){
      piston.setGrabbable(false);
    }
    else {
      piston.setGrabbable(true);
    }
    world.add(piston); 

    return piston;
  }
  
  
  GasBody CreateGas() {
    return Gas = new GasBody(volume, numberOfParticles, initialTemp, topLeft, bottomRight);
  }
  
  
  // Updates the physical state of the cylinder and gas contained
  void Update() {
    pistonHeight = Piston.getY()-yPos+cHeight/2;
    volume = CalculateVolume();
    Gas.Update(volume);
  }
  

FBox CreateBunsen() {
  FBox bunsen = new FBox(7,.8);
  
  bunsen.setPosition(3.8+3.5, 15.5);
  bunsen.setStatic(true);
  bunsen.setFill(100,100,100);
  
  world.addBody(bunsen);
  return bunsen;
}

void UpdateBunsen() {
  int r;
  int g;
  int b;
  //if (restitution <= 1) {
    r = 100 + int((restitution-1)*500);
    g = 100 - int((restitution-1)*500)/2;
    b = 100 - int((restitution-1)*500)/2;
    Bunsen.setFill(r,g,b);

  
}
  
  float CalculateVolume() {
      return (0.8-(pistonHeight*0.8/12))*PI*pow(0.2, 2);
  }
}