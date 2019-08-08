/*************************************************************************
 * Final Project                        // Date: April 18, 2018
 * ARTG 2260: Programming Basics        // Instructor: Jose
 * Written By: Richard Tu               // Email: tu.r@husky.neu.edu
 * Title: 3D Audio Visualizer
 * Description: Displays a given audio file in a 3D visual view
 * Commands:
 * <UP>, <DOWN>, <LEFT>, <RIGHT> - rotate Camera based on origin
 * <->, <+> - jump forward/backward 10 seconds
 * <f> - turn flash on/off
 * <r> - turn shake/random bars on/off
 * <c> - turn color change on/off
 * <p> - play/pause the song/visualizer
 * <[>, <]>, <\> - decrease, increase, and reset flash multiplier respectively
 * <,>, <.>, <m> - decrease, increase, and reset color changing speed
 * <9>, <0> - decrease and increase # of bars shown
 * <'> - toggle view from back
 *************************************************************************/
//Libraries
import java.util.List;
import ddf.minim.*;
import ddf.minim.analysis.*;

//AudioIn in;                                //Audio input
//SoundFile song;                            //Song to play
FFT fft;                                   //Fast Fourier Transform Analyzer
Minim minim;                               //Minim
AudioPlayer player;                        //AudioPlayer (song)
BeatDetect beat;                           //Beat detect

int bands = 1024;                          //# of bands
int bandsCount = 256;                      //First bandsCount bands in bands to display
int bandsDiv = 4;                          //Display bandsCount/bandsDiv bars
int rotateCountX = 0;                      //Rotate angle X
int rotateCountY = 0;                      //Rotate angle Y
int boxDepth = 100;                        //Depth of each displayed band (overidden in setup)
int historySize;                           //Number of histories to keep
int mode = 1;                              //Current mode
int modes = 2;                             //Number of available modes
int freqMode = 1;                          //Current frequency mode
int freqModes = 7;                         //Number of available frequency modes
int ampMode = 1;                           //Current amplitude mode
int ampModes = 5;                          //Number of available amplitude modes
int colorChangeRatio = 0;                  //Index on color spectrum Hue in HSB
int colorChangeAmt = 3;                    //Amount to increment index of color spectrum
int shake = 0;                             

float flashAlpha = 0;                      //Alpha of flash box
float flashMultiplier = 1;                 //Multiplier on adding to flashAlpha
float boxSize = 1;                         //size of boxes (in pixels) on bandsDiv and bandsCount

boolean flash = false;                     //Toggle strobe
boolean backView = false;                  //Toggle view from back
boolean colorChange = false;               //Toggle color changing
boolean randomBars = false;                //Toggle shaking/random bars

ArrayList<ArrayList<Float>> history = new ArrayList<ArrayList<Float>>();    //History of spectrums
ArrayList<ArrayList<Float>> ampHistory = new ArrayList<ArrayList<Float>>(); //History of amplitudes
ArrayList<Float> amplitudes = new ArrayList<Float>();                       //Current amplitudes
ArrayList<Float> spectrum = new ArrayList<Float>();                         //Spectrum of FFT


void setup() {
  println("SETUP FLAG: START");
  fullScreen(P3D);                         //3D Fullscreen
  colorMode(HSB, 360);                     //Hue, Saturation, Brightness, Max value 360

  historySize = 2*width/boxDepth;          //Number of history bars
  boxDepth = width/40;                     //Normalize BoxDepth

  minim = new Minim(this);                 //Initialize minim

  //Load path to song
  final String dataFolderPath = "\\D:\\Documents\\Processing Projects\\Audio_Visualizer_3D\\data\\";
  final String songName = "awSpectre.mp3";
  player = minim.loadFile(dataFolderPath + songName, 1024);
  player.loop();

  fft = new FFT(player.bufferSize(), player.sampleRate());    //Initialize FFT

  beat = new BeatDetect();                                    //Initialize BeatDetect

  //Populate history with empty ArrayLists<Float>'s
  for (int i = 0; i < historySize; i++) {
    history.add(new ArrayList<Float>());
  }
  //Populate ampHistory with empty ArrayLists<Float>'s
  for (int i = 0; i < historySize; i++) {
    ampHistory.add(new ArrayList<Float>());
  }
  //Populate amplitudes with 0.0s
  for (int i = 0; i < bandsCount/bandsDiv; i++) {
    amplitudes.add(0.0);
  }
  println("SETUP FLAG: END");
}

void draw() { 
  //Draw lighting, background, floor
  drawSetup();

  //Rotate screen
  rotateY(rotateCountY * .004);      //Rotate screenY
  rotateX(rotateCountX * .004);      //Rotate screenX

  //****************Testing****************\\
  //textSize(100);
  //fill(360, 180);
  //text(colorChangeAmt, 600, 500, -200);
  //text(flashAlpha, 900, 500, -200);
  //text(flashMultiplier, 1400, 500, -200);
  //text(player.position(), 1900, 500, -200);
  //text(player.length(), 2400, 500, -200);
  //***************************************\\

  //Get current spectrum
  fft.forward(player.mix);
  //ArrayList<Float> temp = toList(fft.getSpectrumReal());
  ArrayList<Float> temp = toList(fft.getSpectrumReal());
  spectrum = new ArrayList<Float>(temp.subList(0, bandsCount));
  for (int i = 0; i < spectrum.size(); i++) {
    spectrum.set(i, Math.abs(spectrum.get(i)));
  }

  //Detect beat
  beat.detect(player.mix);

  //if(beat.isOnset()) {
  //  shake = 100;
  //}
  //shake -= 10;
  
  //Update history
  updateHistory();

  //Update ampHistory
  if (mode == 2) {
    updateAmpHistory();
  }

  //Update boxSize (incase of change in bandsCount or bandsDiv)
  boxSize = width/(bandsCount/bandsDiv);    //Size of boxes (x-direction) to fit width

  //Set camera to back if enabled
  if (backView) {
    camera(width/2, height/2, -2*width - 1, width/2, height/2, 0, 0, 1, 0);
  }
  
  //Draw history bars based on mode
  drawView();

  //Update color change
  if (colorChange) {
    colorChange();
  }

  //Draw flash
  flash(history.get(0), history.get(1));
  drawFlash();

  //Listen for keyboard inputs
  keyBoardListener();
}
