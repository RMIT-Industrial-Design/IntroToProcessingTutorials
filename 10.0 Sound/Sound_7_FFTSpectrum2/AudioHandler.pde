import ddf.minim.analysis.*;
import ddf.minim.*;

static int NUM_EQ_VALS = 12;

float fallSpeed = 0.45f;
float eqMult = 5.0f;

float []eqShape =new float[NUM_EQ_VALS];

class AudioHandler
{
  Minim minim;  
  
  AudioInput in;
  FFT fftLin;
  float []eqVals= new float[NUM_EQ_VALS];
  
  void init(processing.core.PApplet parent)
  {
    minim = new Minim(parent);
    //minim.debugOn(); 
    in = minim.getLineIn(Minim.STEREO, 128);
    fftLin = new FFT(in.bufferSize(), in.sampleRate());
    fftLin.linAverages(NUM_EQ_VALS);
      
    for(int i = 0; i < NUM_EQ_VALS;i++) {
       eqShape[i] = 0.0f;
    }
  }
  
  float []getEqVals()
  {
    float []finalVals = new float[NUM_EQ_VALS];
    
    for(int i = 0; i < NUM_EQ_VALS;i++)
    {
        int indx = triangleIndx[i];
        finalVals[i] = eqVals[indx];  
    }
    
    return finalVals;
  }
  
  void resetEqVals()
  {
      for(int i = 0; i < NUM_EQ_VALS;i++)
      {
           eqVals[i]=0.0f; 
      }
  }
  
  void decreaseSensitivity()
  {
    eqMult -= 0.1f;
    if(eqMult < 0.0f) eqMult=0.0f;
  }
  
  void increaseSensitivity()
  {
    eqMult += 0.1f;
    if(eqMult > 20.0f) 
      eqMult=20.0f;
  }
  
  void update()
  {
      fftLin.forward(in.mix);     
      
      for(int i = 0; i < 12;i++)
      {
        float scaleVal = eqShape[i];
        if(scaleVal <0.0f && scaleVal > -1.0f)
          scaleVal = -1.0f;
        if(scaleVal >=0.0f && scaleVal < 1.0f)
          scaleVal = 1.0f;        
          
        if(scaleVal < 0.0f)
        {
            scaleVal = 1.0f / -scaleVal;
        }
        
        float newVal = fftLin.getAvg(i)*eqMult*scaleVal;
        
        if(newVal > eqVals[i])
          eqVals[i] =newVal;
        else
          eqVals[i] *= fallSpeed+0.5;
      }
  }
  
  void drawEq()
  {   
    float spectrumScale = 2;    
        
    background(0);
    rectMode(CORNERS);
    fill(255);   
    noStroke();
    fftLin.forward(in.mix);

    int w = int(width/NUM_EQ_VALS);
    for(int i = 0; i < NUM_EQ_VALS; i++) 
    {
      fill(255);     
      rect(i*w, height, i*w + w, height - eqVals[i]*spectrumScale);    
    }
  }
  
  void drawEq2(int posx, int posy, int sizex, int sizey)
  {
    fill(55);
    rect(posx,posy,sizex,sizey);
     
    float []eqVals = getEqVals();
    fill(125);
    noStroke();
    for(int i =0; i < NUM_EQ_VALS;i++)
    {
      float mult = eqVals[i];

      if(mult > 1.0f) mult=1.0f;
      noStroke();
      rect(posx+i*20,posy+sizey,18,-sizey*mult);
      float eqOffset =-eqShape[i] * 0.1* (sizey/2);     
//      stroke(0,255,0);
  //    line(posx+i*20,posy+sizey/2+eqOffset,posx+(i+1)*20- 3,posy+sizey/2+eqOffset);
    }    
    
  }
  
  
  AudioInput getInput() { return in; }
 
}
