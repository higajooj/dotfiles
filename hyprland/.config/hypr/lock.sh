#!/bin/bash

img=/tmp/swaylock.png

grim $img
magick $img -scale 10% -scale 1000% $img
swaylock -f -K -e -i $img
hyprctl dispatch "dpms" off
