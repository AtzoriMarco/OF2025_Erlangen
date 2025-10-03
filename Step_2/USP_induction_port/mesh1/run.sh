#!/bin/bash

mkdir 0 


blockMesh > log.blockMesh 2>&1
surfaceFeatures > log.surfaceFeatures 2>&1
snappyHexMesh > log.snappyHexMesh 2>&1
checkMesh > log.checkMesh 2>&1

cp 0.orig/* 0


#mpirun -n 1 decomposePar > log.decomposePar 2>&1
#mpirun -n 5 foamRun -parallel > log.foamRun 2>&1
#mpirun -n 1 reconstructPar > log.reconstructPar 2>&1


