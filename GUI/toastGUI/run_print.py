#! /usr/bin/env python

print "your code is running..."


from printrun.printcore import printcore 
from printrun import gcoder
from printrun.pronsole import pronsole
import time


p = printcore('/dev/ttyACM0',250000)

print "you are connected"


gcode = [i.strip() for i in open('gcode.gcode')]

gcode = gcoder.LightGCode(gcode)

print "your gcode is loaded"

print "printing...."

p.startprint(gcode) #PRINT YOUR CODE!!!

#to prevent system from exiting before the print is done, sleep for 3 minutes.... we can tune thus number later
time.sleep(300)

print "your toast is complete!"

p.disconnect()