#!/bin/bash

# https://github.com/microsoft/WSL/issues/4106
export MYIP=`grep nameserver /etc/resolv.conf | cut '-d ' -f2`

export DISPLAY="${MYIP}:0.0"
az login
