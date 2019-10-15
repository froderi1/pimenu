#!/usr/bin/python2
import paho.mqtt.client as mqtt
import os
import time

os.system("mpc stop")
os.system("mpc clear")

def station_nr(station):
   os.system("mpc stop")
   os.system("mpc clear")
   os.system("mpc load stations")
   os.system("mpc play " + station)

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("home/piradio")

def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.payload))
    print(str(msg.payload))

    if str(msg.payload) == "power":
        print(msg.topic + str(msg.payload))
	os.system("mpc_onoff.sh")

    if str(msg.payload) == "station":
        print(msg.topic + str(msg.payload))
	# read station number from text file
	f = open('/home/pi/radio/station.txt', 'r')
	station = int(f.read())
	f.close
	print("station_change")
	station += 1
	if station > 5:
	    station = 1
	print (str(station))
	os.system("mpc play " + str(station))
	f = open('/home/pi/radio/station.txt', 'w')
	f.write('%d' % station)
	f.close

    if str(msg.payload) == "oldies":
          station_nr("1")

    if str(msg.payload) == "relax":
          station_nr("2")

    if str(msg.payload) == "fip":
          station_nr("3")

    if str(msg.payload) == "fip_rock":
          station_nr("4")

    if str(msg.payload) == "fip_jazz":
          station_nr("5")

    if str(msg.payload) == "fip_groove":
          station_nr("6")

    if str(msg.payload) == "fip_reggae":
          station_nr("7")

    if str(msg.payload) == "wdr2":
          station_nr("8")

    if str(msg.payload) == "wdr4":
          station_nr("9")


client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("debian", 1883, 60)

client.loop_forever()
