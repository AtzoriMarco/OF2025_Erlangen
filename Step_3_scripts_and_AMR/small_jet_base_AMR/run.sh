#!/bin/bash


blockMesh > log.blockMesh 2>&1

mpirun -n 1 decomposePar > log.decomposePar 2>&1
mpirun -n 5 foamRun -parallel > log.foamRun 2>&1
mpirun -n 1 reconstructPar > log.reconstructPar 2>&1


