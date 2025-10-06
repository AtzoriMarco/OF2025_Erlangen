#!/bin/bash

blockMesh | tee log.blockMesh 2>&1
surfaceFeatures | tee log.surfaceFeatures 2>&1
snappyHexMesh | tee log.snappyHexMesh 2>&1
checkMesh | tee log.checkMesh 2>&1

decomposePar | tee log.decomposePar 2>&1
mpirun -n 5 foamRun -parallel | tee log.foamRun 2>&1
reconstructPar | tee log.reconstructPar 2>&1


