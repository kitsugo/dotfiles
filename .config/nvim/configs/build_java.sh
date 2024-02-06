#!/bin/sh
export _JAVA_AWT_WM_NONREPARENTING=1
echo $2
java -cp /tmp/eclipse/"$1"/$1*/bin/ "$2"
