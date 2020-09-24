#!/bin/bash

perl -e 'exit 1 if $] < 5.011001'

if [ $? -eq 1 ]
then
  cp -av .github/inc/* blib/lib/
  exit 0
fi
exit 0
