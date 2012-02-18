---
author: Benjie
date: '2009-09-08 22:33:14'
layout: post
slug: howto-arduino-pin-speed-multiplexing
status: publish
title: 'Howto: Arduino Pin Speed (Multiplexing)'
wordpress_id: '61'
categories:
- Howto
tags:
- Arduino
- Light-emitting diode
---

[![image](http://www.earthshinedesign.co.uk/image/cache/1425313_75-250x250.jpg "8x8 dual colour dot matrix display")](http://www.earthshinedesign.co.uk/index.php?route=product/product&path=38_43&product_id=82)

*This is the beginning of a post from
[about:benjie](http://www.benjiegillam.com/ "Benjie"). If you've written
a blog post you think would be useful to SoutHACKton members, please get
in touch!*

I’m working on a new project, I’ve got a 
[8×8 dual colour dot matrix display](http://www.earthshinedesign.co.uk/index.php?route=product/product&path=38_43&product_id=82 "8x8 dual colour dot matrix display")
(£2.50 delivered from Earthshine Design) and I want to power it from the
[Arduino](http://www.arduino.cc "Arduino"). One way of making a chip
like that (which has 2×8x8 = 128
[LEDs](http://en.wikipedia.org/wiki/Light-emitting_diode "Light-emitting diode"))
would be to have a common ground and an additional 128 pins – one for
each LED. This, I think you’d agree, would be a nightmare, so instead
they’ve basically gone for an 8×16 grid for a total of 24 pins. This
raises two main problems:

1.  You can’t turn 2 arbitrary LEDs on at the same time unless they are
    on the same row/column. (Doing so would actually draw a square of
    LEDs.)
2.  My Arduino doesn’t have enough digital input/output pins

Point 1 is easily solved – we simply update just one row at a time,
letting 
[Persistance Of Vision](http://en.wikipedia.org/wiki/Persistence_of_vision) (POV) do the
hard work for us. Point 2 is the subject of this post –
[multiplexing](http://en.wikipedia.org/wiki/Multiplexing "Multiplexing"),
combining multiple individual signals into just one signal. I will not
be using this dot matrix display in this post, instead I will simply be
powering normal LEDs. I wanted to find out if the Arduino is fast enough
to multiplex the data through just a few pins in order to power this
display. The answer (one of my favourite answers!) is: “Yes, but not
without some hacking.” Read on… 

[Read the rest of this entry on about:benjie »](http://www.benjiegillam.com/2009/09/arduino-pin-speed-multiplexing/#more-224)
