//Class for Views

/**
 * Draws the history based on frequency bars displayed from low to high (left to right)
 **/
void frequencyBarsLeft() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);    //Current list of bands (playing now)
    float hRatio = (float)i/history.size();            //(i/Total i's)
    //If empty, skip
    if (current.isEmpty()) {
      continue;
    }
    //If first row of bars, check to flash or not
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    //Draw bands
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float sum = 0;                       //Sum of bandsDiv amplitude bars
      float additional = 0;                //Additional amplitude for the last bar displayed
      float bRatio = (float)j/bandsCount;  //(j/Total displayed bands)
      float boxHeight = 0;                 //Normalized height of box
      if (j == bandsCount - bandsDiv) {
        additional = addSignificant(current);
      }
      //Average next bandsDiv bands
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      sum = sum/bandsDiv; //Average
      boxHeight = (sum + additional) * height * 5; //Normalize
      //Color first row with white outline and fade other rows
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio, 0, hRatio, hRatio);
        noStroke();
      }
      drawBar(boxHeight, i, j);
    }
  }
}

/**
 * Draws the history based on frequency bars displayed from low to high (middle to out)
 **/
void frequencyBarsMiddle() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);
    float hRatio = (float)i/history.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float sum = 0;
      float additional = 0;
      float bRatio = (float)j/bandsCount;
      float boxHeight = 0;

      if (j == bandsCount - bandsDiv) {
        additional = addSignificant(current);
      }
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      sum = sum/bandsDiv;
      boxHeight = (sum + additional) * height * 5;
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio, 0, hRatio, hRatio);
        noStroke();
      }
      if ((j/bandsDiv) % 2 == 0) {
        drawBar(boxHeight, i, current.size()/8 + 1 + j/2);
      } else {
        drawBar(boxHeight, i, current.size()/8 - 1 - j/2);
      }
    }
  }
}

///**
// * Draws the history based on frequency bars displayed from low to high (left to right)
// **/
//void frequencyBarsRight() {
//  for (int i = 0; i < history.size(); i++) {
//    ArrayList<Float> current = history.get(i);    //Current list of bands (playing now)
//    float hRatio = (float)i/history.size();            //(i/Total i's)
//    //If empty, skip
//    if (current.isEmpty()) {
//      continue;
//    }
//    //If first row of bars, check to flash or not
//    if (i == 0) {
//      flash(history.get(0), history.get(1));
//    }
//    //Draw bands
//    for (int j = 0; j < bandsCount; j += bandsDiv) {
//      float sum = 0;                       //Sum of bandsDiv amplitude bars
//      float additional = 0;                //Additional amplitude for the last bar displayed
//      float bRatio = (float)j/bandsCount;  //(j/Total displayed bands)
//      float boxHeight = 0;                 //Normalized height of box
//      if (j == bandsCount - bandsDiv) {
//        additional = addSignificant(current);
//      }
//      //Average next bandsDiv bands
//      for (int k = j; k < j + bandsDiv; k++) {
//        sum += current.get(k);
//      }
//      sum = sum/bandsDiv; //Average
//      boxHeight = (sum + additional) * height * 5; //Normalize
//      //Color first row with white outline and fade other rows
//      if (i == 0) {
//        fillRatio(bRatio, 0, 0, 0);
//        strokeWeight(5);
//        stroke(360);
//      } else {
//        fillRatio(bRatio, 0, hRatio, hRatio);
//        noStroke();
//      }
//      drawBar(boxHeight, i, current.size()/4 - j);
//    }
//  }
//}

/**
 * Draws the history based on frequency bars displayed from low to high (left to right)
 **/
void frequencyBarsLeftDouble() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);
    float hRatio = (float)i/history.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float sum = 0;
      float additional = 0;
      float bRatio = (float)j/bandsCount;
      float boxHeight = 0;
      if (j == bandsCount - bandsDiv) {
        additional = addSignificant(current);
      }
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      sum = sum/bandsDiv; //Average
      boxHeight = ((sum + additional) * height * 5)/2;
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio, 0, hRatio, hRatio);
        noStroke();
      }
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(j * boxSize/bandsDiv, 0 + boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(j * boxSize/bandsDiv, height - boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
    }
  }
}

/**
 * Draws the history based on frequency bars displayed from low to high (left to right)
 **/
void frequencyBarsLeftReverse() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);
    float hRatio = (float)i/history.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float sum = 0;
      float additional = 0;
      float bRatio = (float)j/bandsCount;
      float boxHeight = 0;
      if (j == bandsCount - bandsDiv) {
        additional = addSignificant(current);
      }
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      sum = sum/bandsDiv;
      boxHeight = (height/2) - ((sum + additional) * height * 5)/2; //Normalize
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio, 0, hRatio, hRatio);
        noStroke();
      }
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(j * boxSize/bandsDiv, 0 + boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(j * boxSize/bandsDiv, height - boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
    }
  }
}

/**
 * Draws the history based on frequency lines displayed from low to high (left to right)
 **/
void frequencyLinesX() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);
    float hRatio = (float)i/history.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float bRatio = (float)j/bandsCount;
      float sum = 0;
      float sumNext = 0;
      float boxHeight = 0;
      float boxHeightNext = 0;
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      for (int k = j + bandsDiv; k < j + bandsDiv * 2; k++) {
        sumNext += current.get(k);
      }
      sum = sum/bandsDiv;
      sumNext = sumNext/bandsDiv;
      boxHeight = sum * height * 5;
      boxHeightNext = sumNext * height * 5;
      strokeWeight(5);
      stroke(360 * bRatio, 360, 360 - 360 * hRatio, 360 - 360 * hRatio);
      if(!(j + bandsDiv >= bandsCount)) {
      line((j + bandsDiv/2) * boxSize/bandsDiv, height - boxHeight, -(i * boxDepth), 
        ((j + bandsDiv/2) + bandsDiv) * boxSize/bandsDiv, height - boxHeightNext, -(i * boxDepth));
      }
      if (i == 0) {
        strokeWeight(25);
        point((j + bandsDiv/2) * boxSize/bandsDiv, height - boxHeight, -(i * boxDepth));
      }
    }
  }
}


/**
 * Draws the history based on frequency lines displayed from low to high (left to right)
 **/
void frequencyLinesZ() {
  for (int i = 0; i < history.size() - 1; i++) {
    ArrayList<Float> current = history.get(i);
    float hRatio = (float)i/history.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float bRatio = (float)j/bandsCount;
      float sum = 0;
      float sumNext = 0;
      float boxHeight = 0;
      float boxHeightNext = 0;
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      for (int k = j; k < j + bandsDiv; k++) {
        sumNext += history.get(i + 1).get(k);
      }
      sum = sum/bandsDiv;
      sumNext = sumNext/bandsDiv;
      boxHeight = sum * height * 5;
      boxHeightNext = sumNext * height * 5;
      strokeWeight(5);
      stroke(360 * bRatio, 360, 360 - 360 * hRatio, 360 - 360 * hRatio);
      line((j + bandsDiv/2) * boxSize/bandsDiv, height - boxHeight, -(i * boxDepth), 
        (j + bandsDiv/2) * boxSize/bandsDiv, height - boxHeightNext, -((i + 1) * boxDepth));
      if (i == 0) {
        strokeWeight(10);
        line((j + bandsDiv/2) * boxSize/bandsDiv, height - boxHeight, -(i * boxDepth), 
          (j + bandsDiv/2) * boxSize/bandsDiv, height, -(i * boxDepth));
        strokeWeight(25);
        point((j + bandsDiv/2) * boxSize/bandsDiv, height - boxHeight, -(i * boxDepth));
      }
    }
  }
}

/**
 * Draws the history based on frequency dots displayed from low to high (left to right)
 **/
void frequencyDots() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);
    float hRatio = (float)i/history.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j += bandsDiv) {
      float bRatio = (float)j/bandsCount;
      float sum = 0;
      float boxHeight = 0;
      for (int k = j; k < j + bandsDiv; k++) {
        sum += current.get(k);
      }
      sum = sum/bandsDiv;
      boxHeight = sum * height * 5;
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
      } else {
        fillRatio(bRatio, 0, hRatio, hRatio);
      }
      strokeWeight(5);
      stroke(360 * bRatio, 360, 360 - 360 * hRatio, 360 - 360 * hRatio);
      pushMatrix();
      translate(j * boxSize/bandsDiv, height - boxHeight, -(i * boxDepth));
      point(0, 0, 0);
      popMatrix();
    }
  }
}

/**
 * Draws the history based on amplitude (displayed from front row/side)
 **/
void amplitudeBarsSide() {
  for (int i = 0; i < history.size(); i++) {
    ArrayList<Float> current = history.get(i);
    float sum = 0;
    float hRatio = (float)i/history.size();
    float boxHeight = 0;
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < bandsCount; j++) {
      sum += current.get(j);
    }
    boxHeight = sum * height/8; //Normalize
    for (int j = 0; j < bandsCount; j += 4) {
      float bRatio = (float)j/bandsCount;
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio, 0, hRatio, hRatio);
        noStroke();
      }
      drawBar(boxHeight, i, j);
    }
  }
}

/**
 * Draws the history based on amplitude (displayed from front left corner)
 **/
void amplitudeBarsCorner() {
  for (int i = 0; i < ampHistory.size(); i++) {
    ArrayList<Float> current = ampHistory.get(i);
    float hRatio = (float)i/ampHistory.size();
    if (current.isEmpty()) {
      continue;
    }    
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < current.size(); j++) {
      float bRatio = (float)j/current.size();
      float amp = current.get(j);
      float boxHeight = amp * height/8;
      if (i == 0) {
        fillRatio(bRatio/2 + hRatio/2, 0, 0, 0);
        strokeWeight(5 - 4 * hRatio);
        stroke(360, 360 - 360 * hRatio);
      } else {
        fillRatio(bRatio/2 + hRatio/2, 0, hRatio, hRatio);
        noStroke();
      }
      drawBar(boxHeight, i, j * bandsDiv);
    }
  }
}

/**
 * Draws the history based on amplitude (displayed from front middle)
 **/
void amplitudeBarsMiddle() {
  for (int i = 0; i < ampHistory.size(); i++) {
    ArrayList<Float> current = ampHistory.get(i);
    float hRatio = (float)i/ampHistory.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < current.size()/2; j++) {
      float bRatio = (float)j/current.size();
      float amp = current.get(j);
      float boxHeight = amp * height/8;
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio/2 + hRatio/2, 0, hRatio, hRatio);
        noStroke();
      }
      drawBar(boxHeight, i, (current.size()/2 - 1 - j)*bandsDiv);
      drawBar(boxHeight, i, (current.size()/2 - 1 + j)*bandsDiv);
    }
  }
}

/**
 * Draws the history based on amplitude (displayed from front middle)
 **/
void amplitudeBarsMiddleDouble() {
  for (int i = 0; i < ampHistory.size(); i++) {
    ArrayList<Float> current = ampHistory.get(i);
    float hRatio = (float)i/ampHistory.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < current.size()/2; j++) {
      float bRatio = (float)j/current.size();
      float amp = current.get(j);
      float boxHeight = (amp * height/8)/2;
      if (i == 0) {
        fillRatio(bRatio, 0, 0, 0);
        strokeWeight(5);
        stroke(360);
      } else {
        fillRatio(bRatio/2 + hRatio/2, 0, hRatio, hRatio);
        noStroke();
      }
      //drawBar(boxHeight, i, (current.size()/2 - 1 - j)*bandsDiv);
      //drawBar(boxHeight, i, (current.size()/2 - 1 + j)*bandsDiv);
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(((current.size()/2 - 1 - j) * bandsDiv) * boxSize/bandsDiv, 0 + boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(((current.size()/2 - 1 - j) * bandsDiv) * boxSize/bandsDiv, height - boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(((current.size()/2 - 1 + j) * bandsDiv) * boxSize/bandsDiv, height - boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate(((current.size()/2 - 1 + j) * bandsDiv) * boxSize/bandsDiv, 0 + boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
    }
  }
}

/**
 * Draws the history based on amplitude (displayed from front left corner)
 **/
void amplitudeBarsCornerReverse() {
  for (int i = 0; i < ampHistory.size(); i++) {
    ArrayList<Float> current = ampHistory.get(i);
    float hRatio = (float)i/ampHistory.size();
    if (current.isEmpty()) {
      continue;
    }
    if (i == 0) {
      flash(history.get(0), history.get(1));
    }
    for (int j = 0; j < current.size(); j++) {
      float bRatio = (float)j/current.size();
      float amp = current.get(j);
      float boxHeight = (height/2) - (amp * height/8)/2;
      if (i == 0) {
        fillRatio(bRatio/2 + hRatio/2, 0, 0, 0);
        strokeWeight(5 - 4 * hRatio);
        stroke(360, 360 - 360 * hRatio);
      } else {
        fillRatio(bRatio/2 + hRatio/2, 0, hRatio, hRatio);
        noStroke();
      }
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate((j * bandsDiv) * boxSize/bandsDiv, 0 + boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
      pushMatrix();
      translate(boxSize/2, 0, -boxDepth/2);
      translate((j * bandsDiv) * boxSize/bandsDiv, height - boxHeight/2, -(i * boxDepth));
      box(boxSize, boxHeight, boxDepth);
      popMatrix();
    }
  }
}


//Cool but costly alternative (Add below fillRatio in else statement):
//stroke(120, 360, 360, 240 - 240 * hRatio);
//strokeWeight(1);
