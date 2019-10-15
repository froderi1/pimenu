#!/bin/bash
# Für multilevel Menus
#key=$(echo "$*" | awk 'NF>1{print $NF}')

MQTTHOST="192.168.178.12"

case $1 in
  slideshow)
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/lr/feh" -m "power"
    ;;
  meteo)
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/lr/feh" -m "meteo"
    ;;
  wetter)
    cd
    ;;
  licht_kugel_klein)
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m $1
    echo "licht" >> text
    ;;
  pause)
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m $1
    echo "pause" >> text
    ;;
#  music)
#    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m $1
#    echo "music" >> text
#    ;;
  reserved)
    cd
    ;;
#  Kill das ganze menu wenn action leer war
  '')
    ps aux | grep -ie pimenu | awk '{print $2}' | xargs kill -9
    ;;
  radio_off)
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m $1
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m "y_dvd"
    sleep 2
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m "y_off"
    ;;
  *)
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m $1
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m "y_on"
    sleep 2
    /usr/bin/mosquitto_pub -h $MQTTHOST -t "/home/radio" -m "y_vcr1"
    ;;
esac
sleep 1
