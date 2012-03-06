#!/bin/bash

d=`uname -a | grep -i 'darwin'`
[[ $? == 0 ]] && echo "mac" && exit 0

d=`uname -a | grep -i 'gentoo'`
[[ $? == 0 ]] && echo "gentoo" && exit 0

d=`uname -a | grep -i 'arch'`
[[ $? == 0 ]] && echo "arch" && exit 0

