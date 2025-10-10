#!/bin/sh

blockMesh | tee log.blockMesh 

foamRunNew -solver incompressibleFluidNew | tee log.foamRunNew_with_newModule
foamRun -solver incompressibleFluidNew | tee log.foamRun_with_newModule  
foamRunNew -solver incompressibleFluid | tee log.foamRunNew_with_oldModule

#------------------------------------------------------------------------------
