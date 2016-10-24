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

def convert_to_grayscale(image): #function to convert entire image to grayscale. return 2D numpy array
    grey = np.zeros((image.shape[0],image.shape[1])) #initialize 2D numpy array
    for rownum in range(len(image)): #convert image to grayscale using weighted average method
        for colnum in range(len(image[rownum])):
            grey[rownum][colnum]=gs_convert(image[rownum][colnum])
    return grey

def normalize(image): #normalize image intensities to a value between zero and 1
    max = np.amax(image)
    return image/max


#ask user to input path to the picture they wish to upload...
root = tk.Tk()
root.withdraw()
file_path = filedialog.askopenfilename()
print file_path  #print path

image = Image.open(file_path)

image_2=image_resize(image,128,128) #resize pic to 128 by 128 (change to other numbers when we know how many pixels we want)

image_3 = convert_to_grayscale(image_2) #turn image greyscale

image_4 = normalize(image_3) #resize image

plt.imshow(image_3, cmap = matplotlib.cm.Greys) #print image for sanity check
plt.show()



