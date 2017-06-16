/***********************************************************
GUI tab collates all the parameters and methods for the GUI
***********************************************************/

PVector guiPos = new PVector(20*ppcm,3.2*ppcm);
int guiCount = 0;

void DrawGUI(){
  textAlign(CENTER);
  textSize(78);
  fill(200, 102, 153, 255);
  text("HAPTIC GAS LAB", guiPos.x, guiPos.y+0.1*ppcm);
  
  textSize(46);
  text("Equations",guiPos.x, guiPos.y+8*ppcm);

  textAlign(RIGHT);
  textSize(32);
  fill(0, 102, 153, 255);
  text("Pressure:", guiPos.x, guiPos.y+2*ppcm);
  text("Volume:", guiPos.x, guiPos.y+3*ppcm);
  text("Temperature:", guiPos.x, guiPos.y+4*ppcm);
  text("Moles:", guiPos.x, guiPos.y+5*ppcm);
  

  text("Ideal gas equation", guiPos.x, guiPos.y+9*ppcm);
  text("Kinetic Temperature", guiPos.x, guiPos.y+10*ppcm);

  
  if (isPlaying) {
    textAlign(RIGHT);
    textSize(32);
    fill(0, 102, 153, 255);
    float p = round(GasCylinder.Gas.GetPressure()/10);
    float v = round(GasCylinder.Gas.GetVolume()*100000);
    int k = round(GasCylinder.Gas.GetTemperature());
    int ka = round(GasCylinder.Gas.GetTemperatureActual());
    float n = GasCylinder.Gas.GetMoles();
    
    text(" " + str(p/100) , guiPos.x+2.5*ppcm, guiPos.y+2*ppcm );  
    text(" " + str(v/100), guiPos.x+2.5*ppcm, guiPos.y+3*ppcm );
    text(" " + str(ka), guiPos.x+2.5*ppcm, guiPos.y+4*ppcm );
    text(" " + str(n), guiPos.x+2.5*ppcm, guiPos.y+5*ppcm );
    textAlign(LEFT);
    textSize(36);
    text("-    PV = nRT", guiPos.x+0.6*ppcm, guiPos.y+9*ppcm );
    text("-    T = v  M/3R", guiPos.x+0.6*ppcm, guiPos.y+10*ppcm );

    // Unit labels
    textSize(32);
    textAlign(LEFT);
    text(" kPa" , guiPos.x+2.5*ppcm, guiPos.y+2*ppcm );
    text(" m   x10", guiPos.x+2.5*ppcm, guiPos.y+3*ppcm );
    text(" K   (" +str(k)+" K)", guiPos.x+2.5*ppcm, guiPos.y+4*ppcm );
    text(" mol", guiPos.x+2.5*ppcm, guiPos.y+5*ppcm );
    
    //bunsen text
    fill(0,0,0);
    text(str(k) + " K       Magic Bunsen: [Z] & [X]",11*ppcm, 15.65*ppcm);
    //Pause text
    text("Press [P] to pause",24*ppcm, 15.65*ppcm);

    
    // Add superscript
    textSize(20);
    fill(0, 102, 153, 255);
    text("3            -3", guiPos.x+3.2*ppcm, guiPos.y+2.75*ppcm );
    text("2", guiPos.x+3.05*ppcm, guiPos.y+9.7*ppcm );
    
    //float ka = round(GasCylinder.Gas.GetTemperatureActual()*100);
    //text(" " + str(ka/100) + " K", guiPos.x, guiPos.y+6*ppcm );

  }

}