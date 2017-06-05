/***********************************************************
GUI tab collates all the parameters and methods for the GUI
***********************************************************/

PVector guiPos = new PVector(20*ppcm,4*ppcm);
int guiCount = 0;

void DrawGUI(){
  textAlign(CENTER);
  textSize(62);
  fill(200, 102, 153, 255);
  text("HAPTIC GAS LAB", guiPos.x, guiPos.y+1*ppcm);

  textAlign(RIGHT);
  textSize(32);
  fill(0, 102, 153, 255);
  text("Pressure:", guiPos.x, guiPos.y+3*ppcm);
  text("Volume:", guiPos.x, guiPos.y+4*ppcm);
  text("Temperature:", guiPos.x, guiPos.y+5*ppcm);
  text("Moles:", guiPos.x, guiPos.y+6*ppcm);
  
  if (isPlaying) {
    textAlign(RIGHT);
    textSize(32);
    fill(0, 102, 153, 255);
    float p = round(GasCylinder.Gas.GetPressure()/10);
    float v = round(GasCylinder.Gas.GetVolume()*100000);
    float k = round(GasCylinder.Gas.GetTemperature()*100);
    float n = GasCylinder.Gas.GetMoles();
    
    text(" " + str(p/100) , guiPos.x+2.2*ppcm, guiPos.y+3*ppcm );  
    text(" " + str(v/100), guiPos.x+2.2*ppcm, guiPos.y+4*ppcm );
    text(" " + str(k/100), guiPos.x+2.2*ppcm, guiPos.y+5*ppcm );
    text(" " + str(n), guiPos.x+2.2*ppcm, guiPos.y+6*ppcm );
    
    
    // Unit labels
    textAlign(LEFT);
    text(" kPa" , guiPos.x+2.2*ppcm, guiPos.y+3*ppcm );
    text(" m   x10", guiPos.x+2.2*ppcm, guiPos.y+4*ppcm );
    text(" K", guiPos.x+2.2*ppcm, guiPos.y+5*ppcm );
    text(" mol", guiPos.x+2.2*ppcm, guiPos.y+6*ppcm );
    
    // Add superscript
    textSize(20);
    text("3              -3", guiPos.x+2.9*ppcm, guiPos.y+3.75*ppcm );

    
    float ka = round(GasCylinder.Gas.GetTemperatureActual()*100);
    //text(" " + str(ka/100) + " K", guiPos.x, guiPos.y+6*ppcm );

  }

}