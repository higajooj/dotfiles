#!/bin/sh

hyprctl dispatch 'hl.dsp.dpms("on")'
pidof hyprlock || hyprlock &
sleep 1
hyprctl dispatch 'hl.dsp.dpms("off")'
