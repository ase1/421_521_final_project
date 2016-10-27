# Taser (Toast Laser) (Laser Toaster) (iToast) (Toastr)
![This is toast.](https://raw.githubusercontent.com/ase1/421_521_final_project/master/20161020_162631.jpg "This is toast.")

<a name="abstract">
### Abstract
The goal of this project is to create a completely personalized breakfast experience. We will create a device that allows you to wake up to the perfect toast, designed for you. A laser-etching method will be used to burn images, a schedule, an inspirational quote, or the day’s headlines right onto a piece of bread. The device might be set to produce the toast at a particular time (i.e. an alarm clock) or can be used throughout the day. You could upload a selfie (or other images, if those even exist anymore), and the device will automatically process it for printing. We plan to collect data from relevant news websites and social media to allow for an entirely customizable breakfast. 

We will retrofit a laser and an enclosure with controls onto an old 3D printer to create the appliance. Stepper motors will control the position of the laser on the toast. The power of the laser will be modulated at different points on the toast to create different toasting patterns, as dictated by software running on a Raspberry Pi. Software will be developed to combine photos, Web-scraped text, and more into a grayscale image to be burned on the toast, and process this image for printing. This project will aim to recreate the toaster experience using an Arduino to control the knobs, dings, and doors that we’ve all grown to love. 

### Table of Contents
1. [Brainstorming] (#brainstorming)

2. [Safety] (#safety)

<a name="brainstorming">
### Brainstorming
We spent the weekend coming up with ideas, and the crowd favorite is a toast printer. You've seen Jesus toast, and we want to take that one step further. Imagine waking up, checking your calendar, reading the newspaper, and ravenously scrounging for something to eat in the morning. Our idea proposes to combine early morning activities using a toaster with a controllable toast pattern. We're considering creating an appliance that internally works like a laser etcher, with the functions of a toaster. We have a non-working 3D printer that we're willing to scavenge for parts. We plan to design the hardware and software experience. Software for generating G-code for laser etching already exists, so we'd probably implement that and focus our efforts on image processing, content production, and hardware control. 

 - Sensors: 
   - Check if bread is on the plate
   - Check door status (open/closed)
   - Check power level dial
   - Button for start
   - Laser temperature

 - Actuators: 
   - Emergency stop button
   - Eject button (might be fun to have this under a plastic shield)
   - Must include spring actuation and self-deployed toast parachute
   - Move platform
   - Open/close door
   - Ring bell when complete
   - Laser ventilation
   - Alarm clock function that wakes you up to fresh toast

 - If we have time (we won’t have time):
   - Toast flipper
   - Camera on toast (timelapse?) (Twitter?)
   - Butter melter and liquid butter spreader
   - Photo booth


##### Discrete subprojects: 
 - Create lasercutter functionality - hardware
   - Disassemble printer
   - Buy parts
   - Figure out power requirements
   - Safety measures
   - Control 
 - Data grabbing from the internet
   - Date
   - Inspirational quotes
   - News
   - Notifications
 - Compile into an image for image processing
   - Image processing
   - Take existing image and convert to grayscale
   - Create an array of laser voltages per pixel
     - We can just always go line-by-line if that’s easier
   - Send to laser cutter
   - Arduino stuff


<a name="safety">
### Safety (for a device with a full-powered laser)
We can break safety concerns down to three categories: health, fire, and electrical. 

__Health__. The most threatening safety concern is health - pointing a laser at a person for too long could cause blindness or burns. The easiest countermeasure is to buy the lowest-powered laser that will still accomplish our goal. We're ready to do some testing on Thursday using the OEDK laser cutter to see what powers we realistically need for etching the toast, but online research has shown that we won't need more than 1-2 W. For testing, we'll want to modulate that power down to the mW range (typical laser pointers are 5-10 mW) so we can see what we're doing but aren't creating any threat. The final device will have a door that seals the inside off from the outside, so there can be no leakage of light. We can make this door into a physical switch, so the laser can't receive power unless this door is closed. For testing, we'll also have to get some laser safety glasses, which depend on the wavelength of light produced by the laser. 

__Fire__. Another big one, also mostly solved by choosing the right laser. We want to do some testing on the laser that we eventually choose, but if need be, we can solder on a heatsink and provide forced convection with a fan. I don't expect there to be too much smoke produced, since normal toasters don't produce an unreasonable amount of smoke and we plan to only etch the surface of the toast. We want to make the enclosure out of think aluminum or 1/4" wood - the laser shouldn't be high-powered enough to penetrate or ignite either of these. 

__Electrical__. Good insulation practices should resolve any concerns. 
