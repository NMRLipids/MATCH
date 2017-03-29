#!/bin/bash
#Model from http://dx.doi.org/10.5281/zenodo.13281

wget https://zenodo.org/record/13281/files/popcCHOL15molPER0-25ns.trr
wget https://zenodo.org/record/13281/files/popcCHOL15molPER25-50ns.trr
wget https://zenodo.org/record/13281/files/POPCchol7.tpr

gmx trjcat -f popcCHOL15molPER0-25ns.trr popcCHOL15molPER25-50ns.trr -o trajectory.xtc
mv POPCchol7.tpr topol.tpr

rm popcCHOL15molPER0-25ns.trr popcCHOL15molPER25-50ns.trr


