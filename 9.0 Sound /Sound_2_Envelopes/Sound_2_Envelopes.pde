/**
 * Processing Sound Library, Example 2
 * 
 * This sketch shows how to use envelopes and oscillators. 
 * Envelopes describe to course of amplitude over time. 
 * The Sound library provides an ASR envelope which stands for 
 * attack, sustain, release. 
 * 
 *       .________
 *      .          ---
 *     .              --- 
 *    .                  ---
 *    A       S        R 
 */

import processing.sound.*;

// Oscillator and envelope 
TriOsc triOsc;
Env env; 

// Times and levels for the ASR envelope
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.2;
float releaseTime = 0.2;

// This is an octave in MIDI notes.
int[] midiSequence = { 
  60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
}; 

// Set the duration between the notes
int duration = 200;
// Set the note trigger
int trigger = 0; 

// An index to count up the notes
int note = 0; 

void setup() {
  size(640, 360);
  background(255);

  // Create triangle wave and envelope 
  triOsc = new TriOsc(this);
  env  = new Env(this);
}

void draw() { 

  // If value of trigger is equal to the computer clock and if not all 
  // notes have been played yet, the next note gets triggered.
  if ((millis() > trigger) && (note<midiSequence.length)) {

    // midiToFreq transforms the MIDI value into a frequency in Hz which we use 
    //to control the triangle oscillator with an amplitute of 0.8
    triOsc.play(midiToFreq(midiSequence[note]), 0.8);

    // The envelope gets triggered with the oscillator as input and the times and 
    // levels we defined earlier
    env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);

    // Create the new trigger according to predefined durations and speed
    trigger = millis() + duration;

    // Advance by one note in the midiSequence;
    note++; 

    // Loop the sequence
    if (note == 12) {
      note = 0;
    }
  }
} 

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}