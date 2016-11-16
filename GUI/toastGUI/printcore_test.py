#! /usr/bin/env python

print "your code is running..."


from printrun.printcore import printcore 
from printrun import gcoder
p = printcore('/dev/ttyACM0',250000)

print "you are connected"


gcode = [i.strip() for i in open('gcode.gcode')]

gcode = gcoder.LightGCode(gcode)

print "your gcode is loaded"

p.startprint(gcode) #start print

p.disconnect()
