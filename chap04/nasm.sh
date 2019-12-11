#!/bin/bash

if [ $# -ne 1 ]; then
    exit
fi

nasm -felf64 ${1}.asm -o ${1}.o
ld -o ${1} ${1}.o
chmod u+x ${1}
