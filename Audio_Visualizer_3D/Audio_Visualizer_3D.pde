/*************************************************************************
 * Final Project                        // Date: March 17, 2018
 * ARTG 2260: Programming Basics        // Instructor: Jose
 * Written By: Richard Tu               // Email: tu.r@husky.neu.edu
 * Title: 3D Audio Visualizer
 * Description: Displays a given audio file in a 3D visual manner
 *************************************************************************/
//Libraries
import processing.sound.*;
import java.util.List;

//AudioIn in;
SoundFile song;                            //Song to play
FFT fft;                                   //Fast Fourier Transform Analyzer

int bands = 1024;                          //# of bands
int bandsCount = 256;                      //First bandsCount bands in bands to display
int bandsDiv = 4;                          //Display bandsCount/bandsDiv bars
int rotateCountX = 0;                      //Rotate angle X
int rotateCountY = 0;                      //Rotate angle Y
int boxDepth = 100;                        //Depth of each displayed band
int historySize;                           //Number of histories to keep
int mode = 1;                              //Current mode
int modes = 2;                             //Number of available modes
int freqMode = 1;                          //Current frequency mode
int freqModes = 7;                         //Number of available frequency modes
int ampMode = 1;                           //Current amplitude mode
int ampModes = 5;                          //Number of available amplitude modes

float playbackRate = 1;                    //Playback Rate
float flashAlpha = 0;                      //Alpha of flash box
float flashMultiplier = 1;                 //Multiplier on adding to flashAlpha
float boxSize = 1;

boolean playing = true;                    //If song is playing or not
boolean flash = true;                      //Toggle strobe
boolean backView = false;                  //Toggle view from back

ArrayList<ArrayList<Float>> history = new ArrayList<ArrayList<Float>>();    //History of spectrums
ArrayList<ArrayList<Float>> ampHistory = new ArrayList<ArrayList<Float>>(); //History of amplitudes
ArrayList<Float> amplitudes = new ArrayList<Float>();                       //Current amplitudes

void setup() {
  fullScreen(P3D);              //3D Fullscreen
  colorMode(HSB, 360);          //Hue, Saturation, Brightness, Max value 360

  historySize = 2*width/boxDepth;               //Number of history bars
  song = new SoundFile(this, "awSpectre.mp3");  //Song file

  //start the Audio Input
  //in = new AudioIn(this, 0);
  //in.start();

  song.loop();                  //play the song
  fft = new FFT(this, bands);   //Rout into the Amplitude analyzer
  fft.input(song);              //Patch the input SoundFile

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
}

void draw() { 
  //Draw lighting, background, floor
  drawSetup();

  //Rotate screen
  rotateY(rotateCountY * .004);      //Rotate screenY
  rotateX(rotateCountX * .004);      //Rotate screenX

  //****************Testing****************\\
  textSize(100);
  fill(360, 180);
  text(playbackRate, 500, 500, -200);
  text(flashAlpha, 900, 500, -200);
  text(flashMultiplier, 1400, 500, -200);
  //***************************************\\

  //Get current spectrum
  fft.analyze();

  //Update history
  updateHistory();

  //Update ampHistory
  if (mode == 2) {
    updateAmpHistory();
  }

  //Update boxSize (incase of change in bandsCount or bandsDiv)
  boxSize = width/(bandsCount/bandsDiv);    //Size of boxes (x-direction) to fit width

  //Draw history bars based on mode
  drawView();

  //Set camera to back if enabled
  if (backView) {
    camera(width/2, height/2, -2*width - 1, width/2, height/2, 0, 0, 1, 0);
  }

  //Draw flash
  drawFlash();

  //Listen for keyboard inputs
  keyBoardListener();
}
