#!/bin/bash

img=/tmp/i3lock.png

scrot -z -o $img
magick $img -scale 10% -scale 1000% $img
i3lock -i $img
