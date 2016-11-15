from PIL import Image, ImageDraw, ImageFont
import textwrap

tweet = "If I don't get a girlfriend by tomorrow I will throw a toaster in my bathtub and cannonball dive in that bitch"



#set font
font = ImageFont.truetype("comic_sans.ttf", 14)


#set sizes of pic
MAX_W, MAX_H = 128, 128

testImg = Image.new('L',(MAX_W,MAX_H),"white")
draw = ImageDraw.Draw(testImg)

margin = offset = 12
for line in textwrap.wrap(tweet, width = 20):
    w,h = draw.textsize(line, font = font)
    draw.text(((MAX_W -w)/2, offset), line, font=font, fill="black")
    offset = offset +  font.getsize(line)[1]


testImg.show()

testImg.save("text_picture.png")