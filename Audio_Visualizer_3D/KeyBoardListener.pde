//Class for KeyBoard Inputs

/**
 * Listens for keypresses
 **/
void keyBoardListener() {
  if (keyPressed) {
    //If UP/DOWN/RIGHT/LEFT are pressed, rotate screen
    if (keyCode == UP) {
      rotateCountX -= 10;
    }
    if (keyCode == DOWN) {
      rotateCountX += 10;
    }
    if (keyCode == RIGHT) {
      rotateCountY -= 10;
    }
    if (keyCode == LEFT) {
      rotateCountY += 10;
    }
    //If space is pressed, reset to default rotation
    if (key == '/') {
      rotateCountY = 0;
      rotateCountX = 0;
    }
  }
}

/**
 * Listens for keypresses once (Ignores key after held down)
 **/
void keyPressed() {
  if (key == '-' || key == '_') {
    playbackRate -= .2;
    song.rate(playbackRate);
  }
  if (key == '=' || key == '+') {
    playbackRate += .2;
    song.rate(playbackRate);
  }
  if (key == '0') {
    playbackRate = 1;
    song.rate(playbackRate);
  }
  if (key == 'f') {
    if (flash) {
      flash = false;
    } else {
      flash = true;
    }
  }
  if (key == ']' || key == '}') {
    flashMultiplier += .1;
  }
  if (key == '[' || key == '{') {
    flashMultiplier -= .1;
  }
  if (key == '\\') {
    flashMultiplier = 1;
  }
  if (key == '\'') {
    if (backView) {
      backView = false;
      camera();
    } else {
      backView = true;
    }
  }
  switch(key) {
  case '1': //If already mode 1, increment freqMode, otherwise set to mode 1
    if (mode == 1) {
      freqMode += 1;
    } else {
      mode = 1;
    }
    if (freqMode > freqModes) {
      freqMode = 1;
    }
    camera();
    break;
  case '2': //If already mode 2, increment ampMode, otherwise set to mode 2
    if (mode == 2) {
      ampMode += 1;
    } else {
      mode = 2;
    }
    if (ampMode > ampModes) {
      ampMode = 1;
    }
    camera();
    break;
  }
}

//if (key == 'p') {
//  if (playing) {
//    song.stop();
//    playing = false;
//  } else {
//    song.loop();
//    fft = new FFT(this, bands);
//    fft.input(song);
//    playing = true;
//  }
//}
//Different camera angle
//camera(width/2, height/4, width/2, 
//  width/2, height*3/4, -width/3, 
//  0, 1, 0);
