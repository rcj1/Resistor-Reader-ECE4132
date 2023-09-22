# Resistor-Reader-ECE4132

This is the MATLAB code for my Resistor Reader university project from the Spring 2022 semester. 

## Running the code
To run the code, simply run RUNME.m with the path to your image as the function argument. The image will be displayed on the screen, and after a few seconds, the detected resistors will be displayed, along with their resistances and tolerances.

## Explanation of the code
The workflow of the code is as follows:
* Binarize the image to detect resistors as darker areas on a lighter background.
* Filter the darker areas (blobs) such that only blobs that could be resistors based on overall size and shape are processed further.
* Zoom in on each resistor candidate and use the Hough transform to locate lines (boundaries of resistor bands).
* Sample the colors between the lines.
* Use support-vector machine to match rgb color coordinates to appropriate color words.
* Use the resistor band rules to translate a series of color words into a resistance and tolerance value of each resistor.
