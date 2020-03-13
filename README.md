# Emergency-Brake-Assist-System

## Overview
In the automotive industry one of the growing causes for
accidents is when drivers accidentally press the gas pedal
instead of the brake pedal. With the rapid advance of machine
learning and computer vision algorithms EBAS uses RADAR sensors to provide
a very accurate estimation of the distance between your front
bumper and the car in front. Using MATLAB I have designed and implemented the EBAS system.

## Steps

<li>1) Process live input video from a vehicles front camerare</li>
<li>2) Perform image filtering techniques on each video frame to showcase the lane markings

<img src="https://github.com/Esedicol/Emergency-Brake-Assist-System/blob/master/ImageFiltering.png" />
<li>3) Locate Region of Interest </li>
<li>4) Apply Hough Transform Algorithm to detect hard lines </li>
<li>5) Visualize detected lane and perform distance extraction </li>

<img src="https://github.com/Esedicol/Emergency-Brake-Assist-System/blob/master/EBAS.png">

## Conclusion
After reaching the end of the project I have concluded that to
accurately measure the distance from an object, the best
approach is to use an actual Radar sensor for accurate distance extraction. This paper proved
that EBAS is possible using a camera but the accuracy of using
such approach is very inaccurate.
