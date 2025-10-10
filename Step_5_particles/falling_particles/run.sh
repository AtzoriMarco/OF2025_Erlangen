#!/bin/sh

blockMesh | tee log.blockMesh 
foamRun | tee log.foamRun
foamToVTK

#------------------------------------------------------------------------------
