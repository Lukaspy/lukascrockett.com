---
layout: post
title:  "Wii Wireless Sensor Bar Battery-less mod"
date:   2018-01-14
---

Earlier today I got out the ol' wii to setup for my younger brother and low and behold the wireless rechargable sensor bar had finally given up the ghost. These 
sensor bars are relatively simple so I figured the most likely reason it died was the old batteries. I cracked it open and the NiMH batteries had indeed begun 
leaking.<img src="{{'/assets/img/posts/2018-01-14/case_open.jpg' | prepend: site.baseurl }}" alt="case opened"> Desoldering the batteries allowed the bar to power on properly, but it was constantly trying to charge the nonexistant battery pack. <img src="{{ '/assets/img/posts/2018-01-14/battery_removed.jpg' | prepend: site.baseurl }}" alt="battery removed">If I tried
activating the bar it would simply restart into charging mode. I had to trick the bar into thinking that the batteries (That were no longer there) were fully 
charged. If you take some thin wire and solder it between the positive of the battery pad and the 5volt input from the usb mini jack, it will work correctly 
(Obviouly it would have to allways be plugged into usb, but that was not a problem for me.) <img src="{{     '/assets/img/posts/2018-01-14/battery-mod.jpg' | prepend: site.baseurl }}" alt="modded"> This is a rather ugly hack, but it was done on a ten year old
consumer product, so I don't really care! Hope this helped you out.
