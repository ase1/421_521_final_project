#! /usr/bin/env python

print "your code is running..."

from printrun.printcore import printcore
from printrun import gcoder
from printrun.pronsole import pronsole
import time


# write stop_print file with 0 in it.... this will turn into a 1 if the user says to stop printing
filename = "stop_print.txt"
fo=open(filename,"wb")  # file that will tell print to stop if needed
fo.write('0')
fo.close()

p = printcore('/dev/ttyACM0',250000)

print "you are connected"

gcode = [i.strip() for i in open('gcode.gcode')]

gcode = gcoder.LightGCode(gcode)

print "your gcode is loaded"

print "printing...."

p.startprint(gcode)  # PRINT YOUR CODE!!!

# emergency stop implementation
timeout = time.time() + 180  # the time to stop the print is after 3 minutes
flag = "0" # this is the flag to stop the print

while time.time() < timeout and flag == "0":
    time.sleep(3)  # check every 3 seconds if emergency stop has been enacted...

    # at each loop iteration, check if the flag has changed.....
    with open(filename) as f:
        flag = f.read().replace('\n', '')

    if flag != "0":  # if emergency stop has been enabled, cancel the print
        p.cancelprint()
        print "you have canceled your toasting job!"

if time.time() > timeout:
    print "your toast is complete!"

p.disconnect()






# OLD RUN_PRINT2 CODE
# print "your code is running..."
#
# p = printcore('/dev/ttyACM0',250000)
#
# print "you are connected"
#
#
# gcode = [i.strip() for i in open('gcode.gcode')]
#
# #gcode = gcoder.LightGCode(gcode)
#
# print "your gcode is loaded"
#
# print "printing...."
#
# L = len(gcode)
# i = 0
# flag = "0"
# print L
#
#
# #while the flag is 0 (i.e. print is not manually stopped)
# #and there are still lines to run.... run the lines!
# while (i < L and flag == "0"):
#
#     #check if flag is still 0
#     with open(filename) as f:
#         flag = f.read().replace('\n', '')
#
#     # send code to printer
#     p.send_now(gcode[i])
#     i += 1 # update counter
#
# #if print was stopped manually, pause the print
# if (flag != "0"):
#     p.pause()
#     print "you have paused your toast job!"
# else:
#     print "your toast is complete!"
#
# #p.startprint(gcode) #PRINT YOUR CODE!!!
# #to prevent system from exiting before the print is done, sleep for 3 minutes.... we can tune thus number later
# #time.sleep(180)
#
#
# p.disconnect()
