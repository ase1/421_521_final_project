import Tkinter as tk
import tkFileDialog as filedialog
from PIL import Image
import matplotlib.cm
import numpy as np
import matplotlib.pyplot as plt

def image_resize(image,x,y): #define a function to resize an image to x width and y height
    im_2=image.resize((x, y))
    return np.asarray(im_2)

def gs_convert(pixel): #function to convert image pixel to greyscale using weighted average method from RGB image
    return .299*pixel[0] + .587*pixel[1] * .114*pixel[2]

def convert_to_grayscale(image): # function to convert entire image to grayscale. return 2D numpy array
    grey = np.zeros((image.shape[0],image.shape[1])) #initialize 2D numpy array
    for rownum in range(len(image)): # convert image to grayscale using weighted average method
        for colnum in range(len(image[rownum])):
            grey[rownum][colnum]=gs_convert(image[rownum][colnum])
    return grey

def normalize(image): # normalize image intensities to a value between zero and 1
    max = np.amax(image)
    return image/max


imagename = "image_path.txt"

with open(imagename) as f:
    file_path = f.read().replace('\n','')


print file_path  # print path

image = Image.open(file_path)

image_2=image_resize(image,128,128) #resize pic to 128 by 128 (change to other numbers when we know how many pixels we want)

image_3 = convert_to_grayscale(image_2) #turn image greyscale

image_4 = normalize(image_3) #normalize image to power percentatges at each voxel image

plt.imshow(image_4, cmap = matplotlib.cm.Greys) #print image for sanity check
plt.show()


#Now, flatten this matrix into a vector of powers in the desired order. Also create x and y matrices corresponding
def flatten(image):
    N=np.size(image)
    S=np.shape(image)
    x_max = S[0]

    print N

    # initialize vectors
    X=np.zeros(N)
    Y=np.zeros(N)
    P=np.zeros(N)

    # initialize counters
    inc=1
    x=0
    y=0

    for i in range(0,N-1):
        print x,y
        X[i]=x
        Y[i]=y
        P[i]=image[x,y]

        # update counter vars
        if inc == 1:
            if x < x_max-1:
                x = x + 1
            elif x == x_max-1:
                y = y + 1
                inc = 0

        elif inc == 0:
            if x > 0:
                x = x - 1
            elif x == 0:
                y=y+1
                inc = 1

    return X,Y,P


X,Y,P = flatten(image_4)
print X[0:10], Y[0:10], P[0:10]

def rescale(X,x_new_min,x_new_max):
    x_old_min=min(X)
    x_old_max=max(X)
    X_new = (X-x_old_min)/(x_old_max -x_old_min)*(x_new_max -x_new_min) + x_new_min
    return X_new

X_new = rescale(X,0,100)
#print X_new[0:10]

Y_new = rescale(Y,150,40)
#print Y_new[0:10]


fo=open("gcode.gcode","wb")

#need to add header and opening G CODE
fo.write(';********Laser Toasted G CODE********** \n')
fo.write(';**** By Kenny Groszman, Andrew Elsey ******* \n')
fo.write(';**** Rice University, BIOE 421, Dr. Jordan Miller **** \n')
fo.write('G90 ; Absolute Coordinates \n')
fo.write('M3 S0 ; Laser Off \n')
fo.write('G28 ; motors go Home \n')


#WRITE BODY GCODE
for i in range(len(X_new)):
    str = 'G0'+' X'+repr(X_new[i])+' Y'+repr(Y_new[i]) + ' F6000\n'
    fo.write(str)


#SHUTDOWN ROUTINE
fo.write('G28; platforms go home \n')
fo.write('G0 Y560 \n')
fo.write('M3 S0 ; turn laser PWM to zero \n')


fo.close()


