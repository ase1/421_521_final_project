#! /usr/bin/env python

from printrun.printcore import printcore 
from printrun import gcoder
from printrun.pronsole import pronsole
import time

#write stop_print file with 0 in it.... this will turn into a 1 if the user says to stop printing
filename = "stop_print.txt"
fo=open(filename,"wb") #file that will tell print to stop if needed
fo.write('0')
fo.close()



print "your code is running..."

p = printcore('/dev/ttyACM0',250000)

print "you are connected"


gcode = [i.strip() for i in open('gcode.gcode')]

#gcode = gcoder.LightGCode(gcode)

print "your gcode is loaded"

print "printing...."

L = len(gcode)
i = 0
flag = "0"
print L


#while the flag is 0 (i.e. print is not manually stopped)
#and there are still lines to run.... run the lines!
while (i < L and flag == "0"):

    #check if flag is still 0
    with open(filename) as f:
        flag = f.read().replace('\n', '')

    # send code to printer
    p.send_now(gcode[i])
    i += 1 # update counter

#if print was stopped manually, pause the print
if (flag != "0"):
    p.pause()
    print "you have paused your toast job!"
else:
    print "your toast is complete!"

#p.startprint(gcode) #PRINT YOUR CODE!!!
#to prevent system from exiting before the print is done, sleep for 3 minutes.... we can tune thus number later
#time.sleep(180)


p.disconnect()
