#!/bin/bash
size1="1"
size2="5"
kb="kb"
for i in {1..7};
do
    echo $size1
    fallocate -l $size1$kb data/$size1.in
    echo $size2
    fallocate -l $size2$kb data/$size2.in
    size1+="0"
    size2+="0"
done
