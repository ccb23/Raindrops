/*
 * mtXControl Arduino Firmware
 */
// word is same as unsigend int

#include <Wire.h>
#include <Rainbowduino.h>
#include "data.h"

#define BAUD_RATE 9600
#define DEFAULT_SPEED 4000

Rainbowduino rainbow = Rainbowduino(10);

byte game[24]; 

word current_delay = 0;
word current_speed = DEFAULT_SPEED;

int x = 4;
int y = 8;

boolean r = 1;
boolean g = 0;
boolean b = 0;

void setup_timer();
void reset();
void check_serial(int n);
void next_color();
byte read_serial();
byte wait_and_read_serial();

volatile boolean running = false;

void setup_timer() {
  TCCR2A = 0;
  TCCR2B = 1<<CS22 | 0<<CS21 | 0<<CS20;
  //Timer2 Overflow Interrupt Enable
  TIMSK2 = 1<<TOIE2;
  TCNT2 = 0 ;
  sei();
}

//Timer2 overflow interrupt vector handler
ISR(TIMER2_OVF_vect) {
  rainbow.draw();
}

void setup() {
  Serial.begin(BAUD_RATE);
  Wire.begin(0);
  Wire.onReceive(check_serial);
  reset();

  rainbow.set_frame(1, s0);
  rainbow.set_frame(2, top);
  rainbow.set_frame(3, bottom);
  rainbow.set_frame(4, left);
  rainbow.set_frame(5, right);
  rainbow.set_frame(6, s4);
  rainbow.set_frame(7, s3);
  rainbow.set_frame(8, s2);
  rainbow.set_frame(9, s1);

  rainbow.set_frame(0, game);

  setup_timer();
}

void reset() {
  rainbow.reset();
  for(byte i = 0; i < 24; i++) {
    game[i] = 0;
  }  
  running = false;
  current_delay = 0;
  current_speed = DEFAULT_SPEED;
}

void loop() {
  if(!running) start();
  delayMicroseconds(100); 
  next_frame();
  //Serial.write(rainbow.dnum_frames());
}

void start() {
  rainbow.set_frame_nr(6);
  delay(1000);
  rainbow.set_frame_nr(1);
  delay(50); 

  rainbow.set_frame_nr(7);
  delay(1000);
  rainbow.set_frame_nr(1);
  delay(50); 

  rainbow.set_frame_nr(8);
  delay(1000);
  rainbow.set_frame_nr(1);
  delay(50); 

  rainbow.set_frame_nr(9);
  delay(1200);   

  rainbow.set_frame_nr(0); 
  running = true;
}

void finish() {
  running = false;
  rainbow.set_frame(0, w);    
  for(int k = 0; k < 7; k++ ) {
    rainbow.set_frame_nr(0);
    delay(100);
    rainbow.set_frame_nr(1);
    delay(80); 
  }

  rainbow.set_frame_nr(0);      
  reset();
  delay(2000);
  rainbow.set_frame_nr(1);       
  delay(2000);
}


void next_frame() {
  if(current_delay < 1) {
    shift_frame();
    rainbow.set_frame(0, game);
    current_delay = current_speed / (y+1); // / rows /rows * 300;
  }
  current_delay--;
}

void  shift_frame() {
  for(byte i = 0; i < 24; i++) { 
    game[i] = get_pixel(i);
  }
  if(game[2] - game[0] == 0 ||  game[1] - game[0] == 0) finish();
}

byte get_pixel(byte i) {
  if( i == 23 )  return 1 << random(10);
  if( i == 0 )  return 1 << x;
  if( i < 21) return game[i+3];
  return 0;
}

void check_serial(int n) {
  if( !Wire.available()) return; // if( !Serial.available() ) return;
  byte value = read_serial();
  if( value == 255 ) {
    int p = read_serial() / 10;
    int r = read_serial() / 10;
    if(!running) return;
    int ax = x;
    int ay = y;
    x = (ax * 4 + p * 6) / 10;
    y = (ay * 4 + r * 6) / 10;
    game[0] = 1 << x;
    rainbow.set_frame(0, game);
    rainbow.set_frame_nr(0);
  }

  if( value == 254 ) rainbow.set_frame_nr(1);
  if( value == 253 ) rainbow.set_frame_nr(2);
  if( value == 252 ) rainbow.set_frame_nr(3);
  if( value == 251 ) rainbow.set_frame_nr(4);
  if( value == 250 ) rainbow.set_frame_nr(5);
}

byte read_serial() {
  return Wire.receive(); //Serial.read();
}

byte wait_and_read_serial() {
  while( !Wire.available() );
  return read_serial();
}

