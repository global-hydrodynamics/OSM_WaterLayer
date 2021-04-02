#!/bin/sh

./s00-link.sh

## for global 5sec
./s01-auto_conv.sh  135 140 35 40

## for Japan 1sec
./s02-conv_1sec.sh  135 140 35 40

exit