import beads.*; // bring in the beads audio library 
import java.util.Arrays;

class LFO {
  AudioContext ac;
  // create sine, triangle, square and sawtooth waveforms
  WavePlayer sine, triangle, square, sawtooth;
  float freq = 1.0;
  //-----------------
  LFO() {
    ac = new AudioContext();
    sine = new WavePlayer(ac, freq, Buffer.SINE);
    triangle = new WavePlayer(ac, freq, Buffer.TRIANGLE);
    square = new WavePlayer(ac, freq, Buffer.SQUARE);
    sawtooth = new WavePlayer(ac, freq, Buffer.SAW);

    Gain gain = new Gain(ac, 1, 0.0);
    gain.addInput(sine);
    gain.addInput(triangle);
    gain.addInput(square);
    gain.addInput(sawtooth);
    ac.out.addInput(gain);
    ac.start();
  }
  //--SINE
  void set_sine_freq(float _freq) {
    sine.setFrequency(_freq);
  }
  float get_sine() {
    return sine.getValue();
  }
  float get_sine_norm() {
    return map(sine.getValue(), -1.0, 1.0, 0.0, 1.0);
  }
  //--TRIANGLE
  void set_triangle_freq(float _freq) {
    triangle.setFrequency(_freq);
  }
  float get_triangle() {
    return map(triangle.getValue(), -1.0, 2.0, -1.0, 1.0);
  }
  float get_triangle_norm() {
    return map(triangle.getValue(), -1.0, 2.0, 0.0, 1.0);
  }
  //--SQUARE
  void set_square_freq(float _freq) {
    square.setFrequency(_freq);
  }
  float get_square() {
    return square.getValue();
  }
  float get_square_norm() {
    return map(square.getValue(), -1.0, 1.0, 0.0, 1.0);
  }
  //--SAWTOOTH
  void set_sawtooth_freq(float _freq) {
    sawtooth.setFrequency(_freq);
  }
  float get_sawtooth() {
    return sawtooth.getValue();
  }
  float get_sawtooth_norm() {
    return map(sawtooth.getValue(), -1.0, 1.0, 0.0, 1.0);
  }
}