#!/bin/sh
cache=`cat "aa.txt" | awk '$1=="Cached:" {print $2}' | datamash mean 1`
tst=`cat "a.txt" | awk '{print $1}' | datamash mean 1`
echo $tst  
echo $cache