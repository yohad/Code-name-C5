#!/bin/bash

rm -r corewars_engine/survivors/*

for i in $(ls fighters/); do
    filename=$(basename "$i")
    filename="${filename%.*}"
    echo $filename
    nasm fighters/$i -fbin -o corewars_engine/survivors/${filename}1
    nasm fighters/$i -fbin -o corewars_engine/survivors/${filename}2
done

cd corewars_engine
bash cgx.sh