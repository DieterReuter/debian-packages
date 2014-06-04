#!/bin/sh

mkdir -p test/control test/data
cd test
ar x ../example_1.0.0.0-alpha_i386.deb
tar xvf control.tar.gz -C control
tar xvf data.tar.gz -C data

