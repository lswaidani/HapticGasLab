FBox bunsen;

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
    bunsen.setFill(r,g,b);

  
}