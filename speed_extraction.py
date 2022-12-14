# -*- coding: utf-8 -*-
"""
Created on Fri Aug 19 20:18:06 2022

@author: ruben
"""
from pynmeagps import NMEAReader

GPSList=[]
speed=[]

#READING GPS NMEA DATA AND EXCRATING SPEED 
with open('cruiseOnly.txt') as f:
    for line in f:
        Line=line.strip()
        if Line[10:16]=="$GNVTG":
            GPSList.append(Line[10:])
            
for line in GPSList:
    message = NMEAReader.parse(line)
    speed.append(message.sogk)

#WRITE SPEED TO TEXT FILE
with open('Speed.txt', 'w') as file:
    for line in speed:
        file.write(str(line))
        file.write('\n')

   
     