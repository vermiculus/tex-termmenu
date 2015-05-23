#!/usr/bin/env sh
arara termmenu.dtx
rm termmenu.zip
rm -rf termmenu
mkdir termmenu
cp  README.md    termmenu/README
cp  termmenu.pdf termmenu/
cp  termmenu.dtx termmenu/
cp  termmenu.ins termmenu/
zip termmenu.zip termmenu/*
echo "Done."
