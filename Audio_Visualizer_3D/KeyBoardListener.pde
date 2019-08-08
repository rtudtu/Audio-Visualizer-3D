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
    player.skip(-10000);
  }
  if (key == '=' || key == '+') {
    player.skip(10000);
  }
  if (key == 'r' || key == 'R') {
    if (randomBars) {
      randomBars = false;
    } else {
      randomBars = true;
    }
  }
  if (key == 'p' || key == 'P') {
    if (player.isPlaying()) {
      player.pause();
    } else {
      player.play();
    }
  }
  if (key == 'f' || key == 'F') {
    if (flash) {
      flash = false;
    } else {
      flash = true;
    }
  }
  if (key == 'c' || key == 'C') {
    if (colorChange) {
      colorChange = false;
    } else {
      colorChange = true;
    }
  }
  if (key == '9' || key == '(') {
    if (!(bandsDiv <= 1)) {
      bandsDiv /= 2;
    }
  }
  if (key == '0' || key == ')') {
    if (!(boxSize >= width)) {
      bandsDiv *= 2;
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
  if (key == ',' || key == '<') {
    colorChangeAmt -= 1;
  }
  if (key == '.' || key == '>') {
    colorChangeAmt += 1;
  }
  if (key == 'm' || key == 'M') {
    colorChangeAmt = 3;
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
