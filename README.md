# Your Turn to Roll

This repo contains a simple arduino program, and a processing script. The arduino code should be uploaded to an ESP32 wrover module before attempting to run the processing script. To successfully run everything, you'll need a raspberry pi, an ESP32 wrover module, a monitor, a 3 axis joysick, 2 momentary buttons, and one DPST switch. When all of this is connected, you will be presented with 3 virtual dice of 20, 12, and 6 sides. Since this project is Dungeons and Dragons themed, finding the instructions is going to be an adventure of your own! 

[Video Demo](https://youtu.be/odz9Fv931Ek)
[Video with enclosure](https://youtu.be/Y-qNVOHN09M)


# Table of Contents <!-- omit in toc -->
- [Setup](#setup)
  - [Hardware](#hardware)
  - [Software ](#software)
  - [Getting Started](#running)  


# Setup

## Hardware

This program requires a Raspberry Pi 3b+ running Raspbian GNU/Linux version 10+, aka buster. This also requires a monitor with an HDMI port, an ESP32 wrover module, a monitor, a 3 axis joysick, 2 momentary buttons, and one DPST switch. 

The following is the intended configuration: 

![Image of hardware](images/wiring.jpg)

## Software 

Additionally, please install processing onto your raspberry pi. The [processing webpage](https://pi.processing.org/get-started/) has some very helpful information on that front. Alternatively, run the following command in your pi terminal:
```
curl https://processing.org/download/install-arm.sh | sudo sh
```

## Getting Started
