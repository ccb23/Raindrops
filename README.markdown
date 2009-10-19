# Raindrops

This is the *Raindrops Rainbowduino Game*. It’s a Rainbowduino connected via I2C to an Arduino with an Accelerometer. 
The current position/movement is determined and send via the I2C Bus to the Rainbowduino. With that you can move the 
red dot on the Matrix and avoid hitting the falling blue raindrops. But if you do so, the game is over. Tilting the 
devices influences the speed of the drops as well.... Have fun!

[Please see my Demo video here](http://www.vimeo.com/6916458)


## Used Components:

* [Rainbowduino](http://www.seeedstudio.com/depot/rainbowduino-led-driver-platform-plug-and-shine-p-371.html)
* [8x8 RGB LED Matrix](http://www.seeedstudio.com/depot/60mm-square-88-led-matrix-super-bright-rgb-p-113.html)
* [Accelerometer ADXL330](http://www.seeedstudio.com/depot/wiimote-3axis-accelerometer-module-adxl330-p-107.html)
* [Arduino](http://www.arduino.cc)

## Usage:

First, get the [Rainbowduino.h Library](http://github.com/rngtng/mtXcontrol/tree/master/firmware/rainbowduino/) and put it into
your Arduino IDE Library (or in the same folder as the sources). Second, do the same with the [Accelerometer Library found here](http://www.seeedstudio.com/depot/wiimote-3axis-accelerometer-module-adxl330-p-107.html).

Now, compile both sketches and upload the Server.pde sketch to the Accelerometer, upload Client.pde to the Rainbowduino. 
You are ready to go! Have fun!

## License
The MIT License

Copyright © 2009 ccb23

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
