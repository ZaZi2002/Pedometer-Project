# Pedometer Project

## Overview

This project simulates a pedometer system using two methods:
1. Analog circuit simulation with LTSpice
2. Signal processing and analysis using MATLAB

## LTSpice Simulation

![Pedometer full circuit](https://github.com/user-attachments/assets/2d1206a0-a9df-4628-8680-411362b8c149)

The LTSpice simulation includes the following components:
- **Input Signal**: Represents the accelerometer data.
- **Pre-Amplifier**: Amplifies the input signal.
- **Low Pass Filter**: Removes high-frequency noise.
- **High Pass Filter**: Removes low-frequency noise.
- **Comparator**: Converts the filtered signal into a digital signal.
- **Binary Counter**: Counts the number of steps based on the digital signal.

## MATLAB Code
![Filtered signals 1](https://github.com/user-attachments/assets/a8c62ed6-3427-4cbc-9d97-d1107f06abd6)

The MATLAB code processes accelerometer data to simulate a pedometer. The key steps include:

1. **Loading Data**: Loads the recorded accelerometer data.
2. **Generating Noisy Signals**: Adds white noise to the X, Y, and Z axis data.
3. **Filtering Signals**: Applies a bandpass filter to the noisy signals.
4. **Generating Accelerometer Signal**: Combines the X, Y, and Z axis signals to generate a single accelerometer signal.
5. **Generating Pulse Wave**: Creates a pulse signal based on a predefined threshold.
6. **Counting Steps**: Counts the number of steps detected from the pulse signal.

## Results

- **Noisy Signal Plots**: Visual representation of the noisy signals for X, Y, and Z axes.
- **Filtered Signal Plots**: Visual representation of the filtered signals for X, Y, and Z axes.
- **Combined Signal Plot**: Shows the combined accelerometer signal.
- **Fourier Transform Plot**: Provides frequency domain analysis of the combined signal.
- **Pulse Signal Plot**: Displays the generated pulse signal indicating detected steps.
- **Steps Count**: Shows the total number of steps detected.

## Requirements

- MATLAB
- LTSpice (for analog simulation)
