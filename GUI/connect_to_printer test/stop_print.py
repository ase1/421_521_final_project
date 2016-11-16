#! /usr/bin/env python

print "your code is running..."


from printrun.printcore import printcore 
from printrun import gcoder
from printrun.pronsole import pronsole
import time


p = printcore('/dev/ttyACM0',250000)

print "you are connected"

p.disconnect()
