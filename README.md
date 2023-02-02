# loascript

## Requirements
- Logitech mouse
- Logitech gaming software allowing script
- some understanding of code reading (to fix coordinate if necessary)

## How To Use
![image](https://user-images.githubusercontent.com/11356984/198976250-a01dbc4e-18b9-4362-8620-bea182399db5.png)
- Right Click on Default (or any profile you would like to put a script)
- Check "Set As Persistence" (if using with Lost Ark profile then no need for this)
- Click Scripting and paste the loa.lua in

(may look differernt if you use a different version of software)


## Available Features
- check_coordinate()
  - script outputs the x and y coordinate value
- market(n, r)
  - buy "n" number of max quantity that is in "r"th row
  - e.g. under trade skill -> fishing loot, buy n=30 times of max quantity of an item that is in "6"th row (i.e. Fish)
- auction_gem(n)
  - buy "n" number of gem in Auction House
  - e.g. while searching for a tier 3 level 1 gem in lowest price sort, buy "150" gems repeadtly 
- mail(n)
  - retrieve attachment and delete mails of "n" pages
- hazardous()*
  - guild request: Hazardous Water Breakthrough in left of SV dead waters
  - only route 1 time and end up in a safe zone
- hazardous_repeat(n)*
  - guild request: Hazardous Water Breakthrough in left of SV dead waters
  - repeat "n" times and repair after every 2 complete round trip
  
*: in addition to checking coordinate, you need to adjust the trip time based on your condition of ship
