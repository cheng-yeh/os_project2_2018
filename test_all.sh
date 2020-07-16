#!/usr/bin/env bash

TMP=$(mktemp -u)

echo "***** Start Testing *****" >&2

for master_method in fcntl mmap; do
    for slave_method in fcntl mmap; do

        echo -e "----- Master method ($master_method), Slave method ($slave_method) -----\n"
        for file in $(ls -1 data | grep -v .out$); do
            true > $TMP
            echo "File: "$file""
            echo "user_program/master data/"$file" $master_method" >&2
            echo "user_program/slave data/"$file".out $slave_method 127.0.0.1" >&2
            
            echo "Master:"
            user_program/master data/"$file" $master_method 2>&1 &
            user_program/slave data/"$file".out $slave_method 127.0.0.1 >$TMP 2>$TMP &
            wait

            echo "Slave:"
            cat $TMP

            diff -q data/"$file" data/"$file".out
            echo ""
        done

    done
done 

echo "***** Test Finished *****" >&2
