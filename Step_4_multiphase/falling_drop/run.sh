#!/bin/sh

blockMesh | tee log.blockMesh 
setFields | tee log.setFields
#decomposePar | tee log.decomposePar
#mpirun -n 5 foamRun -parallel | tee log.foamRun
foamRun | tee log.foamRun 
#reconstructPar | tee log.reconstructPar


#------------------------------------------------------------------------------
