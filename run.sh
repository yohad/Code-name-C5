#!/bin/bash

rm -r corewars_engine/survivors/*

for i in $(ls competitors/); do
    filename=$(basename "$i")
    cp competitors/${filename} corewars_engine/survivors/${filename}
done

for i in $(ls fighters/); do
    filename=$(basename "$i")
    filename="${filename%.*}"
    echo $filename
    nasm fighters/$i -fbin -o corewars_engine/survivors/${filename}
done

cd corewars_engine
bash cgx.sh
