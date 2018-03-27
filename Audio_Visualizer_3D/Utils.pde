//Class for Utils

/**
 * 
 **/
ArrayList<Float> toList(float[] arr) {
  ArrayList<Float> list = new ArrayList<Float>();
  for (int i = 0; i < arr.length; i++) {
    list.add(arr[i]);
  }
  return list;
}

float floatListSum(ArrayList<Float> floats) {
  float sum = 0;
  for (int i = 0; i < floats.size(); i++) {
    sum += floats.get(i);
  }
  return sum;
}

void updateHistory() {
  for (int i = history.size() - 1; i > 0; i--) {
    ArrayList<Float> previous = history.get(i - 1);
    if (previous.isEmpty()) {
      continue;
    }
    history.set(i, previous);
  }
  ArrayList<Float> temp = toList(fft.spectrum);
  history.set(0, temp);
}

void updateAmpHistory() {
    for (int i = ampHistory.size() - 1; i > 0; i--) {
    ArrayList<Float> previous = ampHistory.get(i - 1);
    if (previous.isEmpty()) {
      continue;
    }
    ampHistory.set(i, previous);
  }
  float sum = 0;
  for (int i = 0; i < bandsCount; i++) {
    sum += history.get(0).get(i);
  }
  for (int i = amplitudes.size() - 1; i > 0; i--) {
    float previous = amplitudes.get(i - 1);
    amplitudes.set(i, previous);
  }
  amplitudes.set(0, sum);
  ArrayList<Float> tmp = new ArrayList<Float>();
  for (int i = 0; i < amplitudes.size(); i++) {
    tmp.add(amplitudes.get(i));
  }
  ampHistory.set(0, tmp);
}
