//Class for Drawing Utils

/**
 * Draws/Modifies the setup of the 3D Audio Visualizer
 **/
void drawSetup() {
  //Point Lighting
  colorMode(RGB);
  pointLight(360, 360, 360, width/2, height/2, width/3);
  colorMode(HSB, 360);

  //Background: Black
  background(0);

  //Draw Floor: Gray
  fill(120, 60);
  noStroke();
  beginShape();
  vertex(0, height, -2*width);
  vertex(width, height, -2*width);
  vertex(width, height, 0);
  vertex(0, height, 0);
  endShape(CLOSE);
}

/**
 * Runs view functions based on current modes
 **/
void drawView() {
  switch(mode) {
  case 1:
    switch(freqMode) {
    case 1:
      frequencyBarsLeft();
      break;
    case 2:
      frequencyBarsMiddle();
      break;
    case 3:
      frequencyBarsLeftDouble();
      break;
    case 4:
      frequencyBarsLeftReverse();
      break;
    case 5:
      frequencyLinesX();
      flash = false;
      break;
    case 6:
      frequencyLinesZ();
      flash = false;
      break;
    case 7:
      frequencyDots();
      break;
    }
    break;
  case 2:
    switch(ampMode) {
    case 1:
      amplitudeBarsSide();
      break;
    case 2:
      amplitudeBarsCorner();
      break;
    case 3: 
      amplitudeBarsMiddle();
      break;
    case 4:
      amplitudeBarsMiddleDouble();
      break;
    case 5:
      amplitudeBarsCornerReverse();
      break;
    }
    break;
  }
}

/**
 * Draw the flash if enabled and decrement flash to give the fading effect
 **/
void drawFlash() {
  //Draw Flash if enabled
  if (flash) {
    fill(360, flashAlpha);
    noStroke();
    pushMatrix();
    //translate(width/2, height/2, -width);
    //box(width, height, 2*width);
    rect(0, 0, width, height);
    popMatrix();
  }
  //Decrement/limit flash
  if (flashAlpha > 240) {
    flashAlpha = 240;
  } else if (flashAlpha >= 8) {
    flashAlpha -= 10;
  } else {
    flashAlpha = 0;
  }
}

/**
 * If the first's sum is significantly greater than the second's sum, increase flash alpha
 * by intensity based on the first sum
 * first: current time
 * second: time - 1
 **/
void flash(ArrayList<Float> first, ArrayList<Float> second) {
  float firstSum = 0;            //Sum of amplitudes at first (current time)
  float secondSum = 0;           //Sum of amplitudes at second (time - 1)
  //float firstBarSum = 0;
  //float secondBarSum = 0;
  for (int i = 0; i < second.size(); i++) {
    firstSum += first.get(i);
    secondSum += second.get(i);
    //if(i < bandsDiv) {
    //firstBarSum += first.get(i);
    //secondBarSum += second.get(i);
    //}
  }
  if (firstSum > secondSum * 2 && firstSum > 3.0) {
    flashAlpha += firstSum * 100 * flashMultiplier;
  }
  //if (firstBarSum > secondBarSum * 4 && firstBarSum > 2.0) {
  //  flashAlpha += firstBarSum * 200 * flashMultiplier;
  //}
}
//void flash() {
//  if(beat.isOnset()) {
//    flashAlpha = 240;
//  }
//}

/**
 * Returns the additional amplitude to add onto the last bar in a row
 * bands: bands to check for significant amplitudes to add
 **/
float addSignificant(ArrayList<Float> bands) {
  float sum = 0;
  for (int j = bandsCount; j < bands.size(); j++) {
    if (bands.get(j) > 0.1) {
      sum += bands.get(j);
    }
  }
  return sum;
}

/**
 * Changes color-change ratio
 **/
void colorChange() {
  colorChangeRatio += colorChangeAmt;
}

/**
 * Fill based on given ratios (range from 0 - 1)
 * hr: hue ratio
 * sr: saturation ratio
 * br: brightness ratio
 * ar: alpha ratio
 **/
void fillRatio(float hr, float sr, float br, float ar) {
  float hue = 360 * hr;
  if (colorChange) {
    hue = Math.abs((360 * hr - colorChangeRatio)) % 360;
  }
  fill(hue, 360 - 360 * sr, 360 - 360 * br, 360 - 360 * ar);
}

/**
 * Draws a bar given a height and location
 * bHeight: height of box to draw
 * i: z location
 * j: x location
 **/
void drawBar(float bHeight, int i, int j) {
  pushMatrix();
  translate(boxSize/2, 0, -boxDepth/2);
  if (flashAlpha > 100 && randomBars) {
  //if (shake > 0) {
    translate(j * boxSize/bandsDiv + random(-boxSize, boxSize), height - bHeight/2, -(i * boxDepth));
  } else {
    translate(j * boxSize/bandsDiv, height - bHeight/2, -(i * boxDepth));
  }
  box(boxSize, bHeight, boxDepth);
  popMatrix();
}
