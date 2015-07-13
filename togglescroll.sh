#!/bin/bash
if synclient -l | grep "VertEdgeScroll .*=.*0" ; then
    synclient VertEdgeScroll=1 ;
    synclient VertTwoFingerScroll=1 ;
else
    synclient VertEdgeScroll=0 ;
    synclient VertTwoFingerScroll=0 ;
fi
